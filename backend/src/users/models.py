from django.db import models
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
from user_statistics.models import UserStatistics

# Create your models here.
class CustomAccountManager(BaseUserManager):
    def create_superuser(self, email, user_name, first_name, password, **other_fields):
        other_fields.setdefault('is_staff', True)
        other_fields.setdefault('is_superuser', True)
        other_fields.setdefault('is_active', True)

        if other_fields.get('is_staff') is not True:
            raise ValueError("Superuser must be assigned to is_staff=True.")
        if other_fields.get('is_superuser') is not True:
            raise ValueError("Superuser must be assigned to is_superuser=True.")

        return self.create_user(email, user_name, first_name, password, **other_fields)

    def create_user(self, email, user_name, first_name, password, **other_fields):
        if not email:
            raise ValueError(_("You must provide an email address"))

        email = self.normalize_email(email)
        statistics = UserStatistics()
        statistics.save()
        print(statistics)
        user = self.model(email=email, user_name=user_name, first_name=first_name, statistics=statistics, **other_fields)
        user.set_password(password)
        user.save()
        return user

def getStatistics():
    return Statistics.objects.get_or_create(id=1)

class CustomUser(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(_("email address"), unique=True)
    # username = models.CharField(max_length=100, unique=True)
    user_name = models.CharField(max_length=100, unique=True)
    first_name = models.CharField(max_length=100, blank=True)
    statistics = models.ForeignKey(UserStatistics, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    objects = CustomAccountManager()

    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = ["user_name", "first_name"]

    def __str__(self):
        return self.user_name
