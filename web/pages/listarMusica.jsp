<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
    String idParam = request.getParameter("id_musica");
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);

           
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            PreparedStatement st = conecta.prepareStatement("DELETE FROM tb_musica WHERE id_musica = ?");
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p style='color:green;'>Música excluída com sucesso.</p>");
            } else {
                out.println("<p style='color:red;'>Música não encontrada.</p>");
            }

            st.close();
            conecta.close();

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao excluir música: " + e.getMessage() + "</p>");
        }
    }
%>

<html>
<head>
    <title>Listagem de Músicas</title>
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
                String titulo = rs.getString("titulo");
                String artista = rs.getString("artista");
                double tempo = rs.getDouble("tempo");
    %>
                <div class="card">
                    <div class="content">
                        <div class="titleMusic">
                            <p><strong>Título:</strong> <%= titulo %></p>
                            <p><strong>Artista:</strong> <%= artista %></p>
                            <p><strong>Duração:</strong> <%= tempo %> min</p>
                        </div>
                    </div>
                    <div class="function">
                        
                        <form method="post" action="listarMusica.jsp" style="display:inline;">
                            <input type="hidden" name="id_musica" value="<%= id %>">
                            <button type="submit" style="background:none; border:none; cursor:pointer;">
                                <i class="fas fa-times" style="color:white;"></i> <!-- Ícone "X" em branco -->
                            </button>
                        </form>
                        <a href="#" class="plus"><i class="fas fa-plus"></i></a>
                        <a href="#" class="edit"><i class="fas fa-edit"></i></a>
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
