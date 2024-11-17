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
                mensagemStatus = "Usu�rio atualizado com sucesso!";
            } else {
                mensagemStatus = "Erro: Nenhuma altera��o foi realizada.";
            }

            stUpdate.close();
            conn.close();

        } catch (Exception e) {
            mensagemStatus = "Erro ao processar a atualiza��o: " + e.getMessage();
        }
    } else {
        mensagemStatus = "Erro: Usu�rio n�o autenticado ou dados incompletos.";
    }

    out.println("<p>" + mensagemStatus + "</p>");
%>
