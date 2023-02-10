from django.shortcuts import render
from .models import *

from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response
from rest_framework.authentication import TokenAuthentication
from rest_framework import status

from django.contrib.auth import login as auth_login
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

import json


@api_view(["GET"])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])  # [AllowAny]
def index(request):
    print('hi')
    data = {
        'message':"You are authenticated"
    }
    return Response(data,status=status.HTTP_200_OK)
    
@api_view(["POST"])
@authentication_classes([TokenAuthentication])
@permission_classes([AllowAny])
def signup(request):
    
    data = json.loads(request.body)
    name = data['name']
    user_type = data['user_type']
    username = data['username']
    password = data['password']


    if User.objects.filter(username=username).exists():
        data = {
            'message':'Username Exists',
            'username':username
        }
        return Response(data,status=status.HTTP_226_IM_USED)

    user = User.objects.create_user(username=username,password=password)
    user.save()

    client = UserProfile.objects.create(
        user=user,
        name=name,
        user_type=user_type,
    )
    client.save()

    data = {
        'message':'User created successfully',
        'username':username
    }

    return Response(data,status=status.HTTP_201_CREATED)

@api_view(["POST"])
@authentication_classes([TokenAuthentication])
@permission_classes([AllowAny])
def login(request):

    data = json.loads(request.body)
    username = data['username']
    password = data['password']

    user = authenticate(username=username, password=password)

    if user is not None:
        token = Token.objects.get_or_create(user=user)[0].key
        # print(token)
        auth_login(request,user)
        user_type = UserProfile.objects.get(user=user).user_type

        data = {
            'message':'Success',
            'username':username,
            'user_type':user_type,
            'token':token
        }
        
        return Response(data, status=status.HTTP_202_ACCEPTED)
        
    else:

        data = {
            'message':'Invalid credentials'
        }
        return Response(data, status=status.HTTP_401_UNAUTHORIZED)
    


@api_view(["GET"])
@permission_classes([IsAuthenticated])
@authentication_classes([TokenAuthentication])
def logout(request):
    print(request.user)
    request.user.auth_token.delete()
    auth_logout(request)
    return Response('User Logged out successfully')