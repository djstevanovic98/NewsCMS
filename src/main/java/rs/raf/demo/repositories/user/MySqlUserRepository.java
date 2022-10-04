package rs.raf.demo.repositories.user;

import org.apache.commons.codec.digest.DigestUtils;
import rs.raf.demo.entities.User;
import rs.raf.demo.repositories.MySqlAbstractRepository;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MySqlUserRepository extends MySqlAbstractRepository implements UserRepository{
    @Override
    public List<User> allUsers() {
        List<User> users = new ArrayList<>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from users");

            while(resultSet.next()){
                users.add(new User(resultSet.getInt("id"),
                        resultSet.getString("email"),
                        resultSet.getString("username"),
                        resultSet.getString("password"),
                        resultSet.getString("tip"),
                        resultSet.getString("status")));
            }
        } catch (Exception e) {
            System.out.println("allUsers exception!");
        }finally {
            this.closeStatement(statement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
        System.out.println("Lista usera iz allUsers: ----> " + users);
        return users;
    }

    @Override
    public User findUser(Integer id) {
        User user = null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM users where id = ?");
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                int userId = resultSet.getInt("id");
                String email = resultSet.getString("email");
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                String status = resultSet.getString("status");
                String tip = resultSet.getString("tip");
                user = new User(userId,email,username,password,status,tip);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return user;
    }

    @Override
    public User findUser(String email) {
        User user = null;
        System.out.println("user nakon null:" + user);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM users where email = ?");
            preparedStatement.setString(1, email);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                int userId = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                String tip = resultSet.getString("tip");
                String status = resultSet.getString("status");
                user = new User(userId,email,username,password,tip,status);
                System.out.println(user.getId() + user.getEmail()+user.getPassword());
            }
            System.out.println("FINDUSER GET TIP: ____________________ " + user.getTip());

            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
        System.out.println("user:" + user.getEmail());
        return user;
    }

    @Override
    public User addUser(User user) {

        String hashedPassword = DigestUtils.sha256Hex(user.getPassword());
        user.setPassword(hashedPassword);

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            String[] generatedColumns = {"id"};

            preparedStatement = connection.prepareStatement("INSERT INTO users (email, username, password, status, tip) VALUES(?, ?, ?, ?, ?)", generatedColumns);
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getUsername());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getStatus());
            preparedStatement.setString(5, user.getTip());
            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                user.setId(resultSet.getInt(1));
            }
        }catch (Exception e){
            System.out.println("addUser exception!");
        }finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
        return user;
    }

    @Override
    public void deleteUser(Integer id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("DELETE FROM users where id = ?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeConnection(connection);
        }
    }

    @Override
    public void updateUser(User user) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("UPDATE users SET email = ?, username = ?, password = ?, tip = ?, status = ?  WHERE id = ?");
            preparedStatement.setString(1, user.getEmail());
            preparedStatement.setString(2, user.getUsername());
            preparedStatement.setString(3, user.getPassword());
            preparedStatement.setString(4, user.getStatus());
            preparedStatement.setString(5, user.getTip());
            preparedStatement.setInt(6, user.getId());
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeConnection(connection);
        }

    }

}
