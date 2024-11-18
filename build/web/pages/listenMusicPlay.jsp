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
                Connection conecta = null;
                PreparedStatement st = null, st1 = null, st2 = null;
                ResultSet rs = null, rs1 = null, rs2 = null;
                String idParam = request.getParameter("id_playlist");
                try {
                    int id = Integer.parseInt(idParam);

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

                    st1 = conecta.prepareStatement("SELECT id_musica, titulo FROM tb_musica");
                    rs1 = st1.executeQuery();

                    st2 = conecta.prepareStatement("SELECT id_playlist, nome FROM playlist WHERE id_playlist = ?;");
                    st2.setInt(1, id);
                    rs2 = st2.executeQuery();

                    st = conecta.prepareStatement(
                            "SELECT pm.id_playMusic, m.titulo AS titulo_musica, m.artista AS artista_musica, "
                            + "m.id_musica, m.tempo AS tempo_musica, p.nome AS nome_playlist, p.id_playlist "
                            + "FROM tb_playMusic AS pm "
                            + "INNER JOIN tb_musica AS m ON pm.id_musica = m.id_musica "
                            + "INNER JOIN playlist AS p ON pm.id_playlist = p.id_playlist "
                            + "WHERE p.id_playlist = ?;"
                    );
                    st.setInt(1, id);
                    rs = st.executeQuery();

                    if (rs2.next()) {
            %>
            <div class="top">
                <div class="title">
                    <h2><%= rs2.getString("nome")%></h2>
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
                        <input type="hidden" name="id_playlist" value="<%= rs2.getString("id_playlist")%>" />
                        <select name="titulo" id="titulo">
                            <%
                                while (rs1.next()) {
                            %>
                            <option value="<%= rs1.getString("id_musica")%>"><%= rs1.getString("titulo")%></option>
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
            <div class="card">
                <% while (rs.next()) {%>
                <div class="musica">
                    <div class="content">
                        <div class="img">
                            <img src=".././img/fone-de-ouvido 2.png" alt="alt"/>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Título: </strong><%= rs.getString("titulo_musica")%></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Tempo: </strong><%= rs.getString("tempo_musica")%></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Artista: </strong><%= rs.getString("artista_musica")%></p>
                        </div>
                    </div>
                    <div class="function">
                        <a href="./deletarMusiPlay.jsp?id_playlist=<%= rs.getString("id_playMusic")%>" class="close" target="main">
                            <img src=".././img/MacOS Close.png" alt="alt"/>
                        </a>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
            <%
                } catch (Exception x) {
                    out.print("<p>Erro ao carregar músicas: " + x.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                        if (rs1 != null) {
                            rs1.close();
                        }
                        if (rs2 != null) {
                            rs2.close();
                        }
                        if (st != null) {
                            st.close();
                        }
                        if (st1 != null) {
                            st1.close();
                        }
                        if (st2 != null) {
                            st2.close();
                        }
                        if (conecta != null) {
                            conecta.close();
                        }
                    } catch (SQLException e) {
                        out.println("<p>Erro ao fechar recursos: " + e.getMessage() + "</p>");
                    }
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
