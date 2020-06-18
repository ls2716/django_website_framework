# Password reset

This framework shows how to set up password reset with emails using gmail account.

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)
- [user registration](../user_registration/) (register form for users)
- [user login system](../user_login_system/) (login system for users)


## Step 1: Add email username and password to secret information.

1.1 Using Gmail, create a application password for Django. See [this link](https://support.google.com/accounts/answer/185833?hl=en).

1.2 For development, create two new environmental variables: EMAIL_USERNAME and EMAIL_PASSWORD - the first one will hold your gmail username and the second the previously create app password.

1.3 For profuction, edit the /etc/config-<project_name>.json file and add the email credentials there.

## Step 2: Edit the settings.py file.

2.1 Near the beginning, after DEBUG = True, add new line to initially set config to None.

```python
# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True
config = None # added line
```

2.2 At the end of the file, set up email mechanism.

```python
EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_PORT = 587
EMAIL_USE_TLS = True

if config:
    EMAIL_HOST_USER = config['EMAIL_USERNAME']
    EMAIL_HOST_PASSWORD = config['EMAIL_PASSWORD']
else:
    EMAIL_HOST_USER = os.environ.get('EMAIL_USERNAME')
    EMAIL_HOST_PASSWORD = os.environ.get('EMAIL_PASSWORD')
```

## Step 3: Edit urls.py and views.py file of the users_app to add password reset.

3.1 Edit urls.py file. Add following entries to urlpatterns list.

```python
urlpatterns = [
    ...
    # new entries
    path('password-reset',\
        auth_views.PasswordResetView.as_view(template_name='users_app/password_reset.html',
                            success_url=reverse_lazy('users_app:password_reset_done'),
                            subject_template_name='users_app/password_reset_subject.txt'),
                            email_template_name='users_app/password_reset_email.html'),\
        name='password_reset'),
    path('password-reset/done/',\
        views.password_reset_done,\
        name='password_reset_done'),
    path('password-reset-confirm/<uidb64>/<token>/',\
        auth_views.PasswordResetConfirmView.as_view(template_name='users_app/password_reset_confirm.html'),\
        name='password_reset_confirm'),
    path('password-reset-complete/',\
        auth_views.PasswordResetCompleteView.as_view(template_name='users_app/password_reset_complete.html'),\
        name='password_reset_complete'),
]
```

3.2 In the views.py of the users_app, add a password_reset_done view (at the end).

```python
def password_reset_done(request):
    messages.info(request, f'An email has been sent to { request.GET.get("email","your email") }\
        with instructions how to reset your password.')
    return redirect('test_app:home')
```

3.3 Optionally edit the PasswordResetView to include email information in the context.

## Step 4: Add and edit templates.

4.1 Copy the templates from this directory into the templates of the users_app. The files should have paths <project_name>/users_app/templates/users_app/<template_name>.html

4.2 Edit the templates appriopriately.

4.3 Edit the login template to add link to password reset. Edit users_app/login.html:

```html
...
  <form method='POST'>
    {% csrf_token %}
    <fieldset class='form-group'>
      {{ form|crispy }}
    </fieldset>
    <div class='form-group'>
      <button class='btn btn-outline-info' type='submit'>Log in</button>
    </div>
    <!-- 3 added lines below -->
    <small class="test-muted ml-2">
      <a href="{% url 'users_app:password_reset' %}">Forgot password?</a>
    </small>
  </form>
  ...
```


## Step 4: Verify the successful reset mechanism.

4.1 Start the server and test the password reset.