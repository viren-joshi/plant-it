from django.db import models
from django.contrib.auth.models import User

class UserProfile(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100, blank=True, null=True)
    user_type = models.CharField(max_length=20, blank=True, null=True)

    def __str__(self):
        return f'{self.user}'

    