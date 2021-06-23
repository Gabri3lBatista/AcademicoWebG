<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CursoLogic" />
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acadêmico</title>
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
<jsp:forward page="cursoIncluir.jsp" />
<%
	}
%>

<%

	cl.setConexao(cnx);

	if(request.getParameter("confirmar") != null){
		
		int codigo = Integer.parseInt(request.getParameter("codigo")); 
		String nome = request.getParameter("nome");
	
		cl.adicionar(codigo, nome);
%>
<jsp:forward page="cursoIncluir.jsp" />
<%
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Inclusão de Curso</h2>
<form action="cursoIncluir.jsp" method="post">
<p>
	Codigo: <input type="text" name="codigo" /> <br/>
	Nome: <input type="text" name="nome" />
</p>
<p>	
	<input type="submit" name="confirmar" value="Confirmar" />	
	<input type="submit" name="cancelar" value="Cancelar" />
</p>
</form>
</body>
</html>