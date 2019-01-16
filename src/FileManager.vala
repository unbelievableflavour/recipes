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
        var parser = new Json.Parser ();
        try {
            parser.load_from_file ("../data/recipes.json");
            return get_data (parser);
        } catch (Error e) {
            new Alert("Request page fail", e.message);
        }
        return null;
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

    private File getRecipeFile(string fileName, string lang){
        try {
            return File.new_for_uri ("https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/" + fileName + "/recipe_" + lang + ".md");
        } catch (Error e) {
            error ("%s", e.message);
        }
    }
}
}

