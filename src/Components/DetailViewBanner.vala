using Granite.Widgets;

namespace Application {
public class DetailViewBanner : ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    Gtk.Box package_row;

    Gtk.Label summary_label;
    Gtk.Label version_label;

    public DetailViewBanner (Recipe recipe){
        reloadView(recipe);
    }

    public void loadRecipe(Recipe newRecipe){
        remove(package_row);
        reloadView(newRecipe);
        show_all();
    }

    public void reloadView(Recipe recipe){

        name_label = new Gtk.Label(recipe.getName().strip());
        name_label.get_style_context ().add_class ("detail-view-banner-title");

        summary_label = new Gtk.Label("");
        if(recipe.getName() != null){
            summary_label = generateSummaryLabel(recipe.getName());
        }
        version_label = new Gtk.Label("");
        if(recipe.getName() != null) {
            version_label = generateSummaryLabel(recipe.getName());
        }
        
        var horizontal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
        horizontal_box.add (name_label);
        horizontal_box.add (version_label);
        
        var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        vertical_box.add (horizontal_box);
        vertical_box.add (summary_label);
        
        package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        package_row.margin = 12;
        package_row.add(icon);
        package_row.add (vertical_box);

        add (package_row);
    }
}
}
