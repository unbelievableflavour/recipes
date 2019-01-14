namespace Application {
public class Recipe : Object {
    private string name = "";
    private string markDownFile = "";

    public string getName(){
        return this.name;
    }

    public void setName(string name){
        this.name = name;    
    }

    public string getMarkdownFile(){
        return this.markDownFile;
    }

    public void setMarkdownFile(string markDownFile){
        this.markDownFile = markDownFile;    
    }
}
}
