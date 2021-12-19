import java.util.ArrayList;

public class Book {
    private String isbn;
    private String title;
    private int num_pages;
    private float price;
    private int pub_id;
    private int percentage;
    private int stock;
    private Publisher pub;
    private ArrayList<Author> authors;
    private ArrayList<Genre> genres;
    Book(){
        authors = new ArrayList<Author>();
        genres = new ArrayList<Genre>();
    }
    Book(String isbn){
        this.isbn = isbn;
        authors = new ArrayList<Author>();
        genres = new ArrayList<Genre>();
    }
    Book(String isbn, String title, int num_pages, float price, int pub_id, int percentage, int stock){
        this.isbn = isbn;
        this.title = title;
        this.num_pages = num_pages;
        this.price = price;
        this.pub_id = pub_id;
        this.percentage = percentage;
        this.stock = stock;
        authors = new ArrayList<Author>();
        genres = new ArrayList<Genre>();
    }

    public String getIsbn() {
        return isbn;
    }

    public String getTitle() {
        return title;
    }

    public int getNum_pages() {
        return num_pages;
    }

    public float getPrice() {
        return price;
    }

    public int getPub_id() {
        return pub_id;
    }

    public int getPercentage() {
        return percentage;
    }

    public int getStock() {
        return stock;
    }

    public Publisher getPub() {
        return pub;
    }

    public ArrayList<Author> getAuthors() {
        return authors;
    }

    public ArrayList<Genre> getGenres() {
        return genres;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setNum_pages(int num_pages) {
        this.num_pages = num_pages;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public void setPub_id(int pub_id) {
        this.pub_id = pub_id;
    }

    public void setPercentage(int percentage) {
        this.percentage = percentage;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setPub(Publisher pub) {
        this.pub = pub;
    }

    public void addAuthor(Author auth) {
        authors.add(auth);
    }
    public void addGenre(Genre gen) {
        genres.add(gen);
    }
}
