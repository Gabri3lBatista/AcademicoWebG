<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CursoLogic" />
<jsp:useBean id="c" scope="page" class="br.ufac.academico.entity.Curso" />
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
<jsp:forward page="cursoListar.jsp" />
<%
	}
%>

<%

	cl.setConexao(cnx);

	if(request.getParameter("confirmar") != null){
		
		int codigo = Integer.parseInt(request.getParameter("codigo")); 
	
		cl.remover(codigo);
%>
<jsp:forward page="cursoListar.jsp" />
<%
	}
%>

<%
	if (request.getParameter("codigo") != null && 
		request.getParameter("nome") == null){
		
		
		int codigo = Integer.parseInt(request.getParameter("codigo")); 
		
		cl.remover(codigo);

%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Edição de Curso</h2>
<form action="cursoEditar.jsp" method="post">
<p>
	Código: <input type="text" name="codigo" value="<%= c.getCodigo() %>" readonly="readonly" /> <br/>
	Nome: <input type="text" name="nome" value="<%= c.getNome() %>" />
</p>
<p>	
	<input type="submit" name="confirmar" value="Confirmar" />	
	<input type="submit" name="cancelar" value="Cancelar" />
</p>
</form>
<%
	}
%>
</body>
</html>