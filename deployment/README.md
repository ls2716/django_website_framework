# Deployment framework

This part presents how to deploy the djang website on the web. The current method of deployment is  on a Linux server with Apache and WSGI with a default SQLite database.

Prerequisites:

From the django website framework:
- [initial setup](../initial_setup/) (created django project)
- [new app setup](../content/new_app_setup/) (created new app)
- [basic content](../content/basic_content/) (have a simple html page)
- [media](../content/media/) (setup for adding media files to the website)

Other:
- linux server with ssh access and root privileges


The deployment process is divided in 4 parts which should be done in order:

1. [Django project packaging](django_project_packaging/) - necessary steps to be done to the project (e.g. SECRET_KEY configuration).

2. [Linux server setup](linux_server_setup/) - setting up firewall, secret key in the environment and downloading all the Linux packages.

3. [Remote django setup](remote_django_setup/) - transfering the project to the linux server and testing the django project.

4. [Apache setup and running the project in production.](apache_setup_production/)

5. [Automation](automation/) - automation of the deployment process for continuous development.
