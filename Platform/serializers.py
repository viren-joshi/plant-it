from rest_framework import serializers
from rest_framework.serializers import IntegerField
from .models import *


class SchemesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Schemes
        fields = '__all__'

class CommentsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comments
        fields = '__all__'

class NewsSerializer(serializers.ModelSerializer):
    class Meta:
        model = News
        fields = '__all__'

class FeedSerializer(serializers.ModelSerializer):
    id = IntegerField(required=False)
    comments = CommentsSerializer(many=True, required=False)
    isliked = serializers.SerializerMethodField('is_liked')

    def is_liked(self, Feed):
        # print(Feed.id)
        instance = isLiked.objects.filter(username=self.context.get("username"),post_id = Feed.id)
        # print(instance)
        if instance.exists():
            flag=True
        else:
            flag = False
        return flag

    class Meta:
        model = Feed
        fields = '__all__'