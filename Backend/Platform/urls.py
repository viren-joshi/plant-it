from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('schemes/', views.schemes, name='schemes'),
    path('news/', views.news, name='news'),
    path('latest/', views.latest, name='latest'),
    path('upload/',views.upload, name='upload'),
    path('feed/', views.feed, name='feed'),
    path('chat/<str:user1>-<str:user2>/', views.chat, name='chat'),
    path('recommend/', views.recommend, name='recommend'),
    path('like/', views.like, name='like'),
    path('comments/', views.comments, name='comments'),
    path('userlist/', views.userlist, name='userlist'),
    
]