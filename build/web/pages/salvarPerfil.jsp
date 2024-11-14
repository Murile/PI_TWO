<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redireciona para login se o usuário não está logado
        return;
    }

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            String sql = "UPDATE usuario SET email = ?, senha = ? WHERE id_usuario = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, senha);
            st.setInt(3, userId);

            int rowsUpdated = st.executeUpdate();

            st.close();
            conn.close();

            if (rowsUpdated > 0) {
                out.println("<script>alert('Perfil atualizado com sucesso!');</script>");
                response.sendRedirect("perfil.jsp");
            } else {
                out.println("<script>alert('Erro ao atualizar o perfil.');</script>");
                response.sendRedirect("updatePerfil.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
        }
    } else {
        out.println("<script>alert('Preencha todos os campos.');</script>");
        response.sendRedirect("updatePerfil.jsp");
    }
%>
