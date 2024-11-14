<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Parâmetros para controle do formulário de edição ou cadastro
    String idMusica = request.getParameter("id_musica");
    String titulo = "";
    String artista = "";
    double tempo = 0.0;
    boolean isEditing = (idMusica != null && !idMusica.isEmpty());

    // Se o ID da música foi passado, carregue os dados para edição
    if (isEditing) {
        try {
            int id = Integer.parseInt(idMusica);
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            PreparedStatement st = conecta.prepareStatement("SELECT * FROM tb_musica WHERE id_musica = ?");
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                titulo = rs.getString("titulo");
                artista = rs.getString("artista");
                tempo = rs.getDouble("tempo");
            }

            rs.close();
            st.close();
            conecta.close();

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao carregar dados para edição: " + e.getMessage() + "</p>");
        }
    }
%>

<% 
    if (!isEditing && request.getParameter("titulo") != null && request.getParameter("artista") != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            // Parâmetros para nova música
            titulo = request.getParameter("titulo");
            artista = request.getParameter("artista");
            tempo = Double.parseDouble(request.getParameter("tempo"));

            PreparedStatement insertSt = conecta.prepareStatement("INSERT INTO tb_musica (titulo, artista, tempo) VALUES (?, ?, ?)");
            insertSt.setString(1, titulo);
            insertSt.setString(2, artista);
            insertSt.setDouble(3, tempo);
            insertSt.executeUpdate();

            insertSt.close();
            conecta.close();

            out.println("<p style='color:green;'>Música cadastrada com sucesso!</p>");

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro ao cadastrar música: " + e.getMessage() + "</p>");
        }
    }
%>



