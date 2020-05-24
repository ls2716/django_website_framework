# Admin setup

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)




## Step 1: Make migrations and migrate to create database tables.

1.1 In the project folder (with manage.py) with acitve environment, run:

```bash
python manage.py makemirgations
python manage.py migrate
```

## Step 2: Create a super user.

2.1 In the same console as in step 1.1.

```bash
python manage.py createsuperuser
```

2.2 Fill all the details prompted by the shell i.e. username, email and password.

## Step 3: Verify success.

3.1 Run the server. Go to your website and route '/admin' i.e. http://<website_name.com>/admin. You should be able to log in using your credentials and see the admin panel.
