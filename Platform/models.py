from django.db import models
from datetime import datetime

class Schemes(models.Model):

    name = models.CharField(max_length=100, blank=True, null=True)
    description = models.CharField(max_length=2000, blank=True, null=True)

    def __str__(self):
        return f'{self.name}'

class News(models.Model):

    source_name = models.CharField(max_length=100, blank=True, null=True)
    author = models.CharField(max_length=100, blank=True, null=True)
    title = models.CharField(max_length=1000, blank=True, null=True)
    description = models.CharField(max_length=2000, blank=True, null=True)
    url = models.CharField(max_length=100, blank=True, null=True)
    urlToImage = models.CharField(max_length=500, blank=True, null=True)
    publishedAt = models.CharField(max_length=100, blank=True, null=True)
    content = models.CharField(max_length=5000, blank=True, null=True)

    def __str__(self):
        return f'{self.title}'


class Comments(models.Model):
    author = models.CharField(max_length=100, blank=True, null=True)
    comment = models.CharField(max_length=2000, blank=True, null=True)

    def __str__(self):
        return f'{self.author} - {self.comment}'


class Feed(models.Model):

    author = models.CharField(max_length=100, blank=True, null=True)
    user_type = models.CharField(max_length=20, blank=True, null=True)
    image = models.CharField(max_length=200, null=True, blank=True)
    caption = models.CharField(max_length=1000, blank=True, null=True)
    likes = models.IntegerField()
    time = models.DateTimeField(auto_now_add=True)
    comments = models.ManyToManyField(Comments, blank=True, null=True)

    def __str__(self):
        return f'{self.author} - {self.caption}'