# Media

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)



## Step 1: Add MEDIA_ROOT and MEDIA_URL in the project settings.

1.1 Go to the settings.py file in the django project folder (named '<project_name>/<project_name>').

1.2 At the end specify the MEDIA_ROOT and MEDIA_URL to values below:

```python
MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'
```

1.3 Create a folder called 'media' in the project directory (so '<project_name>/media'). This folder will hold all the media files.

## Step 2: Add url pattern for media files in the urls.py.

2.1 Go to the urls.py file in the '<project_name>/<project_name>' folder. 

2.2 Import the static function from django.conf.urls.static and the settings from django.conf :

```python
from django.conf import settings
from django.conf.urls.static import static
```

2.3 Add media files url pattern by appending to the urlpatterns list using the imported static function.

```python
urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('<app_name>.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

## Step 3: Reference the media files in html files.

3.1 In the html file, if you want to reference media file you should do it in the following way.

```html
<img src="/media/image_name.jpg"></img>
```

