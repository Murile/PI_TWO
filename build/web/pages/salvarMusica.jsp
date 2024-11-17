<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>

<%

    String idMusica = request.getParameter("id_musica");
    String titulo = "";
    String artista = "";
    double tempo = 0.0;
    String mensagemStatus = null;

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
                response.sendRedirect("./listarMusica.jsp");
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
<html>
    <head>
        <title>Cadastrar Música</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./cadastrarMusic.css">
        <link href="https://fonts.googleapis.com/css2?family=Dela+Gothic+One&family=Inter:wght@100..900&family=Judson:ital,wght@0,400;0,700;1,400&display=swap" rel="stylesheet">
    </head>
    <body>
        <main>
            <div class="title">
                <h1>Alterar Música</h1>
            </div>
            <form method="post">
                <input type="hidden" name="id_musica" value="<%= idMusica%>">
                <input type="hidden" name="acao" value="salvar">
                <div class="form">
                    <div class="inputs">
                        <div>
                            <input type="text" id="titulo" name="titulo" value="<%= titulo%>" required>
                        </div>
                        <div>
                            <input id="artista" name="artista" value="<%= artista%>" required>
                        </div>
                        <div>
                            <input type="number"  id="tempo" name="tempo" step="0.01" value="<%= tempo%>" required>
                        </div>
                    </div>
                </div>
                <div class="button">
                    <button type="submit">Salvar Música</button>
                </div>
            </form>
        </main>
    </body>
</html>
