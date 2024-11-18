<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>

<%
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    int userId = 0;

    if (email != null && senha != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");
            String sql = "SELECT * FROM usuario WHERE email = ? AND senha = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, email);
            st.setString(2, senha);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                userId = rs.getInt("id_usuario");
                System.out.println(userId);
                
                response.sendRedirect("/index.jsp?popup=false&id=" + userId);
            } else {
                out.println("<script>alert('Email ou senha incorretos.');</script>");
                response.sendRedirect("/");
            }

            rs.close();
            st.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Erro: " + e.getMessage() + "');</script>");
        }
    }
%>
