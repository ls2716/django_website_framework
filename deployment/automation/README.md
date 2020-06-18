# Web update automation

This setup shows how to automate git update using a simple Python script and Linux screen utility.

Prerequisites:

- [linux_server_setup](../linux_server_setup/) (remote server setup)
- [django_project_packaging](../django_project_packaging/) (prepared django project)
- [remote_django_setup](../django_project_packaging/) (django project transfered to remote server)
- [apache_setup_production](../apache_setup_production/g) (server running on production)

- Linux screen utility


## Step 1: Setup the script on the remote server.

The script is pulling the changes form the remote repository every 10 seconds - if it finds a change, it pulls automatically and restarts apache2 service so that the server will show the changes.

1.1 Download the 'automate.py' script from this folder and put it in the project folder (with manage.py). Copy the script over to the remote server using git or scp.

1.2 Download the git Python package called gitpython.

```bash
# with environment active
python3 -m pip install gitpython
```

1.3 Remember to call ```python3 -m pip freeze > requirements.txt``` afterwards to update the requirements file.

## Step 2: Setup no password for apache2 restart and git.

Script should not be asked for passwords on the way.

2.1 Edit the visudo file by typing ```sudo visudo```.

2.2 At the end(!), add a line so that the user will be able to call the apache2 restart command without being prompted for password. It should look like following:

```bash
# Allow members of group sudo to execute any command
%sudo   ALL=(ALL:ALL) ALL

# See sudoers(5) for more information on "#include" directives:

#includedir /etc/sudoers.d
<username> ALL=(ALL) NOPASSWD: /bin/systemctl restart apache2 # added line
```

2.3 Setup git pull without the credentials. On the remote (also can be done on local for convenience):

```bash
git config --global credential.helper store
git pull
```

This will be the last time you should be prompted for your credentials.

## Step 3: Open a new screen, run the program and test the automation.

3.1 Open a new screen in the project directory, activate the environment and run the automate.py.

```bash
cd <project_folder>
screen -S automation
source venv/bin/activate
python3 automate.py
```

Then exit the screen using Ctrl+A Crtl+D.

3.2 Test the automation by changing the project on the local machine and pushing the changes. The website should change accordingly after maximum 10 seconds.

In case of errors, just don't detach the screen and you should be able to see any errors.

## Step 4: Note for copying not tracked data.

For copying not tracked data i.e. media or database it is necessary to reset the correct permissions.

To do it you can use the script in this folder called permissions.sh. You have to set up no password sudo execute for it analogically as in step 2. At the beginning of the file you should set up the cd to the directory of the project. This is very important!

Then to copy the files through use (on the local machine):

```bash
# copy (folder can be a sqlite database)
scp -r <folder> <username>@<hostname>:~/<project_name>/<folder>
# set permissions
ssh <username>@<hostname> -f 'sudo ./<project_name>/permissions.sh'
```