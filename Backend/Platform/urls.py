from django.urls import path
from . import views

urlpatterns = [
    path('schemes/', views.schemes, name='schemes'),
    path('news/', views.news, name='news'),
    path('latest/', views.latest, name='latest'),
    path('upload/',views.upload, name='upload'),
    path('feed/', views.feed, name='feed'),
    path('chat/<str:user1>-<str:user2>/', views.chat, name='chat'),
    path('recommend/', views.recommend, name='recommend'),
    
]