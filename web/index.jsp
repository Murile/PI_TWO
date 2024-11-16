<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->

<%
    String popupLogin = request.getParameter("popup");
    boolean popupClosed = true;
    if (popupLogin != null) {
        popupClosed = Boolean.parseBoolean(popupLogin);
    }
%>

<html>
    <head>
        <title>Music</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./index.css">
        <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Inter:wght@100..900&family=Judson:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    </head>
    <body>
        <nav>
            <div class="logo_geral">
                <a href="" class="logo">
                    <img src="./img/Component 1 (2).png" alt="alt"/>
                </a>
            </div>
            <div class="navegation">
                <a href="/index.jsp?popup=false" class="home">
                    <img src="./img/image 17.png" alt="alt"/>
                </a>
                <a href="./pages/listenPlaylist.jsp" class="playlist" target="main">
                    <img src="./img/image 18.png" alt="alt"/>
                </a>
                <a href="./pages/listarMusica.jsp" class="music" target="main">
                    <img src="./img/fone-de-ouvido 2.png" alt="alt"/>
                </a>
                <a href="./pages/cadastraMusi.html" class="Plus" target="main">
                    <img src="./img/Plus.png" alt="alt"/>
                </a>
            </div>
            <div class="login">
                <a href="./pages/updateUser.html" target="main">
                    <img src="./img/larissaFoto 1.png" alt="alt"/>
                </a>
                <a href="">
                    <img src="./img/poder 2.png" alt="alt"/>
                </a>
            </div>
        </nav>

        <main>
            <div class="search">
                <input type="text" placeholder="O que você quer ouvir?">
            </div>
            <iframe src="./pages/home.html" name="main" ></iframe>
            <div class="popup" id="popup">
                <div class="close">

                    <button type="submit" onclick="handlePopup()">
                        <img src="./img/x 2.png" alt=""/>
                    </button>
                </div>
                <form action="/pages/login.jsp" method="post">
                    <div>
                        <img src="./img/logo-login.png" alt="alt"/>
                    </div>
                    <div class="title"><h2>Login</h2></div>
                    <div class="login-user">
                        <div>
                            <input type="text" name ="email" placeholder="Email">
                        </div>
                        <div>
                            <input type="password" name="senha" placeholder="Senha">
                        </div>
                    </div>
                    <div class="button">
                        <button>Entrar</button>
                    </div>
                    <div class="link-cadastrar">
                        <a onclick="handlePopupCad(true), handlePopup(false)">Cadastra-se</a>
                    </div>
                </form>
            </div>
            <div class="popup" id="popup_cad">
                <div class="close">
                    <button type="submit" onclick="handlePopupCad(false)">
                        <img src="./img/x 2.png" alt=""/>
                    </button>
                </div>
                <form action="./pages/cadastro.jsp" method="post">
                    <div>
                        <img src="./img/logo-login.png" alt="alt"/>
                    </div>
                    <div class="title"><h2>Cadastro</h2></div>
                    <div class="login-user">
                        <div>
                            <input type="text" name="nome" placeholder="nome">
                        </div>
                        <div>
                            <input type="text" name="email" placeholder="email">
                        </div>
                        <div>
                            <input type="password" name="senha" placeholder="senha">
                        </div>
                    </div>
                    <div class="button">
                        <button >Cadastrar</button>
                    </div>
                </form>
            </div>
        </main>
        <script>
            const popup = document.getElementById('popup');

            function handlePopup() {
                if (<%=popupClosed%>) {
                    popup.classList.toggle('opened');
            }
            }

            window.addEventListener("load", (event) => {
                handlePopup();
            });




            const popup_cad = document.getElementById('popup_cad');

            function handlePopupCad(open) {
                popup_cad.classList[open ? 'add' : 'remove']('opened');
            }
        </script>
    </body>
</html>
