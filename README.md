# Recipes
A cookbook for Elementary OS

<p align="center">
    <a href="https://appcenter.elementary.io/com.github.bartzaalberg.recipes">
        <img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter">
    </a>
</p>

<p align="center">
    <img 
    src="https://raw.githubusercontent.com/bartzaalberg/recipes/master/screenshot.png" />
</p>

Do some cooking with some easy recipes. All the recipes are written in simple markdown. Don't see what you like? Add your own!

##Add your own recipe

Do you have an awesome recipe you want to share? Please dont hesitate to add it to the repository!

Instructions can be found [here](https://github.com/bartzaalberg/recipes/blob/master/recipes/your_own_recipe/recipe_en.md)

## Installation

First you will need to install elementary SDK

 `sudo apt install elementary-sdk`

### Dependencies

These dependencies must be present before building
 - `valac`
 - `gtk+-3.0`
 - `granite`
 - `libwebkit2gtk-4.0-dev`
 - `libmarkdown2-dev`
 - `json-glib-1.0`
 - `libsoup2.4-dev`

 You can install these on a Ubuntu-based system by executing this command:
 
 `sudo apt install valac libgtk-3-dev libgranite-dev libwebkit2gtk-4.0-dev libmarkdown2-dev json-glib-1.0 libsoup2.4-dev`

### Building
```
meson build --prefix=/usr
cd build
ninja
```

### Installing
`sudo ninja install`
