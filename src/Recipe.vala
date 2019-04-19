namespace Application {
public class Recipe : Object {
    private string id = "";
    private string name = "";
    private string author = "";
    private string thumbnail = "";
    private string markdown_file = "";
    private int persons = 0;
    Array<string> languages;

    public string get_id () {
        return this.id;
    }

    public void set_id (string id) {
        this.id = id;
    }

    public string get_name () {
        return this.name;
    }

    public void set_name (string name) {
        this.name = name;
    }

    public string get_author () {
        return this.author;
    }

    public void set_author (string author) {
        this.author = author;
    }

    public int get_persons () {
        return this.persons;
    }

    public void set_persons (int persons) {
        this.persons = persons;
    }

    public string get_thumbnail () {
        return this.thumbnail;
    }

    public void set_thumbnail (string thumbnail) {
        this.thumbnail = thumbnail;
    }

    public string get_markdown_file () {
        return this.markdown_file;
    }

    public void set_markdown_file (string markdown_file) {
        this.markdown_file = markdown_file;
    }

    public Array<string> get_languages () {
        return this.languages;
    }

    public void set_languages (Json.Array languages) {
        Array<string> languages_array = new Array<string> ();
        foreach (unowned Json.Node item in languages.get_elements ()) {
            languages_array.append_val (item.get_string ());
        }

        this.languages = languages_array;
    }
}
}
