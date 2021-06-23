<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CentroLogic" />
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acadêmicooo</title>
</head>
<body>

<%
	if(!cnx.estaConectado()){
%>
<jsp:forward page="index.jsp" />
<%
	}
%>
 
<%
	if(request.getParameter("cancelar") != null){
%>
<jsp:forward page="centroListar.jsp" />
<%
	}
%>

<%

	cl.setConexao(cnx);

	if(request.getParameter("confirmar") != null){
		
		String sigla = request.getParameter("sigla"); 
		String nome = request.getParameter("nome");
	
		cl.adicionar(sigla, nome);
%>
<jsp:forward page="centroListar.jsp" />
<%
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Inclusão de Centro</h2>
<form action="centroIncluir.jsp" method="post">
<p>
	Sigla: <input type="text" name="sigla" /> <br/>
	Nome: <input type="text" name="nome" />
</p>
<p>	
	<input type="submit" name="confirmar" value="Confirmar" />	
	<input type="submit" name="cancelar" value="Cancelar" />
</p>
</form>
</body>
</html>