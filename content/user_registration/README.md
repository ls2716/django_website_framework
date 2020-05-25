# User registration

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)


## Note:

For more info about forms go to [Django documentation](https://docs.djangoproject.com/en/3.0/topics/forms/).


## Step 1: Create a new app for users.

1.1 Following instruction in [new app setup](../new_app_setup/), create a new app called 'users_app'.

1.2 Paste the 'templates' folder, forms.py and views.py files over to the new app directory.

1.3 Update the 'templates/users_app/register.html' file to fill app_name and page name values.

1.3 In the urls.py file in the <project_name>/<project_name> directory, add a path ro the register page and import the views of the users_app:

```python
import users_app.views as user_views # added line

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('test_app.urls')),
    path('register/', user_views.register, name='register'), # added line
]
```

1.4 Go to the base.html and add a link in the navigation bar to the register page. It should look like following:

```html
<div class="collapse navbar-collapse" id="navbarToggle">
    <div class="navbar-nav mr-auto">
        <!-- Links to pages -->
        <a class="btn nav-item nav-link" href="#page1">Page1</a>
        <a class="btn nav-item nav-link" href="#page2">Page2</a>
        <a class="btn nav-item nav-link" href="#page3">Page3</a>
    </div>
    <!-- Navbar Right Side - to be used with user authentification ADDED LINES-->
    <div class="navbar-nav">
        <a class="btn nav-item nav-link" href="{% url 'register' %}">Register</a>
    </div>
</div>
```

## Step 2: Download crispy forms pack.

2.1 While having the environment activated, run:

```bash
python3 -m pip install django-crispy-forms
```

2.2 Update the requirements.txt.

## Step 3: Update the setting.py file.

3.1 Go to the settings.py file. Add django crispy forms and the users app to the INSTALLED_APPS:

```python
# Application definition

INSTALLED_APPS = [
    'users_app.apps.UsersAppConfig', # added line
    'test_app.apps.<AppName>Config', 
    'crispy_forms', # added line
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

3.2 At the end of the settings.py file, define new variable:

```python
CRISPY_TEMPLATE_PACK = 'bootstrap4'
```

## Step 4: Verify the installation.

4.1 Start the server and try out the form, if you login to the admin panel you should see the new registered users.
