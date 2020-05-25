# User login system

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)
- [user registration](../user_registration/) (register form for users)



## Step 1: Create login logout system.

1.1 In the urls.py in the <project_name>/<project_name> folder add following lines:

```python
#...
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views # new line

import users_app.views as user_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('<app_name>.urls')),
    path('register/', user_views.register, name='register'),
    path('profile/', user_views.profile, name='profile'),
    path('loginsuccess/', user_views.login_success, name='loginsuccess'),
    path('login/', auth_views.LoginView.as_view(template_name='users_app/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(template_name='users_app/logout.html'), name='logout'), 
    path('logoutsuccess/', user_views.logout_success, name='logoutsuccess'),
]
```

1.2 In the views.py of users_app app, create two new views: one for profile and one for login success redirection + import login required decorator:

```python
# new lines
from django.contrib.auth.decorators import login_required

@login_required
def profile(request):
    return render(request, 'users_app/profile.html')

def login_success(request):
    messages.success(request, f'You successfully logged in.')
    return redirect('<app_name>:home')

def logout_success(request):
    logout(request)
    messages.success(request, 'You have successfully logged out.\
         <a href=\"login/"> Log back in </a> ')
    return redirect('home:home')

```

There should be a register view in the file earlier. You can put the import at the beginning of the file.

1.3 In the settings.py file, add two variables:


```python
LOGIN_URL = 'login'
LOGIN_REDIRECT_URL = 'loginsuccess'
```

1.4 Copy the login.html, logout.html and profile.html to the templates/users_app directory. Fill in the <app_name> for the app with the home url.

1.5 Alter the base.html file in the templates with logic to display "Login Register" when user is not logged in or "Profile Logout" when user is signed in. The navbar should look like below

```html
<div class="collapse navbar-collapse" id="navbarToggle">
    <div class="navbar-nav mr-auto">
        <!-- Links to pages -->
        <a class="btn nav-item nav-link" href="#page1">Page1</a>
        <a class="btn nav-item nav-link" href="#page2">Page2</a>
        <a class="btn nav-item nav-link" href="#page3">Page3</a>
    </div>
    <!-- Navbar Right Side - to be used with user authentification-->
    {% if user.is_authenticated %}
    <div class="navbar-nav">
        <a class="btn nav-item nav-link" href="{% url 'profile' %}">Profile</a>
        <a class="btn nav-item nav-link" href="{% url 'logoutsuccess' %}">Logout</a>
    </div>
    {% else %}
    <div class="navbar-nav">
        <a class="btn nav-item nav-link" href="{% url 'login' %}">Login</a>
        <a class="btn nav-item nav-link" href="{% url 'register' %}">Register</a>
    </div>
    {% endif %}
</div>
```

1.6 Edit the register.html template to update the link to the login page (at the end).

1.7 Verify the success.

1.8 Optionally, edit the django/contrib/auth/decorators.py file to add error message when login is required. Then edit the base.html to add logic for bootstrap's alert-danger class instead of alert-error class.