# Basic page

Prerequisites: 

- [initial setup](../../initial_setup/) (created django project)
- [new app setup](../new_app_setup/) (created new app)




## Step 1: Create a new view.

1.1 Go to the app folder and open views.py file. 

1.2 Define a new view which will render a static template: 
``` python
def <new_view>(request):
    context = {}
    return render(request, '<app_name>/<template_name>', context)
```

1.3 Make sure that views.py script import render function from django.shortcuts .

1.4 Add an url pointing to the new view by adding a string to the urlpatters list in the urls.py file:
```python
app_name = '<app_name>'

urlpatterns = [
    # path pattern to the basic view
    path('', views.<basic_view_name>, name='<basic_view_name>'),
    # path pattern to the new view
     path('new_view', views.<new_view>, name='<new_view>'), # new line added
]
```
To create a link to the page set anchor tag (a) href to "{% url '<app_name>:<new_view>' %}".

## Step 2: Add templates base and basic page.

2.1 Download base.html and page.html files from this folder. In the app folder, create a path templates/<app_name> and place the downloaded html files there. The base.html file is a basis for a page - it contains structure and static links. page.html is a template for a static page - it contains content that is filled in the base template using Django blocks.

## Step 3: Add templates style.

3.1 Download base.css, page.css and default_white_color_pack.css files from this folder. In the app folder, create a path static/<app_name> and place  the downloaded css files there. The css files regard the styles of corresponding html files. The base.css is activa on every page of the website while the page.css type files are activa only on corresponding pages and are referenced in page.html files. The default_white_color_pack.css defines the color scheme used by the website. It is referenced by the base.html file. 


## Step 4: Customize styles and content.

4.1 Add the content of the pages using the page.html template provided or by adding your own subsections.

4.2 Each added page should have a link to it in the navigation bar defined in the base.html. Add links to navbar using base.html template.

4.3 Change the styles of the page using the css files.

4.4 Change the color_pack.css by picking a one from a color_packs subfolder or by creating your own.

4.5 Remember to change every occurance of the page or app name - especially in referencing the style sheets and links.

## General rules for working with css and html.

- Don't use inline styles.

- Comment things throroughly.

- Keep the code clean.

- Don't obfuscate things and avoid chain corrections.

- Check for different screen sizes.