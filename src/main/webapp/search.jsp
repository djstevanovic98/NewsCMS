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
    <h1 class="naslov">RAF Search</h1>

    <form id="searchPost-form" method="POST">
        <div id="search-post">
            <input type="text" id="search" placeholder="Enter text" required="true">
            <button class="btn btn-primary" type="submit">Search</button><br><br>
        </div>
    </form>
    <form method="POST" id="newPost-form">
        <h3 class="naslov">Postovi:</h3>
        <div id="post-links">

        </div><br>
        <btn onclick="smanjiStranu()" class="btn btn-primary">Nazad</btn>
        <btn onclick="povecajStranu()" class="btn btn-primary">Napred</btn>
    </form>

    <form id="top3-form">
        <br>
        <h3 class="naslov">Top3:</h3>
        <div id="top3-links">

        </div><br>
    </form>

</div>
<script>


    document.getElementById("searchPost-form").addEventListener('submit', function(e) {
        e.preventDefault();
        fetchThis();
    })

    function fetchThis(){
        if(sessionStorage.getItem("searchPage") == null || sessionStorage.get){
            sessionStorage.setItem("searchPage",0);
        }
        let child = document.getElementById('post-links');
        while (child.firstChild) {
            child.removeChild(child.firstChild);
        }

        var pretrazi = document.getElementById("search").value;
        sessionStorage.setItem('pretraga',pretrazi);
        var id = sessionStorage.getItem("searchPage");

        fetch('/api/posts/' + id + '/' + pretrazi + '/search', {
            method: 'GET'
        }).then(response => {
            return response.json();
        }).then(posts => {
            console.log(posts);
            for (const post of posts) {
                addPostElements(post);
            }
        })
    }

    function addPostElements(post) {
        const postLinks = document.getElementById('post-links');

        const linkWrapperDiv = document.createElement('div');

        const postLink = document.createElement('a');
        postLink.innerText = post.title;
        postLink.href = '/singlepost.jsp' <%-- post.jsp --%>
        postLink.onclick = function (e){
            sessionStorage.setItem('sacuvanPost',post.id); <%-- tostring --%>
            <%-- singlePost(post); --%>
        };

        const postDate = document.createElement('p')
        postDate.innerText = post.date;
        const postQuote = document.createElement('p');
        postQuote.innerText = post.quote.substring(0,30) + "...";

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
        linkWrapperDiv.appendChild(postLink);
        linkWrapperDiv.appendChild(postQuote);
        linkWrapperDiv.appendChild(postDate);

        linkWrapperDiv.appendChild(document.createElement('br'));


        postLinks.appendChild(linkWrapperDiv);
    }

    function povecajStranu(){
        var strana = parseInt(sessionStorage.getItem('searchPage')) + 1;
        sessionStorage.setItem('searchPage', strana);


        fetchThis();

    }
    function smanjiStranu(){
        var strana = parseInt(sessionStorage.getItem('searchPage')) - 1;
        sessionStorage.setItem('searchPage', strana);

        let child = document.getElementById('post-links');

        fetchThis();
    }
    fetch('/api/posts/top3', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        console.log(posts);
        for (const post of posts) {
            console.log("ovo je post: " + post);
            addTopElements(post);
        }

    })

    function addTopElements(post) {
        const postLinks = document.getElementById('top3-links');

        const linkWrapperDiv = document.createElement('div');

        const postLink = document.createElement('a');
        postLink.innerText = post.title;
        postLink.href = '/singlepost.jsp' <%-- post.jsp --%>
        postLink.onclick = function (e){
            sessionStorage.setItem('sacuvanPost',post.id); <%-- tostring --%>
            <%-- singlePost(post); --%>
        };

        const postDate = document.createElement('p')
        postDate.innerText = post.date;
        const postQuote = document.createElement('p');
        postQuote.innerText = post.quote.substring(0,30) + "...";

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
        linkWrapperDiv.appendChild(postLink);
        linkWrapperDiv.appendChild(postQuote);
        linkWrapperDiv.appendChild(postDate);

        linkWrapperDiv.appendChild(document.createElement('br'));


        postLinks.appendChild(linkWrapperDiv);
    }
</script>
</body>
</html>
