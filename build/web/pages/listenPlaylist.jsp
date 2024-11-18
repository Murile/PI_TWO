<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Music</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="./listenPlaylis.css?999999">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <main>
            <div class="content">
                <div class="title">
                    <h2>My Playlist</h2>
                </div>
                <div>
                    <div class="open" type="submit" onclick="handlePopupCad(true)">
                        <button>Adicionar</button>
                    </div>
                </div>
            </div>
            <%
                Connection conecta;
                PreparedStatement st1;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

                    st1 = conecta.prepareStatement("select id_playlist, nome from playlist;");
                    ResultSet rs = st1.executeQuery();


            %>
            <section class="cardPlaylist">
                <% while (rs.next()) {%>
                <div class="card">
                    <div class="img">
                        <img src=".././img/image 28.png" />
                    </div>
                    <div class="titlePaylist">
                        <a href="./listenMusicPlay.jsp?id_playlist=<%= rs.getString("id_playlist")%>"><%= rs.getString("nome")%></a>
                        <a class="remove" href="./deletePlaylist.jsp?id_playlist=<%= rs.getString("id_playlist")%>">
                            <img src=".././img/x 2.png" alt=""/>
                        </a>
                    </div>
                </div>
                <%}%>
            </section>

            <%

                    rs.close();
                    st1.close();
                    conecta.close();
                } catch (Exception x) {
                    out.print("Erro ao carregar músicas: " + x.getMessage());
                }
            %>
            <div class="popup" id="popup_add">
                <div class="close">
                    <button type="submit" onclick="handlePopupCad(false)">
                        <img src=".././img/x 2.png" alt=""/>
                    </button>
                </div>
                <form action="./cadastrarPlaylist.jsp" method="post">
                    <div>
                        <img src=".././img/logo-login.png" alt="alt"/>
                    </div>
                    <div class="title"><h2>Adicionar Playlist</h2></div>
                    <div class="login-user">
                        <div>
                            <input type="text" name="titulo" placeholder="Nome da Playlis....">
                        </div>
                    </div>
                    <div class="button">
                        <button >Adicionar</button>
                    </div>
                </form>
            </div>

            <script>
                const popup_add = document.getElementById('popup_add');

                function handlePopupCad(open) {
                    popup_add.classList[open ? 'add' : 'remove']('opened');
                }
            </script>
        </main>
    </body>
</html>
