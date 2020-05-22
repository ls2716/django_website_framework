import os
from time import sleep
from git import Repo


# initialize git repo
repo = Repo('.')


while True:
    message = repo.git.pull()
    if message!='Already up to date.':
        os.system('sudo systemctl restart apache2')
    print(message)
    sleep(10)
