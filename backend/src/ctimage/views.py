from django.shortcuts import render

# Create your views here.
from .models import MyModel
from .serializers import MyModelSerializer
from rest_framework import permissions
from rest_framework.parsers import MultiPartParser, FormParser

class MyModelViewSet(viewsets.ModelViewSet):
    queryset = MyModel.objects.order_by('-creation_date')
    serializer_class = MyModelSerializer
    parser_classes = (MultiPartParser, FormParser)
    permission_classes = [
        permissions.IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(creator=self.request.user)