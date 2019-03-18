![Cooking](https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/your_own_recipe/cooking.jpeg)

# Add your own recipe

Do you want your own recipe to show up in the app?

### You can do one of the following things:

* Just create a Pull Request [here](https://github.com/bartzaalberg/recipes). The steps how to do this can be found below.
* Or send me an email at bartzaalberg@gmail.com

# Steps for PR

1. Fork the repository.
2. Create a folder with the name of your recipe under `/recipes` in the repository. (example `/recipes/very_nice_meat_recipe`)
3. Create the recipe file `recipe_<the language you are creating in>.md` in the folder. (example `recipe_en.md` for english)
4. Add your recipe to the `/recipes/recipes.json` as followed
```
{
    "id": "very_nice_meat_recipe",
    "title": {
        "en": "Very nice meat recipe"
    },
    "thumbnail": "https://www.someimagelink.nl",
    "author": "you",
    "languages": ["en"]
},
```

Thats it! You can commit and create the pull request.

### Remember

Please make sure to always add English as that is used as fallback.

### Image

You can also add an image in the folder and link to it from the markdown and json file. If you have to link to the original image page. just add the following code to the markdown file underneath your image.
```
[![Image src](https://raw.githubusercontent.com/bartzaalberg/recipes/master/data/icons/camera-icon.png#image-src)](
    YOUR IMAGE LINK HERE
)
```
