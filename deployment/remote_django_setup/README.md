# Remote django setup

Prerequisites:


- [linux_server_setup](../linux_server_setup/) (remote server setup)
- [django_project_packaging](../django_project_packaging) (prepared django project)

### Note

Transfer is done using two medium: a) git project b) scp transfer of media and database.

## Step 1: Clone git repository.

1.1 In the Linux home folder, clone the repository of the project.

```bash
git clone <repository_url> # take this value from github
```

This should create a folder <project_name> with the project files (manage.py, etc.).

## Step 2: Copy the media and database.

2.1 In the folder with 'media' folder and 'db.sqlite3', type:

```bash
scp -r media <username>@<ip_address>:~/<project_name>/media
scp db.sqlite3 <username>@<ip_address>:~/<project_name>/db.sqlite3
```

This will copy the media files and the database.

## Step 3: Install python3 with pip, venv and install project dependencies.

3.1 On the remote machine, type:

```bash
apt-get install python3-pip 
apt-get install python3-venv
```

3.2 Inside the project folder (one with manage.py), create a virtual environment.

```bash
python3 -m venv venv
```

3.3 Activate the environment and install the dependencies from requirements.txt file.

```bash
source venv/bin/activate
python3 -m pip install -r requirements.txt
```

3.4 Add the SECRET_KEY as the environment variable.

3.5 Test the installation by running the project on port 8000.

```bash
python3 manage.py runserver 0.0.0.0:8000
```

3.6 On the local machine, in the browser, go to http://<ip_address>:8000 . You should see your website.


## Step 4: Prepare static files.

4.1 Go to settings.py in <project_folder>/<project_folder> on the remote or local machine (and then transfrer using git).

4.2 Near the end, next to the STATIC_URL, set STATIC_ROOT value.

```python
STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'static')
```

4.3 In the project folder, run collectstatic command and then add the created static folder to git tracking.

```bash
python3 manage.py collectstatic
git add .
```

Remember about collecting the static files later during development and updating the changes accordingly.

4.4 Commit the changes, update the remote or local and test the server by running `python3 manage.py runserver 0.0.0.0:8000 and going to the browser.