package rs.raf.demo.services;

import rs.raf.demo.entities.Citat;
import rs.raf.demo.entities.Komentar;
import rs.raf.demo.repositories.post.PostRepository;

import javax.inject.Inject;
import java.util.List;

public class PostService {

    public PostService(){
        System.out.println(this);
    }

    @Inject
    private PostRepository postRepository;

    public Citat addPost(Citat citat){return this.postRepository.addPost(citat);}

    public List<Citat> allPosts() {
        return this.postRepository.allPosts();
    }

    public Citat findPost(Integer id) {
        return this.postRepository.findPost(id);
    }

    public List<Komentar> allComments(Integer citat){
        return this.postRepository.allComments(citat);
    }

    public Komentar addComment(Komentar komentar){
       return this.postRepository.addComment(komentar);
    }

    public List<Citat> pagePosts(Integer id){return this.postRepository.pagePosts(id);}

    public void brPoseta(Integer id){this.postRepository.brPoseta(id);}

    public void like(Integer id){this.postRepository.like(id);}

    public void dislike(Integer id){this.postRepository.dislike(id);}

    public List<Citat> top3(){return this.postRepository.top3();}

    public List<Citat> mostViewed(Integer id){return this.postRepository.mostViewed(id);}

    public List<Citat> tagPostovi(String tag, Integer id){return this.postRepository.tagPostovi(tag,id);}

    public List<Citat> search(Integer id, String pretraga){
        return this.postRepository.search(id,pretraga);
    }

    public List<Citat> triTaga(String tag){return this.postRepository.triTaga(tag);}

    public void deletePost(Integer id) { this.postRepository.deletePost(id);
    }

    public void deleteComment(Integer id) {this.postRepository.deleteComment(id);
    }
}
