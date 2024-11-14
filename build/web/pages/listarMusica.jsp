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

<html>
<head>
    <title>Listagem de Músicas</title>
    <link rel="stylesheet" href="listarMusica.css">
</head>
<body>
    <h1>Listagem de Músicas</h1>
    <%
        Connection conecta;
        PreparedStatement st;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            st = conecta.prepareStatement("SELECT * FROM tb_musica");
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id_musica");
                String tituloMusica = rs.getString("titulo");
                String artistaMusica = rs.getString("artista");
                double tempoMusica = rs.getDouble("tempo");
    %>
                <div class="card">
                    <div class="content">
                        <div class="titleMusic">
                            <p><strong>Título:</strong> <%= tituloMusica %></p>
                            <p><strong>Artista:</strong> <%= artistaMusica %></p>
                            <p><strong>Duração:</strong> <%= tempoMusica %> min</p>
                        </div>
                    </div>
                    <div class="function">
                       
                        <form method="post" action="listarMusica.jsp" style="display:inline;">
                            <input type="hidden" name="id_excluir" value="<%= id %>">
                            <button type="submit" style="background:none; border:none; cursor:pointer;">
                                <i class="fas fa-times" style="color:white;"></i>
                            </button>
                        </form>
                        
                        <a href="salvarMusica.jsp?id_musica=<%= id %>" class="edit">
                            <i class="fas fa-edit"></i> 
                        </a>
                    </div>
                </div>
    <%
            }

            rs.close();
            st.close();
            conecta.close();
        } catch (Exception x) {
            out.print("Erro ao carregar músicas: " + x.getMessage());
        }
    %>
</body>
</html>

