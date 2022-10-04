package rs.raf.demo.entities;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class Komentar {
    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String name;

    @NotNull(message = "Title field is required")
    @NotEmpty(message = "Title field is required")
    private String comment;

    private String date;

    private int id;
    private int postId;

    public Komentar(int id, String autor, String tekst, String date) {
        this.postId = id;
        this.name = autor;
        this.comment = tekst;
        this.date = date;
    };
    public Komentar(){};

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getName() {
        return name;
    }

    public String getDate() {
        return date;
    }

    public String getComment() {
        return comment;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getPostId() {
        return postId;
    }

    public void setId(int id) {
        this.id = id;
    }
}
