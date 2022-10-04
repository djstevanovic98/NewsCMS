package rs.raf.demo.repositories.post;

import rs.raf.demo.entities.Citat;
import rs.raf.demo.entities.Komentar;
import rs.raf.demo.repositories.MySqlAbstractRepository;

import javax.swing.plaf.nimbus.State;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class MySqlPostRepository extends MySqlAbstractRepository implements PostRepository {

    @Override
    public Citat addPost(Citat citat) {

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            String[] generatedColumns = {"id"};

            Date date = new Date();
            citat.setDate(date.toString());

            System.out.println("Citat: " + citat.toString());
            System.out.println("tag: " + citat.getTag());


            preparedStatement = connection.prepareStatement("INSERT INTO posts (author, title, quote, date, brojposeta, `like`, dislike, tag) VALUES(?, ?, ?, ?, ?, ?, ?, ?)", generatedColumns);
            preparedStatement.setString(1, citat.getAuthor());
            preparedStatement.setString(2, citat.getTitle());
            preparedStatement.setString(3, citat.getQuote());
            preparedStatement.setString(4, date.toString());
            preparedStatement.setInt(5, 0);
            preparedStatement.setInt(6,0);
            preparedStatement.setInt(7,0);
            preparedStatement.setString(8,citat.getTag());

            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                citat.setId(resultSet.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return citat;
    }

    @Override
    public List<Citat> allPosts() {
        List<Citat> posts = new ArrayList<>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from posts");
            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(statement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }


        return posts;
    }

    @Override
    public Citat findPost(Integer id) {
        Citat post= null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM posts where id = ?");
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                int postId = resultSet.getInt("id");
                String author = resultSet.getString("author");
                String title = resultSet.getString("title");
                String quote = resultSet.getString("quote");
                String date = resultSet.getString("date");
                int brojposeta = resultSet.getInt("brojposeta");
                int brojlajkova = resultSet.getInt("like");
                int brojdislajkova = resultSet.getInt("dislike");
                String tag = resultSet.getString("tag");
                post = new Citat(postId, author, title, quote,date,brojposeta,brojlajkova,brojdislajkova,tag);
                post.setId(postId);
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
        return post;
    }

    @Override
    public List<Komentar> allComments(Integer id_citata) {
        List<Komentar> komentari = new ArrayList<>();

        Komentar koment = null;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM comments where id = ?");
            preparedStatement.setInt(1, id_citata);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int postId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String comment = resultSet.getString("comment");
                String date = resultSet.getString("date");
                koment = new Komentar(postId, name, comment, date);

                komentari.add(koment);
            }

            resultSet.close();
            preparedStatement.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }


        return komentari;
    }

    @Override //prepravi sve
    public Komentar addComment(Komentar komentar) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            connection = this.newConnection();

            String[] generatedColumns = {"id"};

            Date date = new Date();
            komentar.setDate(date.toString());

            preparedStatement = connection.prepareStatement("INSERT INTO comments (id, name, comment, date) VALUES(?, ?, ?, ?)", generatedColumns);
            preparedStatement.setString(1, String.valueOf(komentar.getPostId()));
            preparedStatement.setString(2, komentar.getName());
            preparedStatement.setString(3, komentar.getComment());
            preparedStatement.setString(4, date.toString());

            preparedStatement.executeUpdate();
            resultSet = preparedStatement.getGeneratedKeys();

            if (resultSet.next()) {
                komentar.setId(resultSet.getInt(1));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return komentar;
    }

    @Override
    public List<Citat> pagePosts(Integer id){
        List<Citat> posts = new ArrayList<>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            statement = connection.createStatement();
            resultSet = statement.executeQuery("select * from posts");

            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));

            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(statement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
        if(id <0){
            id=0;
        }
        int donja_granica = id*5;
        if(donja_granica>posts.size()){
            donja_granica = 0;
        }
        int gornja_granica = donja_granica+5;

        if(posts.size() < gornja_granica){
            gornja_granica = posts.size();
        }
        if(donja_granica==gornja_granica){
            donja_granica = donja_granica-5;
        }
        if(donja_granica<0){
            donja_granica=0;
        }

        List<Citat> strana = posts.subList(donja_granica,gornja_granica);
        return strana;
    }

    @Override
    public void brPoseta(Integer id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try{
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("UPDATE posts SET brojposeta = brojposeta + 1 WHERE id = ?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();
        }catch (Exception e){
            System.out.println("Broj poseta exception!");
        }finally {
            this.closeStatement(preparedStatement);
            this.closeConnection(connection);
        }
    }

    @Override
    public void like(Integer id) {
        System.out.println("usao sam u lajk!");
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try{
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("UPDATE posts SET `like` = posts.like + 1 WHERE id = ?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();
        }catch (Exception e){
            System.out.println("Like expception!");
        }finally {
            this.closeStatement(preparedStatement);
            this.closeConnection(connection);
        }
    }

    @Override
    public void dislike(Integer id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try{
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("UPDATE posts SET dislike = posts.dislike + 1 WHERE id = ?");
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();

            preparedStatement.close();
            connection.close();
        }catch (Exception e){
            System.out.println("dislajk exception!");
        }finally {
            this.closeStatement(preparedStatement);
            this.closeConnection(connection);
        }
    }

    @Override
    public List<Citat> mostViewed(Integer id){
        List<Citat> citati = new ArrayList<>();

        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT * FROM posts ORDER BY brojPoseta DESC");
            while (resultSet.next()) {
                citati.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(statement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        if(id <0){
            id=0;
        }
        int donja_granica = id*5;
        if(donja_granica>citati.size()){
            donja_granica = 0;
        }
        int gornja_granica = donja_granica+5;

        if(citati.size() < gornja_granica){
            gornja_granica = citati.size();
        }
        if(donja_granica==gornja_granica){
            donja_granica = donja_granica-5;
        }
        if(donja_granica<0){
            donja_granica=0;
        }
        List<Citat> strana = citati.subList(donja_granica,gornja_granica);

        return strana;
    }

    @Override
    public List<Citat> top3() {
        List<Citat> posts = new ArrayList<>();
        System.out.println("Uso u top3!!");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();
            preparedStatement = connection.prepareStatement("SELECT * FROM posts ORDER BY (posts.like+posts.dislike) DESC LIMIT 3");
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return posts;

    }

    @Override
    public List<Citat> search(Integer id,String pretraga) {
        List<Citat> posts = new ArrayList<>();

        System.out.println("Uso sam u search!");
        System.out.println("strana: " + id);
        System.out.println("pretraga: " + pretraga);
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM posts WHERE title LIKE ? OR quote LIKE ?");
            preparedStatement.setString(1,'%' + pretraga + '%');
            preparedStatement.setString(2,'%' + pretraga + '%');
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"), resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        if(id <0){
            id=0;
        }
        int donja_granica = id*5;
        if(donja_granica>posts.size()){
            donja_granica = 0;
        }
        int gornja_granica = donja_granica+5;

        if(posts.size() < gornja_granica){
            gornja_granica = posts.size();
        }
        if(donja_granica==gornja_granica){
            donja_granica = donja_granica-5;
        }
        if(donja_granica<0){
            donja_granica=0;
        }
        System.out.println("Granice: " + donja_granica + " | " + gornja_granica);

        List<Citat> strana = posts.subList(donja_granica, gornja_granica);
        System.out.println(strana);

        return strana;
    }

    @Override
    public List<Citat> tagPostovi(String tag, Integer id) {
        List<Citat> posts = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM posts WHERE tag LIKE ?");
            preparedStatement.setString(1,'%'+tag+'%');
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }
        if(id <0){
            id=Math.abs(id);
        }
        id = id%10;
        int donja_granica = id*5;
        if(donja_granica>posts.size()){
            donja_granica = 0;
        }
        int gornja_granica = donja_granica+5;

        if(posts.size() < gornja_granica){
            gornja_granica = posts.size();
        }
        if(donja_granica==gornja_granica){
            donja_granica = donja_granica-5;
        }
        if(donja_granica<0){
            donja_granica=0;
        }

        List<Citat> strana = posts.subList(donja_granica, gornja_granica);
        System.out.println(strana);

        return strana;
    }

    @Override
    public List<Citat> triTaga(String tag) {
        List<Citat> posts = new ArrayList<>();

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("SELECT * FROM posts WHERE tag LIKE ? LIMIT 3");
            preparedStatement.setString(1,'%'+tag+'%');
            resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                posts.add(new Citat(resultSet.getInt("id"), resultSet.getString("author"),
                        resultSet.getString("title"), resultSet.getString("quote"),
                        resultSet.getString("date"),resultSet.getInt("brojposeta"),
                        resultSet.getInt("like"), resultSet.getInt("dislike"),
                        resultSet.getString("tag")));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.closeStatement(preparedStatement);
            this.closeResultSet(resultSet);
            this.closeConnection(connection);
        }

        return posts;
    }

    @Override
    public void deletePost(Integer id) {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("DELETE FROM posts where id = ?");
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
    public void deleteComment(Integer id) {
        System.out.println("Uso sam u delete!");

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        try {
            connection = this.newConnection();

            preparedStatement = connection.prepareStatement("DELETE FROM comments where id = ?");
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
}
