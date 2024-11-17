<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>

<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    
    Integer userId = (Integer) session.getAttribute("userId");
    String mensagemStatus = null;

    if (userId != null && email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            
            String sqlUpdate = "UPDATE usuario SET email = ?, senha = ? WHERE id_usuario = ?";
            PreparedStatement stUpdate = conn.prepareStatement(sqlUpdate);
            stUpdate.setString(1, email);
            stUpdate.setString(2, senha); 
            stUpdate.setInt(3, userId);

            int rowsUpdated = stUpdate.executeUpdate();
            if (rowsUpdated > 0) {
                mensagemStatus = "Usuário atualizado com sucesso!";
            } else {
                mensagemStatus = "Erro: Nenhuma alteração foi realizada.";
            }

            stUpdate.close();
            conn.close();

        } catch (Exception e) {
            mensagemStatus = "Erro ao processar a atualização: " + e.getMessage();
        }
    } else {
        mensagemStatus = "Erro: Usuário não autenticado ou dados incompletos.";
    }

    out.println("<p>" + mensagemStatus + "</p>");
%>
