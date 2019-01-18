using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window {

    private StackManager stack_manager = StackManager.get_instance ();
    private RecipeFileManager recipe_file_manager = RecipeFileManager.get_instance ();
    private HeaderBar header_bar = HeaderBar.get_instance ();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                icon_name: Constants.APPLICATION_NAME,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

        set_default_size (Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT);
        set_titlebar (header_bar);

        stack_manager.load_views (this);

        stack_manager.get_stack ().visible_child_name = "progress-view";
        recipe_file_manager.get_recipes_from_json ();

        add_shortcuts ();
    }

    private void add_shortcuts () {
        key_press_event.connect ((e) => {
            switch (e.keyval) {
                case Gdk.Key.r:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    stack_manager.get_stack ().visible_child_name = "progress-view";
                    recipe_file_manager.get_recipes_from_json ();
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    this.destroy ();
                  }
                  break;
            }

            return false;
        });
    }
}
}
