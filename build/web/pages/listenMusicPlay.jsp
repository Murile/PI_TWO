<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Music</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./listenMusicPlay.css">
        <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Inter:wght@100..900&family=Judson:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="space"></div>
        <main>
            <%
                Connection conecta;
                PreparedStatement st, st1, st2;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");
                    
                    st1 = conecta.prepareStatement("SELECT id_musica, titulo FROM tb_musica");
                    ResultSet rs1 = st1.executeQuery();

                    st2 = conecta.prepareStatement("select nome from playlist;");
                    ResultSet rs2 = st2.executeQuery();

                    st = conecta.prepareStatement("SELECT pm.id_playMusic, m.titulo AS titulo_musica, m.artista AS artista_musica, "
                            + "m.tempo AS tempo_musica, p.nome AS nome_playlist, p.id_playlist "
                            + "FROM tb_playMusic AS pm "
                            + "INNER JOIN tb_musica AS m ON pm.id_musica = m.id_musica "
                            + "INNER JOIN playlist AS p ON pm.id_playlist = p.id_playlist;");
                    ResultSet rs = st.executeQuery();
                    
                    if (rs2.next()) {
            %>
            <div class="top">
                <div class="title">
                    <h2><%= rs2.getString("nome") %></h2>
                </div>
                <div class="open" type="submit" onclick="handlePopupCad(true)">
                    <button>Adicionar Música</button>
                </div>
            </div>
            <div class="popup" id="popup_add">
                <div class="close">
                    <button type="submit" onclick="handlePopupCad(false)">
                        <img src=".././img/x 2.png" alt=""/>
                    </button>
                </div>
                <form action="./casdastraMusicPlay.jsp" method="post">
                    <div>
                        <img src=".././img/logo-login.png" alt="alt"/>
                    </div>
                    <div class="title"><h2>Adicionar Música</h2></div>
                    <div class="login-user">
                        <input type="hidden" name="id_playlist" value="<%= rs2.getString("id_playlist") %>" />
                        <select name="titulo" id="titulo">
                            <%
                                while (rs1.next()) {
                            %>
                            <option value="<%= rs1.getString("id_musica") %>"><%= rs1.getString("titulo") %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="button">
                        <button>Adicionar</button>
                    </div>
                </form>
            </div>
            <% } %>
            <div class="card">
                <% while (rs.next()) { %>
                <div class="musica">
                    <div class="content">
                        <div class="img">
                            <img src=".././img/fone-de-ouvido 2.png" alt="alt"/>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Título: </strong><%= rs.getString("titulo_musica") %></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Tempo: </strong><%= rs.getString("tempo_musica") %></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Artista: </strong><%= rs.getString("artista_musica") %></p>
                        </div>
                    </div>
                    <div class="function">
                        <a href="./deletarMusiPlay.jsp?id_playlist=<%= rs.getString("pm.id_playMusic") %>" class="close" target="main">
                            <img src=".././img/MacOS Close.png" alt="alt"/>
                        </a>
                    </div>
                </div>
                <% } %>
            </div>

            <%
                    rs.close();
                    st.close();
                    conecta.close();
                } catch (Exception x) {
                    out.print("Erro ao carregar músicas: " + x.getMessage());
                }
            %>
            <script>
                const popup_add = document.getElementById('popup_add');

                function handlePopupCad(open) {
                    popup_add.classList[open ? 'add' : 'remove']('opened');
                }
            </script>
        </main>
    </body>
</html>
