# User login system

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)
- [user registration](../user_registration/) (register form for users)



## Step 1: Create login logout system.

1.1 Change the urls.py in the <project_name>/users_app folder to following:

```python
from django.urls import path
from django.conf.urls.static import static
from django.contrib.auth import views as auth_views # new line

from . import views

urlpatterns = [
    path('register/', views.register, name='register'),
    path('profile/', views.profile, name='profile'),
    path('loginsuccess/', views.login_success, name='loginsuccess'),
    path('login/', auth_views.LoginView.as_view(template_name='users_app/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(template_name='users_app/logout.html'), name='logout'), 
    path('logoutsuccess/', views.logout_success, name='logoutsuccess'),
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

1.8 Optionally, edit the django/contrib/auth/decorators.py file to add error message when login is required. The added line should look like following:


```python
def decorator(view_func):
        @wraps(view_func)
        def _wrapped_view(request, *args, **kwargs):
            if test_func(request.user):
                return view_func(request, *args, **kwargs)
            path = request.build_absolute_uri()
            resolved_login_url = resolve_url(login_url or settings.LOGIN_URL)
            # If the login url is the same scheme and net location then just
            # use the path as the "next" url.
            login_scheme, login_netloc = urlparse(resolved_login_url)[:2]
            current_scheme, current_netloc = urlparse(path)[:2]
            if ((not login_scheme or login_scheme == current_scheme) and
                    (not login_netloc or login_netloc == current_netloc)):
                path = request.get_full_path()
            from django.contrib import messages # new line
            messages.error(request, f'You have to log in to access that page.') # new line
            from django.contrib.auth.views import redirect_to_login
            return redirect_to_login(
                path, resolved_login_url, redirect_field_name)
        return _wrapped_view
    return decorator
```

OR edit the login.html template to display the message if url contains parameter next. This will work for LoginRequiredMixin class as well.
