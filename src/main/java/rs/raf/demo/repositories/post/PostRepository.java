package rs.raf.demo.repositories.post;

import rs.raf.demo.entities.Citat;
import rs.raf.demo.entities.Komentar;

import java.util.List;

public interface PostRepository {
    public Citat addPost(Citat citat);
    public List<Citat> allPosts();
    public Citat findPost(Integer id);
    public List<Komentar> allComments(Integer id_Citata);
    public Komentar addComment(Komentar komentar);
    public List<Citat> pagePosts(Integer id);
    public void brPoseta(Integer id);
    public void like(Integer id);
    public void dislike(Integer id);
    public List<Citat> top3();
    public List<Citat> mostViewed(Integer id);
    public List<Citat> search(Integer id, String pretraga);
    public List<Citat> tagPostovi(String tag, Integer id);
    public List<Citat> triTaga(String tag);
    void deletePost(Integer id);
    void deleteComment(Integer id);
}
