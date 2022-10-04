<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>

<div class="container">
    <h1 class="naslov">RAF Read more</h1>

    <form method="POST" id="newPost-form">
        <div id="post-links">

        </div><br>
    </form>
</div>

<script>
    alert("Tag: " + sessionStorage.getItem('sacuvanTagSingle'));
    alert("id: " + sessionStorage.getItem('sacuvanPost'));

    fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost'), {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(post => {
        addPostElements(post);
    })

    fetch('/api/posts/'+ sessionStorage.getItem('sacuvanTagSingle') + '/' + sessionStorage.getItem('sacuvanPost') + '/tagPostovi', {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(posts => {
        for(let i = 0; i<posts.length; i++) {
            addPostElements(posts[i]);
        }
    })

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
</script>
</body>
</html>
