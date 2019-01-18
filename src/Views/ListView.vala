namespace Application {
public class ListView : Gtk.ScrolledWindow {

    private PhotosFlowBox photo_box = PhotosFlowBox.get_instance ();

    public ListView () {
        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        box.add (photo_box);

        this.hscrollbar_policy = Gtk.PolicyType.NEVER;
        this.add (box);
    }
}
}
