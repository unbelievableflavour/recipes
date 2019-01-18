using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    static HeaderBar? instance;

    private StackManager stack_manager = StackManager.get_instance ();
    private FileManager file_manager = FileManager.get_instance ();
    public Gtk.Button return_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton language_button = new Granite.Widgets.ModeButton ();

    HeaderBar () {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);

        generate_language_button ();
        generate_return_button ();

        this.pack_start (return_button);
        this.show_close_button = true;
    }

    public static HeaderBar get_instance () {
        if (instance == null) {
            instance = new HeaderBar ();
        }
        return instance;
    }


    private void generate_language_button () {
        language_button.no_show_all = true;
        language_button.visible = false;
        language_button.margin = 1;
        language_button.notify["selected"].connect (on_language_button_changed);
    }

    private void generate_return_button () {
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.visible = false;
        return_button.get_style_context ().add_class ("back-button");
        return_button.clicked.connect (() => {
            stack_manager.get_stack ().visible_child_name = "list-view";
        });
    }


    public void show_language_mode (bool answer) {
        language_button.visible = answer;
        if (answer == true) {
            this.set_custom_title (language_button);
        }
    }

    public void show_return_button (bool answer) {
        return_button.visible = answer;
    }

    public void update_languages_button (Array<string> languages) {
        language_button.clear_children ();

        for (int i = 0; i < languages.length ; i++) {
            var lang = languages.index (i);
            var label = new Gtk.Label (lang);
            label.get_style_context ().add_class ("view-mode-button");
            label.name = lang;

            language_button.append (label);
        }
    }

    private void on_language_button_changed () {
        var recipe = stack_manager.get_detail_recipe ();
        var lang = recipe.get_languages ().index (language_button.selected);

        var file = file_manager.get_recipe_file (recipe.get_id (), lang);
        var markdown_file = file_manager.file_to_string (file);

        recipe.set_markdown_file (markdown_file);
        stack_manager.set_detail_recipe (recipe);
    }
}
}
