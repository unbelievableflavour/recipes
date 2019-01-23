using Granite.Widgets;

namespace Application {
public class App:Granite.Application {

    public static MainWindow window = null;
    public static string[] supported_mimetypes;

    construct {
        program_name = Constants.APPLICATION_NAME;
        application_id = Constants.APPLICATION_NAME;
    }

    protected override void activate () {
        new_window ();
    }

    public static int main (string[] args) {
        var app = new Application.App ();
        return app.run (args);
    }

    public void new_window () {
        if (window != null) {
            window.present ();
            return;
        }

        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
        default_theme.add_resource_path ("/com/github/bartzaalberg/recipes");

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/bartzaalberg/recipes/application.css");
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        window = new MainWindow (this);
        window.show_all ();
    }
}
}
