<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="naslov">RAF Register</h1>

    <form method="POST" id="register-form">

        <label for="email">Email:</label>
        <input type="email" class="form-control" id="email" required="true">

        <label for="username">Username:</label>
        <input type="text" class="form-control" id="username" required="true">

        <label for="password">Password:</label>
        <input type="password" class="form-control" id="password" required="true"><br>

        <label for="password">Password:</label>
        <input type="password" class="form-control" id="confirm_password" required="true"><br>

        <label for="tip">Tip:</label>
        <input type="text" class="form-control" id="tip" required="true">

        <label for="status">Status:</label>
        <input type="text" class="form-control" id="status" required="true">

        <button class="btn btn-primary" type="submit">Register</button><br><br>

    </form>
</div>

<script>

    fetch('/api/users/admin', {
        method: 'GET',
    }).then(response => {
        if (!response.ok) {
            alert("Niste Admin!");
            window.location.replace("login.jsp");
        }else{
            console.log("logged in")
        }
        return response;
    }).then(response => {

    })


    document.getElementById("register-form").addEventListener('submit', function(e) {
        e.preventDefault();

        const emailElement = document.getElementById('email');
        const usernameElement = document.getElementById('username');
        const passwordElemenet = document.getElementById('password');
        const tipElement = document.getElementById('tip');
        const statusElement = document.getElementById('status');

        const email = emailElement.value;
        const username = usernameElement.value;
        const password = passwordElemenet.value;
        const tip = tipElement.value;
        const status = statusElement.value;

        if(!validatePassword()){
            return;
        }


        fetch('/api/users/'+email+'/findmail', {
            method: 'GET'
        }).then(response => {
            if(!response.ok){
                response = null;
            }else {
                return response.json()
            }
        }).then(users => {
            if(users==null){
            <%-- ako je findmail null --%>
                fetch('/api/users', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        email: email,
                        username: username,
                        password: password,
                        tip:tip,
                        status:status
                    })
                }).then(response => {
                    if(response.ok){
                        window.location.replace("korisnici.jsp");
                    }
                    return response.json();
                }).then(user => {
                    console.log(user);
                })

            }else{
                alert('Email vec postoji2!')
            }
        })


    })

    function validatePassword(){
        var confirm_password = document.getElementById("confirm_password");
        var password = document.getElementById("password");

        if(password.value != confirm_password.value){
            alert("Pogresili ste lozinke!");
            return null;
        }else{
            return true;
        }
    }

</script>
</body>
</html>
