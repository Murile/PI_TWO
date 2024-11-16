<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Verifique se o usuário está logado e pegue o ID do usuário
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp"); // Redireciona para login se o usuário não estiver logado
        return;
    }

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

            // Atualiza o email e senha do usuário no banco de dados
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
                response.sendRedirect("updatePerfil.jsp"); // Redireciona para a página de perfil
            } else {
                out.println("<script>alert('Erro ao atualizar o perfil.');</script>");
                response.sendRedirect("updatePerfil.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
        }
    } else {
        out.println("<script>alert('Por favor, preencha todos os campos.');</script>");
        response.sendRedirect("updatePerfil.jsp");
    }
%>
