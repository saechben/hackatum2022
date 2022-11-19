from rest_framework import serializers
from .models import OSMIssue

class OSMIssueSerializer(serializers.ModelSerializer):

    lan = serializers.FloatField(required=True)
    lat = serializers.FloatField(required=True)
    osm_way_id = serializers.IntegerField(required=True)
    highway = serializers.CharField(required=True)
    # solved_by = serializers.(required=True)

    class Meta:
        model = OSMIssue
        fields = ['lan', 'lat', 'osm_way_id', 'highway']
