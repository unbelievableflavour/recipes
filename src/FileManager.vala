namespace Application {
public class FileManager : Object {

    static FileManager? instance;
    private string recipeDirName;

    File file = null;

    FileManager() {
    }
 
    public static FileManager get_instance() {
        if (instance == null) {
            instance = new FileManager();
        }
        return instance;
    }

    public File getFile() {
        return this.file;
    }

    public void setFile(File newFile){
        this.file = newFile;
    }

    public string fileToString (File file){
        var lines = new DataInputStream (file.read ());

        string fileString = "";
        string line;

        while ((line = lines.read_line ()) != null) {
	        fileString += line +"\n";
        }

        return fileString;
    }

    public Recipe[] getRecipesFromJSON (){
        var session = new Soup.Session();
        var message = new Soup.Message ("GET", "https://raw.githubusercontent.com/bartzaalberg/recipes/master/data/recipes.json");
        Recipe[] recipes = new Recipe[0]; 
        session.queue_message (message, (sess, mess) => {
            if (mess.status_code == 200) {
                var parser = new Json.Parser ();
                try {
                    parser.load_from_data ((string) mess.response_body.flatten ().data, -1);

                    ListBox listBox = ListBox.get_instance();
                    listBox.getInstalledPackages(get_data (parser));

                } catch (Error e) {
                    new Alert("Request page fail", e.message);
                }
            } else {
                new Alert("Request page fail", @"status code: $(mess.status_code)");
            }
        });
        return recipes;
    }

    private Recipe[] get_data (Json.Parser parser) {
        Recipe[] recipes = new Recipe[0];

        var node = parser.get_root ();
        unowned Json.Array array = node.get_array ();
        foreach (unowned Json.Node item in array.get_elements ()) {
            var object = item.get_object();

            var file = getRecipeFile(object.get_string_member ("id"), "en");
            var markdownFile = fileToString(file);

            var recipe = new Recipe();
            recipe.setId(object.get_string_member ("id"));
            recipe.setName(object.get_string_member ("title"));
            recipe.setThumbnail(object.get_string_member ("thumbnail"));
            recipe.setAuthor(object.get_string_member ("author"));
            recipe.setLanguages(object.get_array_member ("languages"));
            recipe.setMarkdownFile(markdownFile);

            recipes += recipe;
        }
        return recipes;
    }

    public File getRecipeFile(string fileName, string lang){
        try {
            return File.new_for_uri ("https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/" + fileName + "/recipe_" + lang + ".md");
        } catch (Error e) {
            error ("%s", e.message);
        }
    }
}
}

