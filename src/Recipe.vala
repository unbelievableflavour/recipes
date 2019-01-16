namespace Application {
public class Recipe : Object {
    private string id = "";
    private string name = "";
    private string author = "";
    private string thumbnail = "";
    private string markDownFile = "";
	Json.Array languages;

    public string getId(){
        return this.id;
    }

    public void setId(string id){
        this.id = id;
    }

    public string getName(){
        return this.name;
    }

    public void setName(string name){
        this.name = name;
    }

    public string getAuthor(){
        return this.author;
    }

    public void setAuthor(string author){
        this.author = author;
    }

    public string getThumbnail(){
        return this.thumbnail;
    }

    public void setThumbnail(string thumbnail){
        this.thumbnail = thumbnail;
    }

    public string getMarkdownFile(){
        return this.markDownFile;
    }

    public void setMarkdownFile(string markDownFile){
        this.markDownFile = markDownFile;    
    }

    public Json.Array getLanguages(){
        return this.languages;
    }

    public void setLanguages(Json.Array languages){
        this.languages = languages;
    }
}
}
