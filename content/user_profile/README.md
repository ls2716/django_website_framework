# User profile and picture

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)
- [user registration](../user_registration/) (register form for users)
- [user login system](../user_login_system/) (login system for users)

#### Note: Have the python environment activated. 

## Step 1: Copy the templates.

1.1 Replace the old profile.html with the new profile.html found in this folder. Update the value of <app_name>.

1.2 In the users_app create a folder path 'static/users_app'. Put the profile.css file there.
Remember to call collectstatic, copy the files through to remote and update permissions if needed.

## Step 2: Create a profile model to allow for profile image and description.

2.1 In the models.py file of the users_app, create a new model called 'Profile'. The whole models.py file:

```python
from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(default='profile_pics/default.png', upload_to='profile_pics')
    description = models.TextField(max_length=1000, blank=True, default='')

    def __str__(self):
        return f'{ self.user.username } Profile'
```

2.2 Register the new model in admin.py in the users_app. admin.pt file contents:

```python
from django.contrib import admin
from .models import Profile

# Register your models here.
admin.site.register(Profile)
```

2.3 Make migrations and migrate.

```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

2.4 Create folder called 'profile_pics' and put a default.png image there.

2.5 Install Pillow Python package. Remember about the remote server during deployment.

```python
python3 -m pip install Pillow
```

## Step 3: Setup create signal for Profile.

This will ensure that new profile is created when a user is created.

3.1 In the app folder, create a signals.py file and put following code there:

```python
from django.db.models.signals import post_save
from django.contrib.auth.models import User
from django.dispatch import receiver
from .models import Profile

# Create a Profile when user is created
@receiver(post_save, sender=User)
def create_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

# Save the Profile when user is created
@receiver(post_save, sender=User)
def save_profile(sender, instance, created, **kwargs):
    if created:
        instance.profile.save()
```

3.2 In the apps.py of the users_app, add signals import. In the following way:

```python
from django.apps import AppConfig


class UsersAppConfig(AppConfig):
    name = 'users_app'

    # added lines:
    def ready(self):
        import users_app.signals

```

## Step 4: Verify.

4.1 Run the server, create a new user - a profile should be created. You can also use the admin panel for it.