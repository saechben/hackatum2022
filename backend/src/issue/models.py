from django.db import models
from users.models import CustomUser

# Create your models here.
class OSMIssue(models.Model):
    osm_way_id = models.IntegerField(default=0)
    lan = models.FloatField()
    lat = models.FloatField()
    highway = models.CharField(max_length=255, default="primary")
    solved_by = models.ForeignKey(CustomUser, on_delete=models.CASCADE, blank = True, null=True)
    

    def __str__(self):
        return str(self.lan) + " | " + str(self.lat)

