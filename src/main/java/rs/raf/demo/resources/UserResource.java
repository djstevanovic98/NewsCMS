package rs.raf.demo.resources;

import rs.raf.demo.entities.User;
import rs.raf.demo.requests.LoginRequest;
import rs.raf.demo.services.UserService;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.HashMap;
import java.util.Map;

@Path("/users")
public class UserResource {

    @Inject
    private UserService userService;

    @GET
    @Produces({MediaType.APPLICATION_JSON})
    public Response all() {
        return Response.ok(this.userService.allUsers()).build();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public User find(@PathParam("id") Integer id) {
        return this.userService.findUser(id);
    }

    @POST
    @Path("/login")
    @Produces({MediaType.APPLICATION_JSON})
    public Response login(@Valid LoginRequest loginRequest)
    {
        Map<String, String> response = new HashMap<>();

        String jwt = this.userService.login(loginRequest.getEmail(), loginRequest.getPassword());
        if (jwt == null) {
            response.put("message", "These credentials do not match our records");
            return Response.status(422, "Unprocessable Entity").entity(response).build();
        }

        response.put("jwt", jwt);

        return Response.ok(response).build();
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public User create(@Valid User user) {

        return this.userService.addUser(user);
    }

    @PUT
    @Path("/{id}")
    public void update(@Valid User user, @PathParam("id") int id) {
        user.setId(id);
        this.userService.updateUser(user);
    }

    @POST
    @Path("/admin")
    @Produces(MediaType.TEXT_PLAIN)
    public Response postAdmin(@CookieParam("jwt") String value) {
        System.out.println("Cookie value: " + value);
        if (value == null) {
            return Response.serverError().entity("ERROR").build();
        } else {
            if(userService.isAdmin(value)) {
                return Response.ok(value).build();
            }
            return Response.serverError().entity("ERROR").build();
        }
    }

    @GET
    @Path("/provera")
    @Produces(MediaType.TEXT_PLAIN)
    public Response provera(@CookieParam("jwt") String value) {
        System.out.println("Cookie value: " + value);
        if (value == null) {
            return Response.serverError().entity("ERROR").build();
        } else {
            if(userService.isAuthorized(value)) {
                return Response.ok(value).build();
            }
            return Response.serverError().entity("ERROR").build();
        }
    }

    @GET
    @Path("/admin")
    @Produces(MediaType.TEXT_PLAIN)
    public Response admin(@CookieParam("jwt") String value) {
        if (value == null) {
            return Response.serverError().entity("ERROR").build();
        } else {
            if(userService.isAdmin(value)) {
                return Response.ok(value).build();
            }
            return Response.serverError().entity("ERROR").build();
        }
    }

    @GET
    @Path("/{email}/findmail")
    @Produces(MediaType.APPLICATION_JSON)
    public User findUser(@PathParam("email") String email) {
        return this.userService.findUser(email);
    }

}
