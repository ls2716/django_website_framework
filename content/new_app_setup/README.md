# New app setup

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)

## Step 1: Create a new app

1.1 Go to the project folder (the one with manage.py file inside).

1.2 Create a new app:
   
```
python manage.py startapp <app_name>
```
The app name should be all lower case.

## Step 2: Register the app and add basic view

2.1 Go to settings.py in the folder <project_name>.

2.2. Go to a list variable called 'INSTALLED_APPS' and add a string pointing to the config of the new app: '<app_name>.apps.<config_name>. The <config_name> is defined in the <app_name>/apps.py file. The result should look like this:
``` python
INSTALLED_APPS = [
    'new_app.apps.NewAppConfig', # the added string
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```
2.3 Go to a file <project_name>/urls.py. Import include function from django.urls module. To do this add a new line or modify the existing import for path function.
This should look like this:
``` python
# if you alter the existing
from django.urls import path, include
# or if you make a new line
from django.urls import include
```
Then add an entry to urlpatters list to include urls from your just create app.
It should look like this:
``` python
urlpatterns = [
    path('admin/', admin.site.urls),
    path('<app_name_pattern>', include('<app_name>.urls')) # added line
]
```
where <app_name_pattern> can be '' to point to website entry point or anything else ending with a '/' e.g. '<app_name>/'.

2.3 In the app folder create an urls.py file and add content:
``` python
from django.urls import path
from . import views

app_name = '<app_name>'

urlpatterns = [
    # path pattern to the basic view
    path('', views.<basic_view_name>, name='<basic_view_name>'),
]
```
2.4 Create the basic view. Go to <app_name>/views.py file and import HttpResponse function by adding an import line:
``` python
from django.http import HttpResponse
```
Then define a view. It is a function:
``` python
def <basic_view_name>(request):
    
    return HttpResponse('This is a basic view.')
```

2.5 Test the view by running the website. In the project folder:
```
python manage.py runserver
```
Then go to url: http://127.0.0.1:8000/<app_name_pattern>.You should see an unformatted text 'This is a basic view.'
