<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>NewPost</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="naslov">RAF New Post</h1>

    <form method="POST" id="post-form">
        <div class="form-group">
            <label for="post-title">Title</label>
            <input type="text" class="form-control" id="post-title" placeholder="Enter post">

            <label for="post-author">Author</label>
            <input type="text" class="form-control" id="post-author" placeholder="Enter author">

            <label for="post-quote">Quote</label>
            <textarea class="form-control" id="post-quote"></textarea>

            <label for="post-tag">Tag</label>
            <input type="text" class="form-control" id="post-tag" placeholder="Enter tag">
        </div>

        <button type="submit" class="btn btn-primary">Submit</button>
    </form>
    <form id="top3-form">
        <br>
        <h3 class="naslov">Top3:</h3>
        <div id="top3-links">

        </div><br>
    </form>
    <br>
    <br>
</div>

<script>

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

    document.getElementById("post-form").addEventListener('submit', function(e) {
        e.preventDefault();

        const postAuthorElement = document.getElementById('post-author')
        const postTitleElement = document.getElementById('post-title');
        const quoteElement = document.getElementById('post-quote');
        const tagElement = document.getElementById('post-tag');

        const author = postAuthorElement.value;
        const title = postTitleElement.value;
        const quote = quoteElement.value;
        const tag = tagElement.value;

        fetch('/api/posts', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                author: author,
                title: title,
                quote: quote,
                tag: tag
            })
        }).then(response => {
            return response.json();
        }).then(post => {
            //addPostElements(post)
            alert("Uspesno dodat!");
            postAuthorElement.value = '';
            postTitleElement.value = '';
            quoteElement.value = '';
            tagElement.value='';
            window.location.href("/posts.jsp")
        })
    })

    fetch('/api/posts/top3', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        console.log(posts);
        for (const post of posts) {
            console.log("ovo je post: " + post);
            addPostElements(post);
        }

    })

    function addPostElements(post) {
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
