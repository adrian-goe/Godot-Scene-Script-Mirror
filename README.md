# Godot-Scene-Script-Mirror

I was always annoyed that my scripts ended up all over the place.
The main reason was that I basically had to manually recreate, inside the scripts folder, the same folder structure in
which I created my scenes.

This plugin automatically creates an exact copy of the path of any newly created scene inside the scripts folder.
To ensure that currently unused folders are also included in Git, a `.gitkeep` file is additionally created.