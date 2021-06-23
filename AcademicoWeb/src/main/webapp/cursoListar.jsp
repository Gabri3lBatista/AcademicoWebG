<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Curso"%>

<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="cul" scope="page" class="br.ufac.academico.logic.CursoLogic" />
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
<jsp:forward page="cursoIncluir.jsp" />
<%
	}
%>

<%

	List<Curso> cursos = new ArrayList<Curso>();
	cul.setConexao(cnx);

	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			cursos = cul.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("codigo")){
				cursos.add(cul.recuperar(Integer.parseInt(valor)));
			}else{
				cursos = cul.recuperarTodosPorNomeContendo("");
			}
		}
	}else{
		cursos = cul.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Cursos</h2>
<form action="cursoListar.jsp" method="post">
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
	<tr><th>Codigo</th><th>Nome</th><th>Operações</th></tr>
<%
	for(Curso c : cursos){
%>
	<tr>
		<td><%= c.getCodigo() %></td>
		<td><%= c.getNome() %></td>
		<td>
			<a href="cursoEditar.jsp?codigo=<%= c.getCodigo() %>">Editar</a>
			<a href="cursoExcluir.jsp?codigo=<%= c.getCodigo() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>