<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Curriculo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CurriculoLogic" />
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
	<jsp:forward page="curriculoIncluir.jsp" />
<%
	}
%>

<%

	List<Curriculo> curriculos = new ArrayList<Curriculo>();
	cl.setConexao(cnx);

	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			curriculos = cl.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("codigo")){
				long codigo = Long.parseLong(valor);
				curriculos.add(cl.recuperar(codigo));
			}else{
				curriculos = cl.recuperarTodosPorNomeContendo(valor);
			}
		}
	}else{
		curriculos = cl.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Curriculo</h2>
<form action="curriculoListar.jsp" method="post">
<p>
	Chave: 
	<select name="chave">
		<option value="descricao">Descrição</option>
		<option value="codigo">Codigo</option>		
	</select>
	Valor: <input type="text" name="valor" />
	<input type="submit" name="buscar" value="Buscar" />
	<input type="submit" name="incluir" value="Incluir" />	
	<input type="submit" name="voltar" value="Voltar" />
</p>
</form>
<table border="1">
	<tr>
		<th>Codigo</th>
		<th>Descricão</th>
		<th>Curso</th>
		<th>Operações</th>
	</tr>
<%
	for(Curriculo c : curriculos){
%>
	<tr>
		<td><%= c.getCodigo() %></td>
		<td><%= c.getDescricao() %></td>		
		<td><%= c.getCurso().getCodigo() %></td>
		<td>
			<a href="curriculoEditar.jsp?codigo=<%= c.getCodigo() %>">Editar</a>
			<a href="curriculoExcluir.jsp?codigo=<%= c.getCodigo() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>