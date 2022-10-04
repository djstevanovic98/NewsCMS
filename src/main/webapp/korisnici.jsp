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
<h1 class="naslov">RAF Users</h1>
<br>
<form method="POST" id="newPost-form">
    <div id="user-links">

    </div><br>
    <btn onclick="location.href='/register.jsp'" class="btn btn-primary">Add user</btn> <%-- showPosts() --%>
</form>
    <form method="POST" id="izmeni-form">

        <label for="email">Email:</label>
        <input type="email" class="form-control" id="email" required="true">

        <label for="username">Username:</label>
        <input type="text" class="form-control" id="username" required="true">

        <label for="password">Password:</label>
        <input type="password" class="form-control" id="password" required="true"><br>

        <label for="tip">Tip:</label>
        <input type="text" class="form-control" id="tip" required="true">

        <label for="status">Status:</label>
        <input type="text" class="form-control" id="status" required="true">

        <button class="btn btn-primary" type="submit">Izmeni</button><br><br>

    </form>
</div>
</body>

<script>
    $(document).ready(function () {
        fetch('/api/users/admin', {
            method: 'GET',
        }).then(response => {
            if (!response.ok) {
                alert("Niste Admin!");
                window.location.replace("login.jsp");
            }else{

            }
            return response;
        })
        document.getElementById('izmeni-form').style.display = "none";
    })

        fetch('/api/users', {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(users => {
            for (let i = 0; i < users.length; i++) {
                addUserElements(users[i]);
            }

        })


    function addUserElements(user) {
        const postLinks = document.getElementById('user-links');

        console.log("AdduserElement status: " + user.status );
        const linkWrapperDiv = document.createElement('div');

        const userLine = document.createElement('p')
        userLine.innerText = user.email + " | " + user.username + " | " + user.status + " | " + user.tip;

        /*const removeButton = document.createElement('button');
        removeButton.innerText = 'Remove'
        removeButton.classList.add('btn', 'btn-danger')
        removeButton.style.marginLeft = '10px'
        removeButton.onclick = function (e) {
            deletePost(post.id).then(() => {
                postLinks.removeChild(linkWrapperDiv)
            });
        }

        linkWrapperDiv.appendChild(removeButton);
         */

        const postLink = document.createElement('a');
        postLink.innerText = "izmeni";
        postLink.onclick = function (e){
            sessionStorage.setItem("userId", user.id);
            document.getElementById('izmeni-form').style.display = "block";
        };
        linkWrapperDiv.appendChild(document.createElement('br'));

        linkWrapperDiv.appendChild(userLine);
        linkWrapperDiv.appendChild(postLink);

        linkWrapperDiv.appendChild(document.createElement('br'));

        postLinks.appendChild(linkWrapperDiv);
    }

    document.getElementById("izmeni-form").addEventListener('submit', function(e) {
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

        fetch('/api/users/' + sessionStorage.getItem("userId"), {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                email: email,
                username: username,
                password: password, //must not be null
                tip:tip,
                status:status
            })
        }).then(response => {
            return response.json();
        }).then(user => {
            location.reload();
        })
    })

</script>
</html>
