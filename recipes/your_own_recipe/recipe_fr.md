![Votre propre recette](https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/your_own_recipe/cooking.jpeg)

# Ajoutez votre propre recette

Vous voulez que votre propre recette apparaisse dans l'application ?

### Vous pouvez faire l'une des choses suivantes :

* Vous n'avez qu'à créer une Pull Request [ici](https://github.com/bartzaalberg/recipes). Vous trouverez ci-dessous la marche à suivre pour ce faire.
* Ou envoyez-moi un email à bartzaalberg@gmail.com

# Étapes pour une PR

1. Forkez le dépôt.
2. Créez un dossier avec le nom de votre recette sous `/recipes` dans le répertoire. (exemple `/recipes/tres_belle_recette_de_viande`)
3. Créez le fichier de recette `recipe_<la langue dans laquelle vous le créez>.md` dans le dossier. (exemple `recipe_fr.md` pour le français)
4. Ajoutez votre recette au fichier `/recipes/recipes.json` comme suit :
```
{
    "id": "tres_belle_recette_de_viande",
    "title": {
        "en": "Very nice meat recipe",
        "fr": "Très belle recette de viande"
    },
    "thumbnail": "https://www.lienimage.fr",
    "author": "vous",
    "languages": ["en", "fr"]
},
```

C'est tout ! Vous pouvez valider et créer la Pull Request.

### Rappel

Veuillez vous assurer de toujours ajouter l'anglais, car il est utilisé comme langue par défaut.

### Image

Vous pouvez également ajouter une image dans le dossier et créer un lien vers celui-ci à partir du fichier Markdown et Json. Si vous devez créer un lien vers la page d'image originale, ajoutez simplement le code suivant sur la fiche détaillée en dessous de votre image.
```
[![Image src](https://raw.githubusercontent.com/bartzaalberg/recipes/master/data/icons/camera-icon.png#image-src)](
    VOTRE LIEN D'IMAGE ICI
)
```
