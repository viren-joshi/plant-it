from django.urls import path
from . import views

urlpatterns = [
    path('schemes/', views.schemes, name='schemes'),
    path('news/', views.news, name='news'),
    path('upload/',views.upload, name='upload'),
    
]