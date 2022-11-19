from django.forms.models import model_to_dict
from django.http import JsonResponse
from django.shortcuts import get_object_or_404
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics, permissions
from level.models import Level
from level.serializers import LevelSerializer
from ctimage.models import CTImage
import random
from ctimage.serializers import CTImageSerializer
from users.models import CustomUser
from issue.models import OSMIssue
from issue.serializers import OSMIssueSerializer
from users.serializers import CustomUserSerializer
from user_statistics.models import UserStatistics
from user_statistics.serializers import UserStatisticsSerializer

# Create your views here.

def ping(request, *args, **kwargs):
    return JsonResponse({"status": "running"})

"""Django Pure API Detail View""" 
# def get_task(request, id, *args, **kwargs):
#     task = get_object_or_404(Task, id=id)
#     return JsonResponse(model_to_dict(task, fields=["id", "title", "description_short"]))

"""Django Rest Framework Detail API View""" 
# @api_view(["GET"])
# def get_task(request, id, *args, **kwargs):
#     task = get_object_or_404(Task, id=id)
#     return Response(TaskSerializer(task).data)

"""Django Rest Framework Generic Detail API View""" 
class LevelDetailAPIView(generics.RetrieveAPIView):
    queryset = Level.objects.all()
    serializer_class = LevelSerializer
    lookup_field = "title"

"""Django Rest Framework Generic Detail API View""" 
class CTImageListAPIView(generics.ListAPIView):
    queryset = CTImage.objects.all()
    serializer_class = CTImageSerializer

    def get_queryset(self):
        amount = self.kwargs['amount']
        qs = super().get_queryset()[:amount]
        id_list = super().get_queryset().values_list('id', flat=True)
        id_list = list(id_list)
        random_id_list = random.sample(id_list, min(len(id_list), amount))
        query_set = CTImage.objects.filter(id__in=random_id_list)
        return query_set

    

"""Django Rest Framework Generic Detail API View""" 
class OSMIssueListAPIView(generics.ListAPIView):
    queryset = OSMIssue.objects.all()
    serializer_class = OSMIssueSerializer

    # def get_queryset(self):
    #     query_set = OSM.objects.filter(id__in=random_id_list)
    #     return query_set



"""Django Rest Framework Generic Detail API View""" 
class CTImageForCategory(generics.ListAPIView):

    queryset = CTImage.objects.all()
    serializer_class = CTImageSerializer

    def get_queryset(self):
        category = self.kwargs['category']
        amount = self.kwargs['amount']
        qs = super().get_queryset().filter(category=category)[:amount]
        id_list = super().get_queryset().values_list('id', flat=True)
        id_list = list(id_list)
        random_id_list = random.sample(id_list, min(len(id_list), amount))
        query_set = CTImage.objects.filter(id__in=random_id_list)
        return query_set

        

"""Django Rest Framework Generic List API View""" 
# class TaskListAPIView(generics.ListAPIView):
#     queryset = Task.objects.all()
#     serializer_class = TaskSerializer



"""Django Rest Framework Generic Detail API View""" 
class UserDetailAPIView(generics.RetrieveAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer
    lookup_field = "id"


"""Django Rest Framework Generic Detail API View""" 
class UserStatisticsList(generics.ListAPIView):
    queryset = CustomUser.objects.all()
    serializer_class = CustomUserSerializer

    def get_queryset(self):
        qs = super().get_queryset().order_by("-statistics__total_correct_count")

        return qs

"""Django Rest Framework Generic Detail API View""" 
class UserStatisticsUpdate(generics.RetrieveUpdateAPIView):
    serializer_class = UserStatisticsSerializer

    def get_object(self):
        user_id = self.kwargs["id"]
        user = get_object_or_404(CustomUser, id=user_id)
        return user.statistics
