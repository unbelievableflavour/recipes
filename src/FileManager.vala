namespace Application {
public class FileManager : Object {

    static FileManager? instance;

    File file = null;

    FileManager () {
    }

    public static FileManager get_instance () {
        if (instance == null) {
            instance = new FileManager ();
        }
        return instance;
    }

    public File get_file () {
        return this.file;
    }

    public void set_file (File new_file) {
        this.file = new_file;
    }

    public string file_to_string (File file) {
        var lines = new DataInputStream (file.read ());

        string file_string = "";
        string line;

        while ((line = lines.read_line ()) != null) {
            file_string += line +"\n";
        }

        return file_string;
    }

    public Recipe[] get_recipes_from_json () {
        var session = new Soup.Session ();
        var message = new Soup.Message (
            "GET",
            "https://raw.githubusercontent.com/bartzaalberg/recipes/master/data/recipes.json"
        );

        Recipe[] recipes = new Recipe[0];
        session.queue_message (message, (sess, mess) => {
            if (mess.status_code == 200) {
                var parser = new Json.Parser ();
                try {
                    parser.load_from_data ((string) mess.response_body.flatten ().data, -1);

                    ListBox list_box = ListBox.get_instance ();
                    list_box.get_installed_packages (get_data (parser));

                } catch (Error e) {
                    new Alert ("Request page fail", e.message);
                }
            } else {
                new Alert ("Request page fail", @"status code: $(mess.status_code)");
            }
        });
        return recipes;
    }

    private Recipe[] get_data (Json.Parser parser) {
        Recipe[] recipes = new Recipe[0];

        var node = parser.get_root ();
        unowned Json.Array array = node.get_array ();
        foreach (unowned Json.Node item in array.get_elements ()) {
            var object = item.get_object ();

            var file = get_recipe_file (object.get_string_member ("id"), "en");
            var markdown_file = file_to_string (file);

            var recipe = new Recipe ();
            recipe.set_id (object.get_string_member ("id"));
            recipe.set_name (object.get_string_member ("title"));
            recipe.set_thumbnail (object.get_string_member ("thumbnail"));
            recipe.set_author (object.get_string_member ("author"));
            recipe.set_languages (object.get_array_member ("languages"));
            recipe.set_markdown_file (markdown_file);

            recipes += recipe;
        }
        return recipes;
    }

    public File get_recipe_file (string file_name, string lang) {
        try {
            return File.new_for_uri (
                "https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/" +
                 file_name + "/recipe_" + lang + ".md"
            );
        } catch (Error e) {
            error ("%s", e.message);
        }
    }
}
}

