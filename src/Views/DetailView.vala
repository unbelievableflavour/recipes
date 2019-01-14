namespace Application {
public class DetailView : Gtk.Grid{

    Gtk.Label packageInformation = new Gtk.Label (_("Package Information"));
    Gtk.Label packageContact = new Gtk.Label (_("Developer"));
    DetailViewBanner detailViewBanner;

    public DetailView(){
        column_spacing = 12;
        hexpand = true;

        packageInformation.set_line_wrap(true);
        packageInformation.set_max_width_chars(60);

        var recipe = new Recipe();
        recipe.setName("name");

        detailViewBanner = new DetailViewBanner (recipe);

        var content_grid = new Gtk.Grid ();

            content_grid.halign = Gtk.Align.CENTER;
            content_grid.margin = 30;
            content_grid.row_spacing = 20;
            content_grid.orientation = Gtk.Orientation.VERTICAL;
            content_grid.add (packageInformation);
            content_grid.add (packageContact);

        var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scrolled.expand = true;
            scrolled.add (content_grid);

        detailViewBanner.get_style_context().add_class("detail-view-banner");

        attach (detailViewBanner, 0, 0, 1, 1);
        attach (scrolled, 0, 1, 1, 1);
    }

    public void loadRecipe(Recipe recipe){
        packageInformation.set_label("");
        
        if(recipe.getName() != null){
            packageInformation.set_label(recipe.getMarkdownFile());
            packageContact.set_label(recipe.getName());
            detailViewBanner.loadRecipe(recipe);
        }
    }
}}
