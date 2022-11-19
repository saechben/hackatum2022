from django.db import models

# Create your models here.

class UserStatistics(models.Model):
    issues_solved = models.IntegerField(default=0)

    def __str__(self):
        return str(self.issues_solved)
