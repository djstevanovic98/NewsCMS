<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="naslov">RAF Log in</h1>

    <form method="POST" id="logIn-form">

        <label for="email">Email:</label>
        <input type="email" class="form-control" id="email" required="true">

        <label for="password">Password:</label>
        <input type="password" class="form-control" id="password" required="true"><br>

        <button class="btn btn-primary" type="submit">Log in</button><br><br>
        <btn class="btn btn-danger" id="nazad">addUser</btn>

    </form>
</div>

<script>
    document.getElementById("logIn-form").addEventListener('submit', function(e) {
        e.preventDefault();

        const emailElement = document.getElementById('email');
        const passwordElement = document.getElementById('password');

        const email = emailElement.value;
        const password = passwordElement.value;

        fetch('/api/users/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                password: password
            })
        }).then(response => {
            if(!response.ok){
                alert("Pogresni kredencijali!")
                return null;
            }
            return response.json();
        }).then(jwt => {

            if (jwt!=null) {
                document.cookie = "jwt=" + jwt.jwt;
                emailElement.value = '';
                passwordElement.value = '';
            }

            //window.location.href = "posts.jsp";

        })
    })
</script>

</body>
</html>
