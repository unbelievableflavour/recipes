using Granite.Widgets;

namespace Application {
public class IconHandler {

    private int icon_size = 32;

    private Gtk.Image backup_icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);

    private File file_photo;
    private Granite.AsyncImage image;

    public Gtk.Image get_icon_from_string (string recipe) {
        if ( recipe == "" || recipe == null) {
            return backup_icon;
        }
        try {
            if ( recipe.substring (0,4) == "http") {
                file_photo = File.new_for_uri (recipe);
                image = new Granite.AsyncImage (true, true);
                image.get_style_context ().add_class ("backimg");
                image.set_from_file_async.begin (file_photo, icon_size, icon_size, false);
                return image;
            }

            return backup_icon;
        } catch (Error e) {
            error ("%s", e.message);
        }
    }

    public void set_icon_size (int icon_size) {
        this.icon_size = icon_size;
    }
}
}
