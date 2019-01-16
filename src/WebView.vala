/*
* Copyright (c) 2017 Lains
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
*/
using WebKit;

namespace Application {
    public class Widgets.WebView : WebKit.WebView {
        public MainWindow parent_window;
        private Recipe recipe = new Recipe();
        public WebView (MainWindow window) {
            Object(user_content_manager: new UserContentManager());
            parent_window = window;
            visible = true;
            vexpand = true;
            hexpand = true;
            var settingsweb = get_settings();
            settingsweb.enable_plugins = false;
            settingsweb.enable_page_cache = true;
            settingsweb.enable_developer_extras = false;
            web_context.set_cache_model(WebKit.CacheModel.DOCUMENT_VIEWER);

            update_html_view ();
            connect_signals ();
        }

        protected override bool context_menu (
            ContextMenu context_menu,
            Gdk.Event event,
            HitTestResult hit_test_result
        ) {
            return true;
        }

        private string set_stylesheet () {
            return "
    html {
      font-size: 16px;
    }

    p {
      font-size: 1rem;
      color: #232629;
    }

    h1,
    h2,
    h3 {
      margin: 0.755em 0;
      font-style: bold;
    }

    h1 {
      margin-top: 0;
      font-size: 2rem;
    }

    h2 {
      font-size: 1.5rem;
    }

    h3 {
      font-size: 1.25rem;
    }

    h4 {
      font-size: 1rem;
    }

    h5 {
      font-size: .875rem;
    }

    h6 {
      font-size: .75rem;
    }

    small {
      font-size: .7em;
    }

    img,
    canvas,
    iframe,
    video,
    svg,
    select,
    textarea {
      display: block;
      max-width: 50%;
    }

    body {
      color: #232629;
      background-color: #FCFCFC;
      font-family: 'Open Sans', Helvetica, sans-serif;
      font-weight: 400;
      line-height: 1.5;
      margin-left: 80px;
      margin-right: 80px;
      margin-top: 40px;
      max-width: 100%;
      text-align: left;
      word-wrap: break-word;
    }

    table {
      border-spacing: 0;
      border-collapse: collapse;
      margin-top: 0;
      margin-bottom: 16px;
    }

    table th {
      font-weight: bold;
      background-color: #E7E7E7;
    }

    table th,
    table td {
      padding: 8px 13px;
      border: 1px solid #EAEAEA;
    }

    table tr {
      border-top: 1px solid #EAEAEA;
    }

    img {
      border-radius: .5rem;
      height: auto;
      margin: 0 auto;
    }

    a,
    a:visited,
    a:hover,
    a:focus,
    a:active {
      color: #3daee9;
    }

    code {
      font-family: 'PT Mono', monospace;
      text-align: left;
      padding: 1rem !important;
      border-radius: 5px;
    }

    blockquote {
      margin: 0;
      border-left: 5px solid #3daee9;
      font-style: italic;
      padding-left: .8rem;
      text-align: left;
    }

    ul,
    ol,
    li {
      text-align: left;
      color: #4d4d4d;
    }
  ";
       }

        public void loadRecipe(Recipe recipe){

            if(recipe.getName() != null){
                this.recipe = recipe;
            }
            update_html_view();
        }

        public Recipe getRecipe(){
            return this.recipe;
        }

        private string set_highlight_stylesheet () {
            return Build.PKGDATADIR + "/highlight.js/styles/default.min.css";
        }

        private void connect_signals () {
            create.connect ((navigation_action) => {
                launch_browser (navigation_action.get_request().get_uri ());
                return (Gtk.Widget) null;
            });

            decide_policy.connect ((decision, type) => {
                switch (type) {
                    case WebKit.PolicyDecisionType.NEW_WINDOW_ACTION:
                        if (decision is WebKit.ResponsePolicyDecision) {
                            launch_browser ((decision as WebKit.ResponsePolicyDecision).request.get_uri ());
                        }
                    break;
                    case WebKit.PolicyDecisionType.RESPONSE:
                        if (decision is WebKit.ResponsePolicyDecision) {
                            var policy = (WebKit.ResponsePolicyDecision) decision;
                            launch_browser (policy.request.get_uri ());
                            return false;
                        }
                    break;
                }

                return true;
            });

            load_changed.connect ((event) => {
                if (event == WebKit.LoadEvent.FINISHED) {
                    var rectangle = get_window_properties ().get_geometry ();
                    set_size_request (rectangle.width, rectangle.height);
                }
            });
        }

        private void launch_browser (string url) {
            if (!url.contains ("/embed/")) {
                try {
                    AppInfo.launch_default_for_uri (url, null);
                } catch (Error e) {
                    warning ("No app to handle urls: %s", e.message);
                }
                stop_loading ();
            }
        }

        /**
         * Process the frontmatter of a markdown document, if it exists.
         * Returns the frontmatter data and strips the frontmatter from the markdown doc.
         *
         * @see http://jekyllrb.com/docs/frontmatter/
         */
        private string[] process_frontmatter (string raw_mk, out string processed_mk) {
            string[] map = {};

            processed_mk = null;

            // Parse frontmatter
            if (raw_mk.length > 4 && raw_mk[0:4] == "---\n") {
                int i = 0;
                bool valid_frontmatter = true;
                int last_newline = 3;
                int next_newline;
                string line = "";
                while (true) {
                    next_newline = raw_mk.index_of_char('\n', last_newline + 1);
                    if (next_newline == -1) { // End of file
                        valid_frontmatter = false;
                        break;
                    }
                    line = raw_mk[last_newline+1:next_newline];
                    last_newline = next_newline;

                    if (line == "---") { // End of frontmatter
                        break;
                    }

                    var sep_index = line.index_of_char(':');
                    if (sep_index != -1) {
                        map += line[0:sep_index-1];
                        map += line[sep_index+1:line.length];
                    } else { // No colon, invalid frontmatter
                        valid_frontmatter = false;
                        break;
                    }

                    i++;
                }

                if (valid_frontmatter) { // Strip frontmatter if it's a valid one
                    processed_mk = raw_mk[last_newline:raw_mk.length];
                }
            }

            if (processed_mk == null) {
                processed_mk = raw_mk;
            }

            return map;
        }

        private string process () {
            string processed_mk;
            process_frontmatter (this.recipe.getMarkdownFile(), out processed_mk);
            var mkd = new Markdown.Document (processed_mk.data, 0x00200000 + 0x00004000 + 0x02000000 + 0x01000000 + 0x00400000 + 0x40000000);
        mkd.compile (0x00200000 + 0x00004000 + 0x02000000 + 0x01000000 + 0x00400000 + 0x40000000);

            string result;
            mkd.get_document (out result);

            return result;
        }

        public void update_html_view () {
            string html = "<!doctype html><meta charset=utf-8><head>";
            html += "<link rel=\"stylesheet\" href=\"" + set_highlight_stylesheet() + "\"/>";
            html += "<script src=\"" + Build.PKGDATADIR + "/highlight.js/lib/highlight.min.js\"></script>";
            html += "<script>hljs.initHighlightingOnLoad();</script>";
            html += "<style>" + set_stylesheet () + "</style>";
            html += "</head><body><div class=\"markdown-body\">";
            html += process ();
            html += "</div></body></html>";
            this.load_html (html, "file:///");
        }
    }
}
