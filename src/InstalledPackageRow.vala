using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);

    public InstalledPackageRow (Recipe recipe,Recipe[] recipes){

            this.recipe = recipe;

            name_label = generateNameLabel(recipe.getName() + " (" + recipe.getName() + ")");

            var summary_label = generateSummaryLabel("("+ recipe.getName() + ") " + recipe.getName());

            vertical_box.add (name_label);
            vertical_box.add (summary_label);

            var package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
            package_row.margin = 12;
            package_row.add(icon);
            package_row.add (vertical_box);

            this.add (package_row);
        }
}
}
