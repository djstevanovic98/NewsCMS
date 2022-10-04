package rs.raf.demo.resources;

import rs.raf.demo.entities.Citat;
import rs.raf.demo.entities.Komentar;
import rs.raf.demo.services.PostService;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/posts")
public class PostResource {

    @Inject
    private PostService postService;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response all() {
        return Response.ok(this.postService.allPosts()).build();
    }

    @GET
    @Path("/{id}/page")
    @Produces(MediaType.APPLICATION_JSON)
    public Response page(@PathParam("id") Integer id) {
        return Response.ok(this.postService.pagePosts(id)).build();
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public Citat create(@Valid Citat citat) {
        return this.postService.addPost(citat);
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Citat find(@PathParam("id") Integer id) {
        return this.postService.findPost(id);
    }

    @DELETE
    @Path("/{id}")
    public void delete(@PathParam("id") Integer id) {
        this.postService.deletePost(id);
    }


    @GET
    @Path("/{id}/comments")
    @Produces(MediaType.APPLICATION_JSON)
    public Response all(@PathParam("id") Integer id) {
        return Response.ok(this.postService.allComments(id)).build();
    }


    @POST
    @Path("/comments")
    @Produces(MediaType.APPLICATION_JSON)
    public Komentar addComment(@Valid Komentar komentar) {
        return this.postService.addComment(komentar);
    }

    @DELETE
    @Path("/comments/{id}")
    public void deleteComment(@PathParam("id") Integer id) {
        this.postService.deleteComment(id);
    }

    @GET
    @Path("/{id}/brPoseta")
    public void brPoseta(@PathParam("id") Integer id) {
        this.postService.brPoseta(id);
    }

    @GET
    @Path("/{id}/like")
    public void like(@PathParam("id") Integer id) {
        this.postService.like(id);
    }

    @GET
    @Path("/{id}/dislike")
    public void dislike(@PathParam("id") Integer id) {
        this.postService.dislike(id);
    }

    @GET
    @Path("/top3")
    @Produces(MediaType.APPLICATION_JSON)
    public Response top3() {
        return Response.ok(this.postService.top3()).build();
    }

    @GET
    @Path("/{id}/mostViewed")
    @Produces(MediaType.APPLICATION_JSON)
    public Response mostViewed(@PathParam("id") Integer id) {
        return Response.ok(this.postService.mostViewed(id)).build();
    }

    @GET
    @Path("/{id}/{pretraga}/search")
    @Produces(MediaType.APPLICATION_JSON)
    public Response search(@PathParam("id") Integer id, @PathParam("pretraga") String pretraga) {
        return Response.ok(this.postService.search(id, pretraga)).build();
    }

    @GET
    @Path("/{tag}/{id}/tagPostovi")
    @Produces(MediaType.APPLICATION_JSON)
    public Response tagPostovi(@PathParam("tag") String tag, @PathParam("id") Integer id) {
        return Response.ok(this.postService.tagPostovi(tag, id)).build();
    }

    @GET
    @Path("/{tag}/triTaga")
    @Produces(MediaType.APPLICATION_JSON)
    public Response triTaga(@PathParam("tag") String tag) {
        return Response.ok(this.postService.triTaga(tag)).build();
    }
}
