using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox{

    static ListBox? instance;

    private FileManager fileManager = FileManager.get_instance ();
    private StackManager stackManager = StackManager.get_instance();

    ListBox() {

        row_activated.connect (on_row_activated);

    }
 
    public static ListBox get_instance() {
        if (instance == null) {
            instance = new ListBox();
        }
        return instance;
    }

    public void emptyList(){
        this.foreach ((ListBoxRow) => {
            this.remove(ListBoxRow);
        }); 
    }

    public void getInstalledPackages(){

        stackManager.getStack().visible_child_name = "list-view";

        var recipes = fileManager.getRecipes();

        emptyList();
        foreach (Recipe recipe in recipes) {
            add (new InstalledPackageRow (recipe, recipes));
        }

        show_all();
    }

    private void on_row_activated (Gtk.ListBoxRow row) {
        stackManager.getStack().visible_child_name = "progress-view";

        var activeRecipe = ((ListBoxRow)row).recipe;

        stackManager.setDetailRecipe(activeRecipe);

        stackManager.getStack().visible_child_name = "detail-view";
    }
}
}
