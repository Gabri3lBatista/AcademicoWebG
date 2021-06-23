<%@page import="java.util.ArrayList"%>
<%@page import="br.ufac.academico.entity.Aluno"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="al" scope="page" class="br.ufac.academico.logic.AlunoLogic" />
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
	<jsp:forward page="alunoIncluir.jsp" />
<%
	}
%>

<%
	List<Aluno> alunos = new ArrayList<Aluno>();
	al.setConexao(cnx);
	
	if(request.getParameter("buscar") != null){
		
		String chave = request.getParameter("chave"); 
		String valor = request.getParameter("valor");
	
		if (valor.isEmpty()){
			alunos = al.recuperarTodosPorNomeContendo("");
		}else{
			if(chave.equals("matricula")){
				long matricula = Long.parseLong(valor);
				alunos.add(al.recuperar(matricula));
			}else{
				alunos = al.recuperarTodosPorNomeContendo(valor);
			}
		}
	}else{	
		alunos = al.recuperarTodosPorNomeContendo("");
	}
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Consulta Alunos</h2>
<form action="alunosListar.jsp" method="post">
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
		<th>Curso</th>
		<th>Operações</th>
	</tr>
<%
	for(Aluno a : alunos){
%>
	<tr>
		<td><%= a.getMatricula() %></td>
		<td><%= a.getNome() %></td>		
		<td><%= a.getCurso().getCodigo() %></td>
		<td>
			<a href="alunosEditar.jsp?matricula=<%= a.getMatricula() %>">Editar</a>
			<a href="alunoEditar.jsp?matricula=<%= a.getMatricula() %>">Excluir</a>
		</td>
	</tr>
<%
	}
%>
</table>
</body>
</html>