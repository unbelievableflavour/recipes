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
        var file = File.new_for_path ("../recipes/" + fileName + "/recipe.md");
        if (!file.query_exists ()) {
            try {
                file.create (FileCreateFlags.REPLACE_DESTINATION, null);
                getRecipeFile(fileName);
            } catch (Error e) {
                error ("%s", e.message);
            }
        }
        return file;
    }
}
}

