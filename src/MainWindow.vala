using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

        set_default_size(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT);
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        stackManager.getStack().visible_child_name = "welcome-view";

        addShortcuts();
    }

    private void addShortcuts(){
        key_press_event.connect ((e) => { 
            switch (e.keyval) {
                case Gdk.Key.r:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    stackManager.getStack().visible_child_name = "progress-view";
                    fileManager.getRecipesFromJSON();
                  }
                  break;
                case Gdk.Key.h:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                    stackManager.getStack().visible_child_name = "welcome-view";
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                    this.destroy();
                  }
                  break;
            }

            return false; 
        });
    }
}
}
