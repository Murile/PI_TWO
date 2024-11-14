<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%
    // Inicializar variáveis
    String idMusica = request.getParameter("id_musica");
    String titulo = "";
    String artista = "";
    double tempo = 0.0;
    String mensagemStatus = null;

    // Verifique se o formulário foi enviado para salvar
    if ("salvar".equals(request.getParameter("acao"))) {
        titulo = request.getParameter("titulo");
        artista = request.getParameter("artista");
        String tempoStr = request.getParameter("tempo");

        if (tempoStr != null && !tempoStr.isEmpty()) {
            try {
                tempo = Double.parseDouble(tempoStr);
            } catch (NumberFormatException e) {
                mensagemStatus = "Erro: Tempo inválido.";
            }
        }

        // Realiza o update no banco de dados, se o id da música foi passado
        if (idMusica != null && !idMusica.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

                String sqlUpdate = "UPDATE tb_musica SET titulo = ?, artista = ?, tempo = ? WHERE id_musica = ?";
                PreparedStatement stUpdate = conecta.prepareStatement(sqlUpdate);
                stUpdate.setString(1, titulo);
                stUpdate.setString(2, artista);
                stUpdate.setDouble(3, tempo);
                stUpdate.setInt(4, Integer.parseInt(idMusica));

                int rowsUpdated = stUpdate.executeUpdate();
                stUpdate.close();
                conecta.close();

                if (rowsUpdated > 0) {
                    mensagemStatus = "Música atualizada com sucesso!";
                } else {
                    mensagemStatus = "Erro ao atualizar a música.";
                }
            } catch (Exception e) {
                mensagemStatus = "Erro ao processar a atualização: " + e.getMessage();
            }
        }
    } else if (idMusica != null && !idMusica.isEmpty()) {
        // Carregar dados da música para exibição inicial no formulário
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/cenna", "root", "TbX77HHVdbXWca");

            PreparedStatement stSelect = conecta.prepareStatement("SELECT titulo, artista, tempo FROM tb_musica WHERE id_musica = ?");
            stSelect.setInt(1, Integer.parseInt(idMusica));
            ResultSet rs = stSelect.executeQuery();

            if (rs.next()) {
                titulo = rs.getString("titulo");
                artista = rs.getString("artista");
                tempo = rs.getDouble("tempo");
            } else {
                mensagemStatus = "Erro: Música não encontrada para o ID fornecido.";
            }

            rs.close();
            stSelect.close();
            conecta.close();

        } catch (Exception e) {
            mensagemStatus = "Erro ao carregar dados para edição: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Música</title>
    <link rel="stylesheet" href="SsalvarMusic.css">
</head>
<body>
    <h2><%= (idMusica != null && !idMusica.isEmpty()) ? "Editar Música" : "Cadastrar Nova Música" %></h2>

    <% if (mensagemStatus != null) { %>
        <p style="color:<%= mensagemStatus.contains("sucesso") ? "green" : "red" %>;"><%= mensagemStatus %></p>
    <% } %>

    <form method="post">
        <input type="hidden" name="id_musica" value="<%= idMusica %>">
        <input type="hidden" name="acao" value="salvar">
        
        <label for="titulo">Título:</label>
        <input type="text" id="titulo" name="titulo" value="<%= titulo %>" required><br>

        <label for="artista">Artista:</label>
        <input type="text" id="artista" name="artista" value="<%= artista %>" required><br>

        <label for="tempo">Tempo (em minutos):</label>
        <input type="number" id="tempo" name="tempo" step="0.01" value="<%= tempo %>" required><br>

        <button type="submit">Salvar Música</button>
    </form>
</body>
</html>

