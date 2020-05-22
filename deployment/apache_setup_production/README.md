# Remote django setup

Prerequisites:

- [linux_server_setup](../linux_server_setup/) (remote server setup)
- [django_project_packaging](../django_project_packaging) (prepared django project)
- [remote_django_setup](../django_project_packaging) (django project transfered to remote server)

## Note:

All instructions done on remote server.


## Step 1: Install apache2.

1.1 Install apache2.

```bash
sudo apt-get install apache2
```

1.2 Install WSGI.

```bash
sudo apt-get install libapache2-mod-wsgi-py3
```

1.3 Copy the template site configuration to /etc/apache2/sites-available/ from the template provided in this folder. Replace all blanks: <username>, <project_name>, <ip_address> and <domain_name> appriopriately. 

1.4 Change the ownership of the database and media folder so it can be accessed by apache. On the remote, in the home filder, type:

```bash
sudo chown :www-data <project_name>/db.sqlite3
sudo chmod 664 <project_name>/db.sqlite3
sudo chown :www-data <project_name>/
sudo chmod 775 <project_name>/
sudo chown -R :www-data <project_name>/media/
sudo chmod -R 775 <project_name>/media
```



## Step 2: Save the secret variables into a configuration file.

Apache cannot access anvironmental variables. Thus they have to be imported from a json file.

2.1 Create a /etc/config-<project_name>.conf file and put the SECRET_KEY value there. It should look like this:


```bash
{
    "<PROJECT_NAME>_SECRET_KEY": "<value"
    # plus any other secret information
}
```

2.2 In the <project_name>/<project_name>/settings.py file, add following lines after SECRET_KEY and DEBUG definitions:

```python
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = os.environ.get('<PROJECT_NAME>_SECRET_KEY')

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

### new lines
# Run by apache in production - failure to find secret key
if SECRET_KEY==None:
    with open('/etc/config-<project_name>.json', 'r') as f:
        config = json.load(f)
    SECRET_KEY = config['<PROJECT_NAME>_SECRET_KEY']
    DEBUG = False
```

## Step 3: Final configs.

3.1 Remember to add domain name/ ip address to allowed hosts if necessary.

3.2 Change DEBUG setting in settings.py to False.

3.3 Disable 8000 port if not testing.

```bash
sudo ufw delete allow 8000
```

3.4 Allow http (port 80).

```bash
sudo ufw allow 80
```

3.5 Restart the apache service.

```bash
sudo service apache2 restart
```

3.6 On your local machine, go to the browser, type the ip/domain and check that the server is running.
