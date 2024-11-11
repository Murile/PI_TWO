<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <title>Cadastro de Usuário</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="./index.css">
</head>
<body>
   <%
        // Processamento do Cadastro
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        PreparedStatement st;

        if (nome != null && email != null && senha != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "");
                st = conn.prepareStatement("INSERT INTO usuario(nome, email, senha) VALUES (?, ?, ?)");
                st.setString(1, nome);
                st.setString(2, email);
                st.setString(3, senha);
                int rows = st.executeUpdate();
                
                if (rows > 0) {
                    response.sendRedirect(".././index.jsp");
                      out.println("<script>alert('Cadastro realizado com sucesso!');</script>");
                } else {
                    out.println("<script>alert('Erro ao realizar o cadastro.');</script>");
                }
                st.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
            }
        }
    %>
</body>
</html>

