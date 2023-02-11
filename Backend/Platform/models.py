from django.db import models

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