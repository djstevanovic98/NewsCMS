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
    <form method="POST" id="newPost-form">
        <h1 class="naslov">RAF Most Viewed</h1>
        <div id="post-links">

        </div><br>
    </form>
    <br>
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
    if(sessionStorage.getItem('Mpage') == null){
        sessionStorage.setItem('Mpage',0);
    }

    fetch('/api/posts/' + sessionStorage.getItem('Mpage') + '/mostViewed', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        console.log(posts);
        for (const post of posts) {
            console.log("ovo je post: " + post);
            addPostElements(post);
        }

    }) //postovi

    function povecajStranu(){
        var strana = parseInt(sessionStorage.getItem('Mpage')) + 1;
        sessionStorage.setItem('Mpage', strana);
        location.reload();
    }
    function smanjiStranu(){
        var strana = parseInt(sessionStorage.getItem('Mpage')) - 1;
        sessionStorage.setItem('Mpage', strana);
        location.reload()
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
