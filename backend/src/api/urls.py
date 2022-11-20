from django.urls import path
from .views import ping, LevelDetailAPIView, CTImageListAPIView, CTImageForCategory, UserDetailAPIView, UserStatisticsList, UserStatisticsUpdate, OSMIssueListAPIView, OSMIssueUpdate, OSMIssueDetailAPIView

app_name="api"

urlpatterns = [
    path('ping/', ping, name="ping"),
    path('ctimages/<int:amount>/', CTImageListAPIView.as_view()),
    path('ctimages/<str:category>/<int:amount>/', CTImageForCategory.as_view()),
    path('level/<str:title>/', LevelDetailAPIView.as_view()),
    path('user/<int:id>/', UserDetailAPIView.as_view()),
    path('leaderboard/', UserStatisticsList.as_view()),
    path('statistics/edit/<int:id>/', UserStatisticsUpdate.as_view()),
    path('issues/', OSMIssueListAPIView.as_view()),
    path('issues/edit/<str:longitude>;<str:latitude>/', OSMIssueUpdate.as_view()),
    path('issues/<str:longitude>;<str:latitude>/', OSMIssueDetailAPIView.as_view()),
]
