namespace Application {
public class ListView : Gtk.ScrolledWindow {
       
    private ListBox listBox = ListBox.get_instance();
    private FileManager fileManager; 

    public ListView(){ 

        fileManager = FileManager.get_instance();
        var recipes = fileManager.getRecipes();

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        box.add(listBox);

        this.hscrollbar_policy = Gtk.PolicyType.NEVER;
        this.add (box);
    }
}
}
