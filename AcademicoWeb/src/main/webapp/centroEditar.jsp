<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CentroLogic" />
<jsp:useBean id="c" scope="page" class="br.ufac.academico.entity.Centro" />
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
<jsp:forward page="centroListar.jsp" />
<%
	}
%>

<%

	cl.setConexao(cnx);

	if(request.getParameter("confirmar") != null){
		
		String sigla = request.getParameter("sigla"); 
		String nome = request.getParameter("nome");
	
		cl.atualizar(sigla, nome);
%>
<jsp:forward page="centroListar.jsp" />
<%
	}
%>

<%
	if (request.getParameter("sigla") != null && request.getParameter("nome") == null){
		
		c = cl.recuperar(request.getParameter("sigla"));

%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Edição de Centro</h2>
<form action="centroEditar.jsp" method="post">
<p>
	Sigla: <input type="text" name="sigla" value="<%= c.getSigla() %>" readonly="readonly" /> <br/>
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