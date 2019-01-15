using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : ListBoxRow {

    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);

    public InstalledPackageRow (Recipe recipe,Recipe[] recipes){

            this.recipe = recipe;
            IconHandler iconHandler = new IconHandler();

            var icon = iconHandler.get_icon_from_string(recipe.getThumbnail());
            name_label = generateNameLabel(recipe.getName());

            var summary_label = generateSummaryLabel(recipe.getAuthor());

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
