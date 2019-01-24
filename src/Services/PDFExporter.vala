using Granite.Widgets;

namespace Application {
public class PDFExporter {

    private StackManager stack_manager = StackManager.get_instance ();

    private enum DialogType {
        MARKDOWN_OUT,
        MARKDOWN_IN,
        HTML_OUT,
        PDF_OUT
    }

    public void export_as_pdf () {
        var file = get_file_from_user (DialogType.PDF_OUT);

        try {
            FileHandler.create_file_if_not_exists (file);
        } catch (Error e) {
            warning ("Could not write initial PDF file: %s", e.message);
            return;
        }

        var op = new WebKit.PrintOperation (stack_manager.get_webview ());
        var settings = new Gtk.PrintSettings ();
        settings.set (Gtk.PRINT_SETTINGS_PRINTER,
                      dgettext ("gtk30", "Print to File"));

        settings.set (Gtk.PRINT_SETTINGS_OUTPUT_URI,
                  "file://" + file.get_path ());

        settings.set (Gtk.PRINT_SETTINGS_OUTPUT_FILE_FORMAT, "pdf");
        op.set_print_settings (settings);

        op.print ();
    }


    private File? get_file_from_user (DialogType dtype) {
        File? result = null;

        string title = "";
        Gtk.FileChooserAction chooser_action = Gtk.FileChooserAction.SAVE;
        string accept_button_label = "";
        List<Gtk.FileFilter> filters = new List<Gtk.FileFilter> ();

        switch (dtype) {
        case DialogType.MARKDOWN_OUT:
            title = _("Select destination markdown file");
            chooser_action = Gtk.FileChooserAction.SAVE;
            accept_button_label = _("Save");

            filters.append (get_markdown_filter ());
            break;

        case DialogType.MARKDOWN_IN:
            title = _("Select markdown file to open");
            chooser_action = Gtk.FileChooserAction.OPEN;
            accept_button_label = _("Open");

            filters.append (get_markdown_filter ());
            break;

        case DialogType.HTML_OUT:
            title = _("Select destination HTML file");
            chooser_action = Gtk.FileChooserAction.SAVE;
            accept_button_label = _("Save");

            var html_filter = new Gtk.FileFilter ();
            html_filter.set_filter_name ("HTML File");

            html_filter.add_mime_type ("text/plain");
            html_filter.add_mime_type ("text/html");

            html_filter.add_pattern ("*.html");
            html_filter.add_pattern ("*.htm");

            filters.append (html_filter);
            break;

        case DialogType.PDF_OUT:
            title = _("Select destination PDF file");
            chooser_action = Gtk.FileChooserAction.SAVE;
            accept_button_label = _("Save");

            var pdf_filter = new Gtk.FileFilter ();
            pdf_filter.set_filter_name ("PDF File");

            pdf_filter.add_mime_type ("application/pdf");
            pdf_filter.add_pattern ("*.pdf");

            filters.append (pdf_filter);
            break;

        }

        var all_filter = new Gtk.FileFilter ();
        all_filter.set_filter_name ("All Files");
        all_filter.add_pattern ("*");

        filters.append (all_filter);

        var dialog = new Gtk.FileChooserDialog (
            title,
            new Gtk.Window (),
            chooser_action,
            _("_Cancel"), Gtk.ResponseType.CANCEL,
            accept_button_label, Gtk.ResponseType.ACCEPT);


        filters.@foreach ((filter) => {
            dialog.add_filter (filter);
        });

        if (dialog.run () == Gtk.ResponseType.ACCEPT) {
            result = dialog.get_file ();
        }

        dialog.close ();

        return result;
    }

    private Gtk.FileFilter get_markdown_filter () {
        var mk_filter = new Gtk.FileFilter ();
        mk_filter.set_filter_name ("Markdown File");

        mk_filter.add_mime_type ("text/plain");
        mk_filter.add_mime_type ("text/x-markdown");

        mk_filter.add_pattern ("*.md");
        mk_filter.add_pattern ("*.markdown");
        mk_filter.add_pattern ("*.mkd");

        return mk_filter;
    }
}
}
