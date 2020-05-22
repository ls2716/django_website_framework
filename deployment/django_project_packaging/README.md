# Django project packaging 

Prerequisites:

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)
- [media](../media/) (setup for adding media files to the website)

### Note

The packaging of the project means preparing it for transfer to the remote server. This will be mainly done using git but some things will be transferred using scp (media folder and SQLite database).

## Step 1: Hide secret key.

Secret key should be hidden in production and definitely should not appear in git as it will be easily seen by anyone if the repository is public. The secret key has to be put to an environment variable or a hidden file (on remote) and sourced from there.

1.1 Go to the <project_name>/<project_name>/settings.py file and cut the secret key, instead taking its value from the environment. The line should look like this:

```python 
SECRET_KEY = os.environ.get('<PROJECT_NAME>_SECRET_KEY') # apprioprate env variable name
```

1.2 To set the enviroment variable, refer to the internet.

## Step 2: Add requirements.txt.

2.1 In the project folder (one with manage.py), with active environment, type:

```bash
pip freeze > requirements.txt
```

## Step 3: Set up git repository. 

Remember to cut out any secret information beforehand! (like SECRET_KEY or email passwords).

3.1 Go to the project folder. ('<project_name>' should appear once in path and the directory should contain manage.py).

3.2 Initialize the repository (with README.md).

```bash
echo "# <project_name" >> README.md
git init
git add README.md
```

3.3 Add a .gitignore file to ignore the environment files (should it appear in the folder), media and the sqlite database.

```bash
nano .gitignore
```

The contents should be (change if needed):

```bash
venv  #(environment folder)
media #(media folder)
db.sqlite3 #(sqlite database)
# + any other e.g. .vscode
```

Then add .gitignore to the git.
```bash
git add .gitignore
```

3.4 Add the rest of the files to the commit and commit.

```bash
git add .
git commit -m "initial commit"
```

3.5 Add the repository to Github. First create a repository without the README initialized and in the project folder execute:

```bash
git remote add origin https://github.com/<username>/<project_name>.git
git push -u origin master
```

Fill the username and password.

