<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>      
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acadêmico</title>
</head>
<body>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Exceção Encontrada</h2>
<h3> <%= exception.getMessage() %></h3>
<a href="index.jsp">Voltar</a>
</body>
</html>