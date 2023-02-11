from rest_framework import serializers
from .models import *

class SchemesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Schemes
        fields = '__all__'

class NewsSerializer(serializers.ModelSerializer):
    class Meta:
        model = News
        fields = '__all__'

class FeedSerializer(serializers.ModelSerializer):
    class Meta:
        model = Feed
        fields = '__all__'