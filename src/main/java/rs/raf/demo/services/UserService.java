package rs.raf.demo.services;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import org.apache.commons.codec.digest.DigestUtils;
import rs.raf.demo.entities.User;
import rs.raf.demo.repositories.user.UserRepository;

import javax.inject.Inject;
import java.util.Date;
import java.util.List;

public class UserService {

    public UserService(){
        System.out.println(this);
    }

    @Inject
    private UserRepository userRepository;

    public List<User> allUsers(){
        return this.userRepository.allUsers();
    }


    public User addUser(User user) {
        return this.userRepository.addUser(user);
    }

    public User findUser(String email) {
        return this.userRepository.findUser(email);
    }

    public User findUser(Integer id) {
        return this.userRepository.findUser(id);
    }

    public void updateUser(User user) {
        this.userRepository.updateUser(user);
    }

    public String login(String email, String password)
    {
        String hashedPassword = DigestUtils.sha256Hex(password);

        User user = this.userRepository.findUser(email);
        System.out.println("User role: " + user.getTip());
        if (user == null || !user.getPassword().equals(hashedPassword) || (user.getStatus().equals("neaktivan"))) {
            return null;
        }

        Date issuedAt = new Date();
        Date expiresAt = new Date(issuedAt.getTime() + 24*60*60*1000); // One day

        Algorithm algorithm = Algorithm.HMAC256("secret");

        // JWT-om mozete bezbedono poslati informacije na FE
        // Tako sto sve sto zelite da posaljete zapakujete u claims mapu
        return JWT.create()
                .withIssuedAt(issuedAt)
                .withExpiresAt(expiresAt)
                .withSubject(email)
                .withClaim("role", user.getTip())
                .sign(algorithm);
    }

    public boolean isAuthorized(String token){
        System.out.println("USO SAM U isAuthorized!!!!!!!!!!!");
        Algorithm algorithm = Algorithm.HMAC256("secret");
        JWTVerifier verifier = JWT.require(algorithm)
                .build();
        DecodedJWT jwt = verifier.verify(token);

        String username = jwt.getSubject();

        User user = this.userRepository.findUser(username);

        if (user == null || (user.getStatus().equals("neaktivan"))){
            return false;
        }

        return true;
    }

    public boolean isAdmin(String token){
        System.out.println("USO SAM U isAdmin!!!!!!!!!!!");
        Algorithm algorithm = Algorithm.HMAC256("secret");
        JWTVerifier verifier = JWT.require(algorithm)
                .build();
        DecodedJWT jwt = verifier.verify(token);

        String username = jwt.getSubject();

        User user = this.userRepository.findUser(username);

        if (user == null || (user.getStatus().equals("neaktivan"))){
            return false;
        }

        if(user.getTip().equals("admin")) {
            System.out.println("ADMIN SE PRIJAVIO");
            return true;
        }
        return false;
    }

}
