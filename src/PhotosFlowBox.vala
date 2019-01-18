using Granite.Widgets;

namespace Application {
public class PhotosFlowBox : Gtk.FlowBox {

    static PhotosFlowBox? instance;

    private StackManager stack_manager = StackManager.get_instance ();


    PhotosFlowBox () {
        this.margin_end = 10;
        this.margin_start = 10;
        this.set_selection_mode (Gtk.SelectionMode.NONE);
        this.activate_on_single_click = false;
        this.set_homogeneous (false);
    }

    public static PhotosFlowBox get_instance () {
        if (instance == null) {
            instance = new PhotosFlowBox ();
        }
        return instance;
    }

    public void empty_list () {
        this.foreach ((ListBoxRow) => {
            this.remove (ListBoxRow);
        });
    }

    public void get_installed_packages (Recipe[] recipes) {
        stack_manager.get_stack ().visible_child_name = "list-view";

        empty_list ();
        foreach (Recipe recipe in recipes) {
            var card = new PhotoCard (recipe);
            this.add (card);
            card.show_all ();
        }
    }
}
}
