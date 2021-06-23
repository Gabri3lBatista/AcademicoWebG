<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Disciplina"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="dl" scope="page" class="br.ufac.academico.logic.DisciplinaLogic" />
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
	<jsp:forward page="disciplinaIncluir.jsp" />
<%
	}
%>

<%

	List<Disciplina> disciplinas = new ArrayList<Disciplina>();
	dl.setConexao(cnx);

	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			disciplinas = dl.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("codigo")){
				String codigo = valor;
				disciplinas.add(dl.recuperar(codigo));
			}else{
				disciplinas = dl.recuperarTodosPorNomeContendo(valor);
			}
		}
	}else{
		disciplinas = dl.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Disciplinas</h2>
<form action="disciplinaListar.jsp" method="post">
<p>
	Chave: 
	<select name="chave">
		<option value="nome">Nome</option>
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
		<th>Nome</th>
		<th>Centro</th>
		<th>Operações</th>
	</tr>
<%
	for(Disciplina d : disciplinas){
%>
	<tr>
		<td><%= d.getCodigo() %></td>
		<td><%= d.getNome() %></td>		
		<td><%= d.getCentro().getSigla() %></td>
		<td>
			<a href="discidlinaEditar.jsp?codigo=<%= d.getCodigo() %>">Editar</a>
			<a href="discidlinaExcluir.jsp?codigo=<%= d.getCodigo() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>