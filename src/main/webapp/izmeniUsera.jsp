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
    <h1 class="naslov">RAF Register</h1>

    <form method="POST" id="register-form">

        <label for="email">Email:</label>
        <input type="email" class="form-control" id="email" required="true">

        <label for="username">Username:</label>
        <input type="text" class="form-control" id="username" required="true">

        <label for="password">Password:</label>
        <input type="password" class="form-control" id="password" required="true"><br>

        <label for="status">Status:</label>
        <input type="text" class="form-control" id="status" required="true">

        <label for="tip">Tip:</label>
        <input type="text" class="form-control" id="tip" required="true">

        <button class="btn btn-primary" type="submit">Register</button><br><br>

    </form>
    <form id="addUser">
        <btn class="btn btn-danger" type="submit">addUser</btn>
    </form>
</div>

</body>
</html>
