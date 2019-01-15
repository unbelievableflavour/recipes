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
            parser.load_from_file ((string) "../data/recipes.json");
            return get_data (parser);
            // request_page_success(list);
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

            var file = getRecipeFile(object.get_string_member ("id"));
            var markdownFile = fileToString(file);

            var recipe = new Recipe();
            recipe.setId(object.get_string_member ("id"));
            recipe.setName(object.get_string_member ("title"));
            recipe.setMarkdownFile(markdownFile);

            recipes += recipe;
        }
        return recipes;
    }

    public Recipe[] getRecipes (){
        Recipe[] recipes = new Recipe[0];

        try{
            var directory = Dir.open("../recipes");

            while ((recipeDirName = directory.read_name()) != null) {

                var file = getRecipeFile(recipeDirName);
                var markdownFile = fileToString(file);                
                
                var recipe = new Recipe();
                recipe.setName(recipeDirName);
                recipe.setMarkdownFile(markdownFile);

                recipes += recipe;
            }
        } catch (Error e){
            new Alert("An error occured", e.message);
        }

        return recipes;
    }

    private File getRecipeFile(string fileName){
        try {
            return File.new_for_uri ("https://raw.githubusercontent.com/bartzaalberg/recipes/master/recipes/" + fileName + "/recipe.md");
        } catch (Error e) {
            error ("%s", e.message);
        }
    }
}
}

