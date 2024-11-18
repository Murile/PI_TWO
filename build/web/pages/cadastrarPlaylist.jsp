<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String titulo = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

            titulo = request.getParameter("titulo");

            PreparedStatement insertSt = conecta.prepareStatement("INSERT INTO playlist (nome) VALUE(?);");
            insertSt.setString(1, titulo);
            insertSt.executeUpdate();

            insertSt.close();
            conecta.close();

            response.sendRedirect("./listenPlaylist.jsp");

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao cadastrar música: " + e.getMessage() + "</p>");
        }
%>