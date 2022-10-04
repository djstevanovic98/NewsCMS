package rs.raf.demo.entities;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;

public class Citat {
    private int id;

    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String author;

    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String title;

    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String quote;

    private String date;
    private int brojPoseta;
    private int like;
    private int dislike;
    private String tag;

    public Citat(){
    }

    public Citat(String author, String title, String quote){
        this();
        this.author=author;
        this.title=title;
        this.quote=quote;
    }

    public Citat(int id, String author, String title, String quote) {
        this(author,title,quote);
        this.id=id;
    }
    public Citat(int id, String author, String title, String quote, String date) {
        this(id ,author,title,quote);
        this.date = date;
    }
    public Citat(int id, String author, String title, String quote, String date, int brojPoseta, int like, int dislike, String tag){
        this(id ,author,title,quote, date);
        this.brojPoseta = brojPoseta;
        this.like = like;
        this.dislike = dislike;
        this.tag = tag;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setQuote(String quote) {
        this.quote = quote;
    }

    public void setDate(String datum) {
        this.date = date;
    }

    public void setBrojPoseta(int brojPoseta) {
        this.brojPoseta = brojPoseta;
    }

    public int getId() {
        return id;
    }

    public String getAuthor() {
        return author;
    }

    public String getTitle() {
        return title;
    }

    public String getQuote() {
        return quote;
    }

    public String getDate() {
        return date;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    public int getLike() {
        return like;
    }

    public int getDislike() {
        return dislike;
    }

    public void setLike(int like) {
        this.like = like;
    }

    public void setDislike(int dislike) {
        this.dislike = dislike;
    }

    public int getBrojPoseta() {
        return brojPoseta;
    }
}
