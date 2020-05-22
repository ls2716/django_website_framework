# Page icon

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)
- [basic content](../basic_content/) (have a simple html page)

- icon files - These can be obtained using online text to icon tools and should include various sizes: 16x16, 32x32, apple-touch-icon (180x180), anroid-chrome icon 192x192 and android-chrome icon 512x512. 

[Click here to learn more from favicon.io site.](https://favicon.io/favicon-generator/)

To ease-up working with these files put all of them in a folder named 'icon' (or otherwise).




## Step 1: Add icon files to the static files.

1.1 Go to a created app. Put the 'icon' folder inside the appriopriatrly named static folder i.e. 'app_name/static/app_name'. 

## Step 2: Reference the icon in the base.html head.

2.1 Go to a base.html file. In the head add lines corresponding to the new icon. They should look like this:

```html
<link rel="apple-touch-icon" sizes="180x180" href="{% static 'app_name/icon/apple-touch-icon.png' %}">
<link rel="icon" type="image/png" sizes="32x32" href="{% static 'app_name/icon/favicon-32x32.png' %}">
<link rel="icon" type="image/png" sizes="16x16" href="{% static 'app_name/icon/favicon-16x16.png' %}">
<link rel="manifest" href="{% static 'app_name/icon/site.webmanifest' %}">
```