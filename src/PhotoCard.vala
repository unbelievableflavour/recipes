using Granite.Widgets;

namespace Application {
public class PhotoCard : Gtk.Box {

    private StackManager stack_manager = StackManager.get_instance ();
    private Granite.AsyncImage image;
    private Gtk.Overlay overlay;
    private Gtk.Button photo_button;
    private Recipe recipe;

    public PhotoCard (Recipe recipe) {
        this.recipe = recipe;
        this.can_focus = false;
        this.orientation = Gtk.Orientation.VERTICAL;
        this.halign = Gtk.Align.CENTER;
        this.valign = Gtk.Align.START;
        this.margin_start = 8;
        this.margin_end = 8;
        this.margin_top = 8;
        this.margin_bottom = 8;

        image = new Granite.AsyncImage (true, true);
        image.get_style_context ().add_class ("backimg");

        var file = File.new_for_uri (recipe.get_thumbnail ());

        image.set_from_file_async.begin (file, 300, -1, true);
        image.has_tooltip = true;
        image.set_tooltip_text (recipe.get_name ());

        overlay = new Gtk.Overlay ();
        overlay.can_focus = false;
        overlay.halign = Gtk.Align.CENTER;
        overlay.add (image);

        photo_button = new Gtk.Button ();
        photo_button.get_style_context ().add_class ("photo");
        photo_button.add (overlay);
        photo_button.can_focus = false;

        photo_button.button_release_event.connect ( (event) => {
            stack_manager.set_detail_recipe (this.recipe);
            stack_manager.get_stack ().visible_child_name = "detail-view";
            return true;
        });

        var label_name = new Gtk.Label (recipe.get_name ());
        label_name.get_style_context ().add_class ("recipename");
        label_name.margin_top = 8;
        label_name.halign = Gtk.Align.CENTER;

        var person_label = new Gtk.Label (
            recipe.get_persons () != 0
                ? recipe.get_persons ().to_string () + " " +_("Persons")
                : ""
        );
        person_label.get_style_context ().add_class ("number-of-persons");
        person_label.halign = Gtk.Align.CENTER;

        this.add (photo_button);
        this.add (label_name);
        this.add (person_label);
    }
}
}
