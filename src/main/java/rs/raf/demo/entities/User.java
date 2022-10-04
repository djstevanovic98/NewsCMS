package rs.raf.demo.entities;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class User {
    private Integer id;

    @Email(message = "must be valid email address")
    private String email;

    private String username;


    private String tip;

    private String status;

    @NotNull
    @NotEmpty
    private String password;

    public User() {

    }
    public User(String email, String username, String password, String tip, String status) {
        this();
        this.email = email;
        this.username = username;
        this.password = password;
        this.status = status;
        this.tip = tip;
        this.password = password;
    }
    public User(Integer id, String email, String username, String password, String status, String tip) {
        this(email, username, password, status, tip);
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public String getTip() {
        return tip;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setTip(String tip) {
        this.tip = tip;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
