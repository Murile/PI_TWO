<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id_musica"); // Obtém o ID da música
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);

            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            PreparedStatement st = conecta.prepareStatement("DELETE FROM tb_musica WHERE id_musica = ?");
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();

            if (rowsAffected > 0) {
                out.print("sucesso"); // Responde com sucesso para o AJAX
            } else {
                out.print("Música não encontrada.");
            }

            st.close();
            conecta.close();

        } catch (Exception x) {
            out.print("Erro ao excluir música: " + x.getMessage());
        }
    } else {
        out.print("ID inválido.");
    }
%>
