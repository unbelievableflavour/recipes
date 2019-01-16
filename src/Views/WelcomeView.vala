using Granite.Widgets;

namespace Application {
public class WelcomeView : Gtk.ScrolledWindow {

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();

    public WelcomeView(){
        var welcome_view = new Welcome(_("Welcome to Recipes"), _("Click below to find a recipe!"));
        welcome_view.append("document", _("Browse recipes"), _("Browse the recipes"));
        welcome_view.append("list-add", _("Submit your own"), _("Offer your recipes in a PR!"));

        welcome_view.activated.connect ((option) => {
            switch (option) {		
                case 0:
                    stackManager.getStack().visible_child_name = "progress-view";
                    fileManager.getRecipesFromJSON();
					break;
                case 1:
                    stackManager.getStack().visible_child_name = "progress-view";
                    fileManager.getRecipesFromJSON();
					break;
            }
        });
        this.add(welcome_view);
    }
}
}
