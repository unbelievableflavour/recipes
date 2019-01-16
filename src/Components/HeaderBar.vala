using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {
    
    static HeaderBar? instance;

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    ListBox listBox = ListBox.get_instance();    
    public Gtk.Button return_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton language_button = new Granite.Widgets.ModeButton();

    HeaderBar() {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
        
        generateLanguageButton();
        generateReturnButton();

        this.pack_start (return_button);
        this.show_close_button = true;
    }
 
    public static HeaderBar get_instance() {
        if (instance == null) {
            instance = new HeaderBar();
        }
        return instance;
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


    public void showLanguageMode(bool answer){        
        language_button.visible = answer;
        if(answer == true) {
            this.set_custom_title(language_button);
        }
    }

    public void showReturnButton(bool answer){
        return_button.visible = answer;
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
