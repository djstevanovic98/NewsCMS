package rs.raf.demo.filters;

import rs.raf.demo.entities.User;
import rs.raf.demo.services.UserService;

import javax.inject.Inject;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.core.Response;
import java.io.IOException;

public class AuthFilter implements ContainerRequestFilter {
    @Inject
    UserService userService;

    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        if (!this.isAuthRequired(requestContext)) {
            return;
        }

        try {
            String token = requestContext.getHeaderString("Authorization");
            if(token != null && token.startsWith("Bearer ")) {
                token = token.replace("Bearer ", "");
            }
            if (!this.userService.isAuthorized(token)) {
                requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).build());
            }

            /*ovde*/
        } catch (Exception exception) {
            requestContext.abortWith(Response.status(Response.Status.UNAUTHORIZED).build());
        }
    }

    private boolean isAuthRequired(ContainerRequestContext req) {
        if(req.getMethod().equals("GET")) {
            return false;
        }
        else if (req.getUriInfo().getPath().contains("register")) {
            return true;
        }
        else{
            return true;
        }

        /*if (req.getUriInfo().getPath().contains("login")) {
            return false;
        }*/

    }
}
