namespace Application {
public class StackManager : Object {

    static StackManager? instance;

    private Gtk.Stack stack;
    private const string LIST_VIEW_ID = "list-view";
    private const string EMPTY_VIEW_ID = "empty-view";
    private const string WELCOME_VIEW_ID = "welcome-view";
    private const string PROGRESS_VIEW_ID = "progress-view";
    private const string DETAIL_VIEW_ID = "detail-view";
    public Widgets.WebView preview_view_content;
    private Gtk.ScrolledWindow preview_view;
    public Gtk.Window main_window;

    StackManager () {
        stack = new Gtk.Stack ();
        stack.margin_bottom = 4;
        stack.transition_type = Gtk.StackTransitionType.CROSSFADE;
    }

    public static StackManager get_instance () {
        if (instance == null) {
            instance = new StackManager ();
        }
        return instance;
    }

    public Gtk.Stack get_stack () {
        return this.stack;
    }

    public void load_views (MainWindow window) {
        preview_view = new Gtk.ScrolledWindow (null, null);
        preview_view_content = new Widgets.WebView (window);
        preview_view.add (preview_view_content);
        main_window = window;

        stack.add_named (new ListView (), LIST_VIEW_ID);
        stack.add_named (new ProgressView (), PROGRESS_VIEW_ID);
        stack.add_named (preview_view, DETAIL_VIEW_ID);

        stack.notify["visible-child"].connect (() => {
            var header_bar = HeaderBar.get_instance ();

            if (stack.get_visible_child_name () == DETAIL_VIEW_ID) {
                header_bar.show_language_mode (true);
                header_bar.show_page_title (true);
                header_bar.show_return_button (true);
                header_bar.show_download_button (true);
            }

            if (stack.get_visible_child_name () == PROGRESS_VIEW_ID) {
                header_bar.show_language_mode (false);
                header_bar.show_page_title (false);
                header_bar.show_return_button (false);
                header_bar.show_download_button (false);
            }

            if (stack.get_visible_child_name () == LIST_VIEW_ID) {
                header_bar.show_language_mode (false);
                header_bar.show_page_title (false);
                header_bar.show_return_button (false);
                header_bar.show_download_button (false);
            }
        });

        window.add (stack);
        window.show_all ();
   }

   public void set_detail_recipe (Recipe recipe) {

        var header_bar = HeaderBar.get_instance ();
        header_bar.update_languages_button (recipe.get_languages ());
        header_bar.update_page_title (recipe);
        preview_view_content.load_recipe (recipe);
   }

   public Recipe get_detail_recipe () {
        return preview_view_content.get_recipe ();
   }

   public Widgets.WebView get_webview () {
        return preview_view_content;
   }
}
}
