<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Centro"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CentroLogic" />
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acadêmico</title>
</head>
<body>

<%
	if(!cnx.estaConectado() || request.getParameter("voltar") != null){
%>
<jsp:forward page="index.jsp" />
<%
	}
%>
 
<%
	if(request.getParameter("incluir") != null){
%>
<jsp:forward page="centroIncluir.jsp" />
<%
	}
%>

<%

	List<Centro> centros = new ArrayList<Centro>();
	cl.setConexao(cnx);

	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			centros = cl.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("sigla")){
				centros.add(cl.recuperar(valor));
			}else{
				centros = cl.recuperarTodosPorNomeContendo("");
			}
		}
	}else{
		centros = cl.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Centros</h2>
<form action="centroListar.jsp" method="post">
<p>
	Chave: 
	<select name="chave">
		<option value="nome">Nome</option>
		<option value="sigla">Sigla</option>		
	</select>
	Valor: <input type="text" name="valor" />
	<input type="submit" name="buscar" value="Buscar" />
	<input type="submit" name="incluir" value="Incluir" />	
	<input type="submit" name="voltar" value="Voltar" />
</p>
</form>
<table border="1">
	<tr><th>Sigla</th><th>Nome</th><th>Operações</th></tr>
<%
	for(Centro c : centros){
%>
	<tr>
		<td><%= c.getSigla() %></td>
		<td><%= c.getNome() %></td>
		<td>
			<a href="centroEditar.jsp?sigla=<%= c.getSigla() %>">Editar</a>
			<a href="centroExcluir.jsp?sigla=<%= c.getSigla() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>