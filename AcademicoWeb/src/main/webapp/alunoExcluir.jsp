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
<jsp:useBean id="a" scope="page" class="br.ufac.academico.entity.Aluno" />
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
	//PESSOAL, FALTOU LIGAR pl A cnx;
	al.setConexao(cnx);
	cl.setConexao(cnx);
	

	if(request.getParameter("confirmar") != null){
		long matricula = Long.parseLong(request.getParameter("matricula")); 
		al.remover(matricula);
		
%>
<jsp:forward page="alunoListar.jsp" />
<%
	}
%>
<%
	List<Curso> cursos = cl.recuperarTodosPorNome();

 	if(request.getParameter("matricula") != null &&
 		request.getParameter("nome") == null &&
 		request.getParameter("fone") == null &&
 		request.getParameter("endereco") == null &&
 		request.getParameter("cep") == null &&
 		request.getParameter("sexo") == null &&
 		request.getParameter("curso") == null)
 	{
 		long matricula = Long.parseLong(request.getParameter("matricula")); 
 		a = al.recuperar(matricula);
 	}

%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Edição de Aluno</h2>
<form action="alunoEditar.jsp" method="post">
<p>
	Matrícula: <input type="text" name="matricula" value="<%= a.getMatricula() %>" readonly="readonly" /> <br/>
	Nome: <input type="text" name="nome" value="<%= a.getNome() %>" /> <br/>
	Telefone: <input type="text" name="fone" value="<%= a.getFone() %>" /> <br/>
	Endereço: <input type="text" name="endereco" value="<%= a.getEndereco() %>" /> <br/>
	CEP: <input type="text" name="cep" value="<%= a.getCep() %>" /> <br/>	
	Sexo: <input type="text" name="sexo" value="<%= a.getFone() %>" /> <br/>
	Curso: <select name="curso">
<%
	for(Curso c : cursos){
%>
		<option value="<%= c.getCodigo()%>" <%= (c.getCodigo()==a.getCurso().getCodigo())?"selected":"" %> >
			<%= c.getNome()%>
		</option>
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