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
    <h1 class="naslov">RAF ContPage</h1>

    <form method="POST" id="newPost-form">
        <div id="post-links">

        </div><br>
        <btn onclick="location.href='/newpost.jsp'" class="btn btn-primary">New Post</btn> <%-- showPosts() --%>
    </form>
    <br>
    <btn onclick="smanjiStranu()" class="btn btn-primary">Nazad</btn>
    <btn onclick="povecajStranu()" class="btn btn-primary">Napred</btn>
</div>
</body>

<script>


    $(document).ready(function (){ //window.onload = function(){

        fetch('/api/users/provera', {
            method: 'GET',
        }).then(response => {
            if (!response.ok) {
                window.location.replace("/login.jsp")
            }else{
                console.log("logged in")
            }
            return response;
        }).then(response => {
        })


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

        const removeButton = document.createElement('button');
        removeButton.innerText = 'Remove'
        removeButton.classList.add('btn', 'btn-danger')
        removeButton.onclick = function (e) {
            deletePost(post.id).then(() => {
                alert('uspesno obrisan');
            });

            fetch('/api/comments/'+id, {
                method: 'DELETE'
            }).then(() =>{
                console.log('obrisan koment');
            })
        }



        linkWrapperDiv.appendChild(postLink);
        linkWrapperDiv.appendChild(postQuote);
        linkWrapperDiv.appendChild(postDate);
        linkWrapperDiv.appendChild(removeButton);

        linkWrapperDiv.appendChild(document.createElement('br'));


        postLinks.appendChild(linkWrapperDiv);
    }

    function deletePost(id) {
        return fetch('/api/posts/'+id, {
            method: 'DELETE'
        })
    }



</script>
</html>
