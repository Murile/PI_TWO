<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String idExcluir = request.getParameter("id_excluir");
    if (idExcluir != null && !idExcluir.isEmpty()) {
        try {
            int id = Integer.parseInt(idExcluir);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            PreparedStatement st = conecta.prepareStatement("DELETE FROM tb_musica WHERE id_musica = ?");
            st.setInt(1, id);
            st.executeUpdate();

            st.close();
            conecta.close();

            response.sendRedirect("listarMusica.jsp");
            return;

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao excluir música: " + e.getMessage() + "</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Music</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./listenMusic.css?9999999999999">
        <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Inter:wght@100..900&family=Judson:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="space"></div>
        <main>
            <div class="title">
                <h2>Musicas</h2>
            </div>
            <%
                Connection conecta;
                PreparedStatement st;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

                    st = conecta.prepareStatement("SELECT * FROM tb_musica");
                    ResultSet rs = st.executeQuery();
            %>

            <div class="card">
                <%while (rs.next()) {%>
                <div class="musica">
                    <div class="content">
                        <div class="img">
                            <img src=".././img/fone-de-ouvido 2.png" alt="alt"/>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Titulo: </strong><%= rs.getString("titulo")%></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Tempo: </strong><%= rs.getString("tempo")%></p>
                        </div>
                        <div class="titleMusic">
                            <p><strong>Artista: </strong><%= rs.getString("artista")%></p>
                        </div>
                    </div>
                    <div class="function">
                        <a href="./deleteMusic.jsp?id_musica=<%= rs.getString("id_musica")%>" class="close" target="main">
                            <img src=".././img/MacOS Close.png" alt="alt"/>
                        </a>
                        <a href="salvarMusica.jsp?id_musica=<%= rs.getString("id_musica")%>" class="edit" target="main">
                            <img src=".././img/Pencil.png" alt="alt"/>
                        </a>
                    </div>
                </div>
                <%}%>
            </div>
            <%
                    rs.close();
                    st.close();
                    conecta.close();
                } catch (Exception x) {
                    out.print("Erro ao carregar músicas: " + x.getMessage());
                }
            %>

        </main>
    </body>
</html>