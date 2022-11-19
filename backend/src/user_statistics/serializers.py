from rest_framework import serializers
from .models import UserStatistics

class UserStatisticsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserStatistics
        exclude = []

        


