# Initial setup

This part shows how to perform initial setup of a Django website.

## Step 1: Create Python Django environment

**Requirements:** Python 3 Anaconda or Python 3 virtualenv and pip

1.1 

#### a) with conda:

(Requires anaconda with Python 3.)

1.2a Create the virtual environment with Python 3:
```
conda create -n django_env python=3
```
1.3a Activate it:
```
conda activate django_env
```
1.4a Install Django:
```
conda install Django
```

#### b) with virtualenv and pip:

(Requires Python 3 version of pip and venv (python3-pip and python3-venv).)

1.2b While inside the project folder, create the virtual environment:
```
python3 -m venv venv
```
1.3b Activate it:
```
source venv/bin/activate
```
1.4b Install Django:
```
python3 -m pip install Django
```

## Step 2: Create a new Django website project

2.1 Activate the environment.

2.2 Create the project:
```
django-admin startproject <project_name>
```
This will create a project folder with all necessary startup files. 

2.3 To test whether the setup was successful, go into the project folder and run the website using the command:
```
python manage.py runserver
```

2.4 Open your browser and go to 127.0.0.1:8000. You should see a welcome page of your project.


### Finishing notes

That's all for initial setup. Go to the [content](../content/) part of the framework to learn how to add features to the website like admin, simple static pages and more.

In the [deployment](../deployment/) you can learn how to deploy your website to a production environment. This can be left for later after some features are added.
