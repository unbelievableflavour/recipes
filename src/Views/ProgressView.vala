using Granite.Widgets;

namespace Application {
public class ProgressView : Gtk.ScrolledWindow {

    public ProgressView () {
        var progress_view = new Welcome (
            _("Please Wait"),
            _("Recipes are being loaded")
        );
        this.add (progress_view);
    }
}
}
