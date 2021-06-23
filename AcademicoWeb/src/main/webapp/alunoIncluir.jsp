<%@page import="br.ufac.academico.entity.Curso"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="al" scope="page" class="br.ufac.academico.logic.AlunoLogic" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CursoLogic" />
<jsp:useBean id="curso" scope="page" class="br.ufac.academico.entity.Curso" />

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
<jsp:forward page="alunoListar.jsp" />
<%
	}
%>

<%
	//PESSOAL, FALTOU LIGAR al A cnx;
	al.setConexao(cnx);
	cl.setConexao(cnx);
	

	if(request.getParameter("confirmar") != null){
		long matricula = Long.parseLong(request.getParameter("matricula")); 
		String nome = request.getParameter("nome");
		String fone = request.getParameter("fone"); 
		String endereco = request.getParameter("endereco");
		String cep = request.getParameter("cep");
		String sexo = request.getParameter("sexo");
		String codigo = request.getParameter("curso");
		curso = cl.recuperar(Integer.parseInt(codigo));
		al.atualizar(matricula, nome, fone, endereco, cep, sexo, curso);
		
%>
<jsp:forward page="alunoListar.jsp" />
<%
	}
%>
<%
	List<Curso> cursos = cl.recuperarTodosPorNome();
%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Inclusão de Aluno</h2>
<form action="alunoIncluir" method="post">
<p>
	Matrícula: <input type="text" name="matricula" /> <br/>
	Nome: <input type="text" name="nome" /> <br/>
	Telefone: <input type="text" name="telefone" /> <br/>
	Endereço: <input type="text" name="endereco"  /> <br/>
	CEP: <input type="text" name="cep" /> <br/>	
	Sexo: <input type="text" name="sexo"   /> <br/>
	Curso: <select name="curso">
<%
	for(Curso c : cursos){
%>
		<option value="<%= c.getCodigo()%>"><%= c.getNome()%></option>
<%
	}
%>				
	</select>
	
</p>
<p>	
	<input type="submit" name="confirmar" value="Confirmar" />	
	<input type="submit" name="cancelar" value="Cancelar" />
</p>
</form>
</body>
</html>