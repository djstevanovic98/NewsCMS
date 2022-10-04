<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>RAF Posts</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="container">
    <h1 class="naslov">RAF Posts</h1>

    <form method="POST" id="newPost-form">
        <div id="post-links">

        </div><br>
        <btn onclick="location.href='/newpost.jsp'" class="btn btn-primary">New Post</btn> <%-- showPosts() --%>
    </form>
    <br>
    <btn onclick="smanjiStranu()" class="btn btn-primary">Nazad</btn>
    <btn onclick="povecajStranu()" class="btn btn-primary">Napred</btn>
    <form id="top3-form">
        <br>
        <h3 class="naslov">Top3:</h3>
        <div id="top3-links">

        </div><br>
    </form>

</div>

<script>

    $(document).ready(function (){ //window.onload = function(){
        console.log("Sesija strana: " + sessionStorage.getItem('page'));
        if(sessionStorage.getItem('page')==null){
            sessionStorage.setItem('page',0);
        }

    })

    if(sessionStorage.getItem('page') == null){
        sessionStorage.setItem('page',0);
    }

    fetch('/api/posts/' + sessionStorage.getItem('page') + '/page', {
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
        var strana = parseInt(sessionStorage.getItem('page')) + 1;
        sessionStorage.setItem('page', strana);
        location.reload();
    }
    function smanjiStranu(){
        var strana = parseInt(sessionStorage.getItem('page')) - 1;
        sessionStorage.setItem('page', strana);
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

    /*function deletePost(id) {
        return fetch('/api/posts/'+id, {
            method: 'DELETE'
        })
    }*/

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

