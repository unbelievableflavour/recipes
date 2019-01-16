using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : Gtk.Box {

    private FileManager fileManager = FileManager.get_instance ();
    private StackManager stackManager = StackManager.get_instance();
    private Granite.AsyncImage     image;
    private Gtk.Overlay            overlay;
    private Gtk.Button             photo_button;
    private Recipe                 recipe;

    public InstalledPackageRow (Recipe recipe){
        this.recipe = recipe;
        this.can_focus = false;
        this.orientation = Gtk.Orientation.VERTICAL;
        this.halign = Gtk.Align.CENTER;
        this.valign = Gtk.Align.START;
        this.margin_start = 8;
        this.margin_end = 8;
        this.margin_top = 8;
        this.margin_bottom = 8;

        image = new Granite.AsyncImage(true, true);
        image.get_style_context ().add_class ("backimg");

        image.set_from_file_async.begin(
            File.new_for_uri (recipe.getThumbnail()), 300, 200, false);
        image.has_tooltip = true;
        image.set_tooltip_text (recipe.getName());

        overlay = new Gtk.Overlay();
        overlay.can_focus = false;
        overlay.halign = Gtk.Align.CENTER;
        overlay.add (image);

        photo_button = new Gtk.Button();
        photo_button.get_style_context ().add_class ("photo");
        photo_button.add(overlay);
        photo_button.can_focus = false;

        photo_button.button_release_event.connect ( (event) => {
            stackManager.setDetailRecipe(this.recipe);
            stackManager.getStack().visible_child_name = "detail-view";
            return true;
        });

        var label_name = new Gtk.Label(recipe.getName());
        label_name.get_style_context ().add_class ("recipename");
        label_name.margin_top = 8;
        label_name.halign = Gtk.Align.CENTER;

        this.add(photo_button);
        this.add (label_name);
    }
}
}
