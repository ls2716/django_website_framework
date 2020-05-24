# Basic models

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)



## Step 1: Define a new model in models.py for the app.

1.1 Go to the models.py file in the app folder  (<project_name>/<app_name>/).

1.2 Define a new model with field names. It should look like this:


```python
from django.db import models

# added lines
class <model_name>(models.Model):

    # field definitions - can be other field types
    field1 = models.CharField(max_length=100) 
    field2 = models.TextField()
    # ...

    # method for display name
    def __str__(self):
        return self.field1 # will return field1 as object name

```

1.3 For more information about field types and relationships go to [Django documentation](https://docs.djangoproject.com/en/3.0/topics/db/models/).

## Step 2: Register the model for admin.

2.1 Go to admin.py file in the app directory - the same with the models.py with the created model.

2.2 Register the model with admin:

```python
from django.contrib import admin
# import the model
from .models import <model_name>

# Register your models here.
# register the model
admin.site.register(<model_name>)
```

## Step 3: Pass the models to a view using context.

3.1 Go to views.py file in the app folder.

3.2 Create a new view and pass the created models to the view:

```python
# import the model
from .models import <model_name>

def <view_name>(request):
    context = {
        'modelobjects': <model_name>.objects.all(),
    }
    return render(request, '<app_name>/<page_template.html>', context=context)
```

3.3 Add the path to the new view in urlpatters in urls.py:

```python
from django.urls import path
from . import views

app_name = '<app_name>'

urlpatterns = [
    # path pattern to the basic view
    path('', views.home, name='home'),
    # added line - path to the new view
    path('<page_name>', views.<view_name>, name='<page_name>'),
]
```

## Step 4: Create a new page.html and include the models.

4.1 Create a new page using instructions in [basic page framework](../_basic_page/).

4.2 In the body, add following div element to display the field1's of all model objects.

```html
<div>
    {% if modelobjects %}
    <h4>Model objects list:</h4>
    {% endif %}
    <ul>
        {% for modelobject in modelobjects %}
        <li>{{ modelobject.field1 }}</li>
        {% endfor %}
    </ul>
</div>
```

4.3 For more infor about django html templatetag syntax, go to [Django documentation](https://docs.djangoproject.com/en/3.0/ref/templates/builtins/)

## Step 5: Verify.

5.1 Run the server.

5.2 Add some model objects using admin panel.

5.3 Go to the new page - you should see the list of field 1 of created objects.