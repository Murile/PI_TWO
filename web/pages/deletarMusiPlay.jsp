<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idParam = request.getParameter("id_playlist"); // Obtém o ID da música
    if (idParam != null && !idParam.isEmpty()) {
        try {
            int id = Integer.parseInt(idParam);

            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

            PreparedStatement st = conecta.prepareStatement("DELETE FROM tb_playMusic WHERE id_playMusic = ?");
            st.setInt(1, id);
            int rowsAffected = st.executeUpdate();

            if (rowsAffected > 0) {
               response.sendRedirect("listenMusicPlay.jsp");
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
