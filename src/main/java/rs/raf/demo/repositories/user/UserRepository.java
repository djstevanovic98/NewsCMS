package rs.raf.demo.repositories.user;

import rs.raf.demo.entities.User;

import java.util.List;

public interface UserRepository {
    public User findUser(String email);

    public User findUser(Integer id);

    public User addUser(User user);

    public List<User> allUsers();

    public void deleteUser(Integer id);

    public void updateUser(User user);
}
