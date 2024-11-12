<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String titulo = request.getParameter("titulo");
    String artista = request.getParameter("artista");
    String tempoString = request.getParameter("tempo");
    double tempo = 0;

    try {
        // Tenta converter o valor do tempo
        tempo = Double.parseDouble(tempoString);
    } catch (NumberFormatException e) {
        out.print("Erro: O valor do tempo deve ser numérico (ex: 3.45 para 3 minutos e 45 segundos).");
        return; // Sai do script se houver erro de conversão
    }

    // Conexão com o banco de dados e inserção de dados
    try {
        Connection conecta;
        PreparedStatement st;
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

        st = conecta.prepareStatement("INSERT INTO tb_musica (titulo, artista, tempo) VALUES (?, ?, ?)");
        st.setString(1, titulo);
        st.setString(2, artista);
        st.setDouble(3, tempo);

        st.executeUpdate();
        out.print("Música cadastrada com sucesso.");

        st.close();
        conecta.close();

    } catch (Exception x) {
        out.print("Erro ao inserir no banco: " + x.getMessage());
    }
%>

