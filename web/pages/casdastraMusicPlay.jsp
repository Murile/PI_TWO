<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

    String titulo, idParam;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "1234");

            titulo = request.getParameter("titulo");
            idParam = request.getParameter("id_playlist");
            
            PreparedStatement st = conecta.prepareStatement("insert into tb_playMusic (id_musica, id_playlist) values (?,?);");
            st.setString(1, titulo);
            st.setString(2, idParam);
            st.executeUpdate();

            st.close();
            conecta.close();

            response.sendRedirect("./listenMusicPlay.jsp");

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao cadastrar música: " + e.getMessage() + "</p>");
        }
%>