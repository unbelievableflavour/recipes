![Koken](https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/your_own_recipe/cooking.jpeg)

# Voeg uw eigen recept toe

Wilt u uw eigen terug zien in de app?

### Dan kun je een van de volgende dingen doen:

* Maak een [hier](https://github.com/bartzaalberg/recipes)Pull Request. De stappen hoe je dit kan doen vind je hieronder.
* Of stuur me een email op bartzaalberg@gmail.com

# Stappen voor PR

1. Fork de repository.
2. Maak een map aan met de naam van uw recept onder `/recipes` in de repository. (voorbeeld `/recipes/very_nice_meat_recipe`)
3. Maak het recept bestand `recipe_<the language you are creating in>.md` aan in de folder. (voorbeeld `recipe_en.md` voor Engels)
4. Voeg je recept toe aan de `/recipes/recipes.json` als volgt
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

Dat is het! Commit je recept en maak de Pull Request.

### Onthouden

Voeg altijd Engels toe, want dit wordt gebruikt als fallback.

### Afbeelding

Je kunt ook een afbeelding toevoegen in de folder en hiernaar linken vanuit het markdown of json bestand. Als je de link heft van de originele afbeelding; Voeg dan de volgende code toe aan het markdown bestand onder de afbeelding .
```
[![Image src](https://raw.githubusercontent.com/bartzaalberg/recipes/master/data/icons/camera-icon.png#image-src)](
    YOUR IMAGE LINK HERE
)
```
