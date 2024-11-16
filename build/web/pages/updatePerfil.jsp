<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>

<%
    
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    
    if (email != null && senha != null) {
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

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
                } else {
                    out.println("<script>alert('Erro ao atualizar o perfil.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Atualizar Perfil</title>
    <link rel="stylesheet" href="./updateUser.css">
</head>
<body>
    <main>
        <h1>Atualizar Perfil</h1>
        <form method="post">
            <div class="update">
                <div>
                    <input type="email" name="email" placeholder="Email" required>
                </div>
                <div>
                    <input type="password" name="senha" placeholder="Senha" required>
                </div>
            </div>
            <div class="button">
                <button type="submit">Salvar Alterações</button>
            </div>
        </form>
    </main>
</body>
</html>
