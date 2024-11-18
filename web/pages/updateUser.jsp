<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Atualizar Usuário</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./updateUser.css">
        <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Inter:wght@100..900&family=Judson:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    </head>
    <body>
        <%
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String idParam = request.getParameter("id");

            String mensagemStatus = null;
            Connection conn = null;
            PreparedStatement stUpdate = null;
            PreparedStatement st = null;
            ResultSet rs = null;

            try {
                if (idParam != null && !idParam.trim().isEmpty()) {
                    int id = Integer.parseInt(idParam);

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

                    String sqlUpdate = "UPDATE usuario SET email = ?, senha = ? WHERE id_usuario = ?";
                    stUpdate = conn.prepareStatement(sqlUpdate);
                    stUpdate.setString(1, email);
                    stUpdate.setString(2, senha);
                    stUpdate.setInt(3, id);

                    int rowsUpdated = stUpdate.executeUpdate();
                    

                    String sqlSelect = "SELECT * FROM usuario WHERE id_usuario = ?";
                    st = conn.prepareStatement(sqlSelect);
                    st.setInt(1, id);
                    rs = st.executeQuery();

                    if (rs.next()) {
        %>
        <main>
            <form action="./updateUser.jsp" method="post">
                <div class="update">
                    <input type="hidden" name="id" value="<%= idParam%>" required>
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
        <%
                    } else {
                        mensagemStatus = "Erro: Usuário não encontrado.";
                    }
                } else {
                    mensagemStatus = "Erro: ID inválido.";
                }
            } catch (Exception e) {
                mensagemStatus = "Erro ao processar a atualização: " + e.getMessage();
            }
        %>
    </body>
</html>
