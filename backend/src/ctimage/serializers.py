from rest_framework import serializers
from .models import CTImage

class CTImageSerializer(serializers.ModelSerializer):

    category = serializers.CharField(required=True)
    image_url = serializers.ImageField(required=False)

    class Meta:
        model = CTImage
        fields = ['category', 'image_url']
