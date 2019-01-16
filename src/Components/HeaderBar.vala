using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {
    
    static HeaderBar? instance;

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    ListBox listBox = ListBox.get_instance();    
    public Gtk.Button return_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton view_mode = new Granite.Widgets.ModeButton();
    private Granite.Widgets.ModeButton language_button = new Granite.Widgets.ModeButton();

    HeaderBar() {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
        
        generateViewMode();
        generateLanguageButton();
        generateReturnButton();

        this.pack_start (return_button);
        this.show_close_button = true;
        this.set_custom_title(view_mode);
    }
 
    public static HeaderBar get_instance() {
        if (instance == null) {
            instance = new HeaderBar();
        }
        return instance;
    }

    private void generateViewMode(){
	    //Create two labels. Assign names for a check later on.
	    var label1 = new Gtk.Label("Home");
        label1.get_style_context().add_class("view-mode-button");
	    label1.name = "home";
            
	    var label2 = new Gtk.Label("Updates");
        label2.get_style_context().add_class("view-mode-button");
	    label2.name = "updates";
        
	    //Add each label to the Mode Button.
	    view_mode.append(label1);
	    view_mode.append(label2);
        view_mode.no_show_all = true;
        view_mode.visible = false;
        view_mode.margin = 1;
        view_mode.notify["selected"].connect (on_view_mode_changed);
    }

    private void generateLanguageButton(){
        language_button.no_show_all = true;
        language_button.visible = false;
        language_button.margin = 1;
        language_button.notify["selected"].connect (on_language_button_changed);
    }

    private void generateReturnButton(){
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.visible = false;
        return_button.get_style_context ().add_class ("back-button");
        return_button.clicked.connect (() => {
            stackManager.getStack().visible_child_name = "list-view";
        });
    }

    public void showViewMode(bool answer){
        view_mode.visible = answer;
        if(answer == true) {
            this.set_custom_title(view_mode);
        }
    }

    public void showLanguageMode(bool answer){        
        language_button.visible = answer;
        if(answer == true) {
            this.set_custom_title(language_button);
        }
    }

    public void showReturnButton(bool answer){
        return_button.visible = answer;
    }

    public void setSelectedViewMode(int answer){
        view_mode.selected = answer;
    }

    private void on_view_mode_changed () {
        if (view_mode.selected == 0){
            stackManager.getStack().visible_child_name = "welcome-view";
        }
        if (view_mode.selected == 1){
            if(stackManager.getStack().get_visible_child_name() == "list-view"){
                return;
            }
            stackManager.getStack().visible_child_name = "progress-view";
            fileManager.getRecipesFromJSON();
        }
    }

    public void updateLanguagesButton(Array<string> languages) {
        language_button.clear_children();

        for (int i = 0; i < languages.length ; i++) {
            var lang = languages.index (i);
	        var label = new Gtk.Label(lang);
            label.get_style_context().add_class("view-mode-button");
	        label.name = lang;

	        language_button.append(label);
	    }
    }

    private void on_language_button_changed () {
        var recipe = stackManager.getDetailRecipe();
        var lang = recipe.getLanguages().index(language_button.selected);

        var file = fileManager.getRecipeFile(recipe.getId(), lang);
        var markdownFile = fileManager.fileToString(file);

        recipe.setMarkdownFile(markdownFile);
        stackManager.setDetailRecipe(recipe);
    }
}
}
