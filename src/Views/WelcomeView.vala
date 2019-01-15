using Granite.Widgets;

namespace Application {
public class WelcomeView : Gtk.ScrolledWindow {

    private StackManager stackManager = StackManager.get_instance();

    public WelcomeView(){
        var welcome_view = new Welcome(_("Welcome to cookbook"), _("Click below to find a recipe!"));
        welcome_view.append("ubuntu-open", _("Recipes"), _("Browse the recipes"));

        welcome_view.activated.connect ((option) => {
            switch (option) {		
                case 0:
					stackManager.getStack().visible_child_name = "list-view";
					break;
            }
        });
        this.add(welcome_view);
    }
}
}
