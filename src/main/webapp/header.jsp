<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Web programiranje</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="<%=application.getContextPath()%>/posts.jsp">Home Page</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=application.getContextPath()%>/mostviewed.jsp">MostViewed</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=application.getContextPath()%>/search.jsp">Search</a>
            </li>
            <li class="nav-item" id="login">
                <a class="nav-link" href="<%=application.getContextPath()%>/contpage.jsp" id="ContPage">Vesti</a>
            </li>
            <li class="nav-item" id="login">
                <a class="nav-link" href="<%=application.getContextPath()%>/login.jsp" id="NavLog">Log in</a>
            </li>
            <li class="nav-item" id="users">
                <a class="nav-link" href="<%=application.getContextPath()%>/korisnici.jsp" id="korisnici">Users</a>
            </li>

        </ul>
    </div>
    <script>
        fetch('/api/users/admin', {
            method: 'GET',
        }).then(response => {
            if (!response.ok) {
                document.getElementById('korisnici').style.display="none"
            }else{
                document.getElementById('korisnici').style.display="block"
                document.getElementById('NavLog').style.display="none"
                document.getElementById('ContPage').style.display="block"
                console.log("logged in")
            }
            return response;
        }).then(response => {
        })

        fetch('/api/users/provera', {
            method: 'GET',
        }).then(response => {
            if (!response.ok) {
                document.getElementById('ContPage').style.display="none"
            }else{
                console.log("logged in")
                document.getElementById('NavLog').style.display="none"
                document.getElementById('ContPage').style.display="block"
            }
            return response;
        }).then(response => {
        })

    </script>
</nav>
