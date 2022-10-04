<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Single Post</title>
    <script src="jquery-3.6.0.js"></script>
    <%@ include file="styles.jsp" %>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
    <h1 class="naslov">RAF Single Post</h1>

    <form id="singlePost-form">
        <div id="single-post">

        </div>
        <btn class="btn btn-primary" id="likeBtn">Like</btn>
        <btn class="btn btn-danger" id="dislikeBtn">Dislike</btn>
    </form>
    <form method="POST" id="comment-form">
        <label><b>New Comment</b></label><br>
        <label for="comment-name">Name</label>
        <input type="text" class="form-control" id="comment-name">

        <label for="comment">Comment</label>
        <textarea class="form-control" id="comment"></textarea><br>

        <button class="btn btn-primary" type="submit">Comment</button><br><br>
        <btn class="btn btn-danger" id="nazad">Nazad</btn>

        <div id="comments">
            <h1>Comments: </h1>
        </div>
    </form>

</div>

<script>

    fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost'), {
        method: 'GET'
    }).then(response => {
        return response.json();
    }).then(post => {
        singlePost(post);
    })

    fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost') + '/comments', { // PREPRAVI OVO U REPO
        method: 'GET'
    }).then(response => {
        console.log(response.json);
        return response.json();
    }).then(komentari => {
        console.log(komentari)
        for(const komentar in komentari){
            console.log(komentar);
        }
        console.log(komentari[0]);
        for(let i = 0;i<komentari.length;i++)
        {
            addCommentElements(komentari[i]);
        }

        /*
        for(const komentar in komentari) {
            console.log("Objekat je: " + komentar);
            addCommentElements(komentar);

        }
        */

        //obrio sam se get
    })
    if(sessionStorage.getItem(sessionStorage.getItem('sacuvanPost').toString()) == null){
        sessionStorage.setItem(sessionStorage.getItem('sacuvanPost'), "posetio")

        fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost') + '/brPoseta', {
            method: 'GET'
        }).then(response => {
            alert('Posetio')
            return;
        })
    }else{
        console.log("Poseceno vec! ");
    }



    function singlePost(post) {
        console.log("Broj poseta je: " + post.brojPoseta)

        const singlePost = document.getElementById('single-post');

        const singleWrapperDiv = document.createElement('div');

        const bold = document.createElement('b');
        const singlePostDate = document.createElement('p');
        const singlePostAuthor = document.createElement('p');
        const singlePostQuote = document.createElement('p');
        const singlePostPoseta = document.createElement('p');
        const brojLajkova = document.createElement('p');

        bold.innerText = post.title;
        singlePostDate.innerText = post.date;
        singlePostAuthor.innerText = post.author;
        singlePostQuote.innerText = post.quote;
        singlePostPoseta.innerText = "Broj poseta: " + post.brojPoseta;
        brojLajkova.innerText = "L/D: " + post.like + ":" + post.dislike;

        singleWrapperDiv.appendChild(bold);
        singleWrapperDiv.appendChild(singlePostDate);
        singleWrapperDiv.appendChild(singlePostAuthor);
        singleWrapperDiv.appendChild(singlePostQuote);
        singleWrapperDiv.appendChild(singlePostPoseta);

        console.log('Post tag je: ' + post.tag);

        let tagovi = post.tag;
        const parts = tagovi.split(",");
        console.log('parts je : ' + parts);
        console.log('parts[0] : ' + parts[0]);

        singleWrapperDiv.appendChild (document.createTextNode("Tags: "));
        for(let i = 0; i<parts.length;i++){
            console.log('part je: ' + parts[i]);
            const postLink = document.createElement('a');
            postLink.innerText = parts[i];
            postLink.href = '/tagposts.jsp' <%-- post.jsp --%>
            postLink.onclick = function (e){
                sessionStorage.setItem('sacuvanTag',parts[i]); <%-- tostring --%>
                <%-- singlePost(post); --%>
            };
            singleWrapperDiv.appendChild(postLink);
            singleWrapperDiv.appendChild (document.createTextNode(", "));
        }

        const prJosLink = document.createElement('a');
        prJosLink.innerText = ("Procitaj jos...");
        prJosLink.href = '/readmore.jsp'
        prJosLink.onclick = function (e){
            let randomPart = Math.floor(Math.random() * parts.length);
            alert("Post part od length je: " + parts[randomPart]);
            alert("Post part je: " + parts[0]);
            alert("Random broj je: " + randomPart);
            sessionStorage.setItem('sacuvanTagSingle', parts[randomPart]);
            sessionStorage.setItem('sacuvanPost', post.id);

        }
        singleWrapperDiv.appendChild(prJosLink);
        singleWrapperDiv.appendChild(brojLajkova);
        singleWrapperDiv.appendChild(document.createElement('br'));

        singlePost.appendChild(singleWrapperDiv);
    }

    function addCommentElements(komentar){
        const commentLinks = document.getElementById('comments');

        const commentWrapperDiv = document.createElement('div');

        const boldComment = document.createElement('b');
        const quote = document.createElement('p');

        //console.log("Komentar ime: " + komentar.json.name);

        boldComment.innerText = komentar.name;
        quote.innerText = komentar.comment;

        commentWrapperDiv.appendChild(boldComment);
        commentWrapperDiv.appendChild(quote);
        commentWrapperDiv.appendChild(document.createElement('br'));

        commentLinks.appendChild(commentWrapperDiv);

    }

    document.getElementById("comment-form").addEventListener('submit', function(e) {
        e.preventDefault();

        const commentNameElement = document.getElementById('comment-name');
        const commentCommentElement = document.getElementById('comment');

        const name = commentNameElement.value;
        const comment = commentCommentElement.value;
        const postId = parseInt(sessionStorage.getItem('sacuvanPost'));

        fetch('/api/posts/comments', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                name: name,
                comment: comment,
                postId: postId
            })
        }).then(response => {
            return response.json();
        }).then(comment => {
            addCommentElements(comment);
        })
    })

    document.getElementById("likeBtn").addEventListener('click', function (e){
        e.preventDefault();

        if(sessionStorage.getItem(sessionStorage.getItem('sacuvanPost'))=="lajkovao"){
            console.log("usao u == lajkovao!1")
            return;
        };

        fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost') + '/like', {
            method: 'GET'
        }).then(response => {
            alert('Posetio');
            return;
        })

        sessionStorage.setItem(sessionStorage.getItem('sacuvanPost').toString(),"lajkovao");

    });
    document.getElementById("dislikeBtn").addEventListener('click', function(e){
        e.preventDefault();

        if(sessionStorage.getItem(sessionStorage.getItem('sacuvanPost'))=="lajkovao"){
            return;
        };

        fetch('/api/posts/' + sessionStorage.getItem('sacuvanPost') + '/dislike', {
            method: 'GET'
        }).then(response => {
            return;
        })

        sessionStorage.setItem(sessionStorage.getItem('sacuvanPost').toString(),"lajkovao");

    });



</script>

</body>
</html>
