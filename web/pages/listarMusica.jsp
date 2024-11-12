<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="utf-8"%>

<%
    
    Connection conecta;
    PreparedStatement st;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

        
        st = conecta.prepareStatement("SELECT * FROM tb_musica");
        ResultSet rs = st.executeQuery();

        
        while (rs.next()) {
            String titulo = rs.getString("titulo");
            String artista = rs.getString("artista");
            double tempo = rs.getDouble("tempo");
%>
            <div class="card">
                <div class="content">
                    <div class="titleMusic">
                        <p><strong>Título:</strong> <%= titulo %></p>
                        <p><strong>Artista:</strong> <%= artista %></p>
                        <p><strong>Duração:</strong> <%= tempo %> min</p>
                    </div>
                </div>
                <div class="function">
                    <a href="#" class="plus"><i class="fas fa-plus"></i></a>
                    <a href="#" class="close"><i class="fas fa-times"></i></a>
                    <a href="#" class="edit"><i class="fas fa-edit"></i></a>
                </div>
            </div>
<%
        }

        rs.close();
        st.close();
        conecta.close();
    } catch (Exception x) {
        out.print("Erro ao carregar músicas: " + x.getMessage());
    }
%>
