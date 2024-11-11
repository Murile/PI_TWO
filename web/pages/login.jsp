<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@ page import="java.sql.*" %>


<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");

    if (email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "");
            String sql = "SELECT * FROM usuario WHERE email = ? AND senha = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, senha);
            ResultSet rs = st.executeQuery();
            boolean sucess = rs.next();
            rs.close();
            st.close();
            conn.close();


            if (sucess) {
                response.sendRedirect("/index.jsp?popup=" + false);
            } else {
                out.println("<script>alert('Email ou senha incorretos.');</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
        }
    }
%>