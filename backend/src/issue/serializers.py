from rest_framework import serializers
from .models import OSMIssue

class OSMIssueSerializer(serializers.ModelSerializer):

    longitude = serializers.FloatField(source="lan", required=True)
    latitude = serializers.FloatField(source="lat", required=True)
    osm_way_id = serializers.IntegerField(required=True)
    highway = serializers.CharField(required=True)
    solved_by_id = serializers.PrimaryKeyRelatedField(source='solved_by', allow_null=True, read_only=True)

    class Meta:
        model = OSMIssue
        fields = ['longitude', 'latitude', 'osm_way_id', 'solved_by_id', 'highway']
