# User profile and picture

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [admin setup](../admin_setup/) (setup admin for the website)
- [user registration](../user_registration/) (register form for users)
- [user login system](../user_login_system/) (login system for users)
- [user profile](../user_profile/) (setup user profiles)

#### Note: Have the python environment activated. 

## Step 1: Setup user and profile updates.

1.1 Copy the 'profile_edit.html' template to users_app templates. Fill in <app_name> at the beginning.

1.2 In the 'forms.py' file of the users_app create two new forms for model updates for User update and profile update.

```python
# added lines
class UserUpdateForm(forms.ModelForm):

    # for non-mutable fields
    username = forms.Field(required=False, disabled=True)
    email = forms.Field(required=False, disabled=True)

    class Meta:
        model = User
        fields = ['username', 'email']
    

class ProfileUpdateForm(forms.ModelForm):

    class Meta:
        model = Profile
        fields = ['image', 'description']
```

1.3 In the views.py file of the users_app create the edit profile view.

```python
@login_required
def profile_edit(request):

    if request.POST:
        u_form = UserUpdateForm(request.POST, instance=request.user)
        p_form = ProfileUpdateForm(request.POST, request.FILES,
                                    instance=request.user.profile)
        if u_form.is_valid() and p_form.is_valid():
            u_form.save()
            p_form.save()
            messages.success(request, f'You have successfully updated your profile.')
            return redirect('profile')
        else:
            messages.error(request, f'Failure')
            return redirect('profile_edit')
    else:
        u_form = UserUpdateForm(instance=request.user,
                            initial={'email': request.user.email})
        p_form = ProfileUpdateForm(instance=request.user.profile)

    context = {
        'u_form': u_form,
        'p_form': p_form,
    }
    return render(request, 'users_app/profile_edit.html', context=context)
```

1.4 Create a path to the edit profile page in the urls.py of the users_app app:

```python
urlpatterns = [
    ...
    path('register/', views.register, name='register'),
    path('profile/', views.profile, name='profile'),
    path('profile_edit/', views.profile_edit, name='profile_edit'), # new line
    path('loginsuccess/', views.login_success, name='loginsuccess'),
    ...
] 

```