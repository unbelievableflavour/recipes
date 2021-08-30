<a href="https://gitlocalize.com/repo/4332"> <img src="https://gitlocalize.com/repo/4332/whole_project/badge.svg" /> </a>
<img src="https://travis-ci.org/bartzaalberg/alias.svg?branch=master" />

# Archived
This repository is not maintained anymore and will not be updated to Elementary OS 6.0. You have my blessing to create a fork and update the application to post publish it in Elementary 6.0 under your own name. 

# Recipes
A markdown recipes application

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

## Add your own recipe

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

## Recompile the schema after installation

`sudo glib-compile-schemas /usr/share/glib-2.0/schemas`

### Update .pot file

Call the following command from the build folder:

`ninja com.github.bartzaalberg.recipes-pot`
