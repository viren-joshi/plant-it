from .models import *
from .serializers import *
import os
import json
import requests

from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework import status

from django.core.files.storage import default_storage
from django.conf import settings



def fetch_latest_news():
    print("Fetching Latest News, migrating database.")

    url = '''https://newsapi.org/v2/everything?q="farmer"  and "plants" and "india" &from=2023-01-11&sortBy=publishedAt&apiKey=cd97861cf26741f19e1e4a27d2310f9d&searchIn
    =title,description&language=en'''
    x = requests.get(url)
    data = json.loads(x.text)
    
    keywords = ['india', 'farmer', 'garden', 'plant']

    News.objects.all().delete()

    for i in data["articles"]:
        flag = False
        for k in keywords: 
            if flag: break
            if (k in i['title'].lower() or k in i['description'].lower()) and 'india' in (i['title'].lower() or i['description'].lower()) :
                flag = True
                d = {
                    'source_name' : i['source']['name'], 
                    'author' : i['author'], 
                    'title' : i['title'], 
                    'description' : i['description'], 
                    'url' : i['url'], 
                    'urlToImage' : i['urlToImage'], 
                    'publishedAt' : i['publishedAt'], 
                    'content' : i['content']
                }
                news = News.objects.create(**d)
                news.save()
    
    print("Updated latest news")
                

    

from apscheduler.schedulers.background import BackgroundScheduler
scheduler = BackgroundScheduler()
scheduler.add_job(fetch_latest_news, 'interval', minutes = 10)
scheduler.start()



@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([AllowAny]) # IsAuthenticated
def schemes(request):
    items = Schemes.objects.order_by("pk")
    ser = SchemesSerializer(items, many=True)
    return Response(ser.data)
    

@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([AllowAny]) # IsAuthenticated
def news(request):
    items = News.objects.order_by("pk")
    ser = NewsSerializer(items, many=True)
    return Response(ser.data)
    


@api_view(["POST"])
@authentication_classes([TokenAuthentication])
@permission_classes([AllowAny])
def upload(request):
    print('hi')
    f = request.FILES['file']
    # data = json.loads(request.body)
    # f = data['file']
    # print(f)
    file_name = default_storage.save(f.name, f)
    url = os.path.join(settings.MEDIA_URL,file_name)
    data = {
            'slug' : f'{url}',
            'type' : f.content_type
        }
    print(data)

    return Response(data)