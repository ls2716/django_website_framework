cd <path_to_the_project_folder>
sudo chown :www-data db.sqlite3
sudo chmod 664 db.sqlite3
sudo chown :www-data ./
sudo chmod 775 ./
sudo chown -R :www-data media/
sudo chmod -R 775 media
sudo chown -R :www-data static/
sudo chmod -R 775 static
echo Successfully update permissions.
