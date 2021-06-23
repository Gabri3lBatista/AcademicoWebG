<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Professor"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="erro.jsp"%>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="pl" scope="page" class="br.ufac.academico.logic.ProfessorLogic" />
<head>
<meta charset="UTF-8">
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
	<jsp:forward page="professorIncluir.jsp" />
<%
	}
%>

<%

	List<Professor> professores = new ArrayList<Professor>();
	pl.setConexao(cnx);

	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			professores = pl.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("matricula")){
				long matricula = Long.parseLong(valor);
				professores.add(pl.recuperar(matricula));
			}else{
				professores = pl.recuperarTodosPorNomeContendo(valor);
			}
		}
	}else{
		professores = pl.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Professores</h2>
<form action="professorListar.jsp" method="post">
<p>
	Chave: 
	<select name="chave">
		<option value="nome">Nome</option>
		<option value="matricula">Matrícula</option>		
	</select>
	Valor: <input type="text" name="valor" />
	<input type="submit" name="buscar" value="Buscar" />
	<input type="submit" name="incluir" value="Incluir" />	
	<input type="submit" name="voltar" value="Voltar" />
</p>
</form>
<table border="1">
	<tr>
		<th>Matrícula</th>
		<th>Nome</th>
		<th>Centro</th>
		<th>Operações</th>
	</tr>
<%
	for(Professor p : professores){
%>
	<tr>
		<td><%= p.getMatricula() %></td>
		<td><%= p.getNome() %></td>		
		<td><%= p.getCentro().getSigla() %></td>
		<td>
			<a href="professorEditar.jsp?matricula=<%= p.getMatricula() %>">Editar</a>
			<a href="professorExcluir.jsp?matricula=<%= p.getMatricula() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>