<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page errorPage="erro.jsp" %> 
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle Acadêmico</title>
</head>
<body>

<%
	String sair = request.getParameter("sair");
	if (sair != null){
		cnx.desconecte();
	}
%>

<%
	String usuario = request.getParameter("usuario");
	String senha = request.getParameter("senha");
	
	if (usuario != null && senha != null){
		if (!usuario.isEmpty() && !senha.isEmpty()){		
			cnx.conecte("jdbc:mysql://localhost/academico?scrollTolerantForwardOnly=true", usuario, senha);
		}
	}
	
%>

<%
	if (cnx.estaConectado()){
%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Entidades permitidas:</h2>
<ul>
	<li><a href="centroListar.jsp">Centro</a></li>
	<li><a href="professorListar.jsp">Professor</a></li>
	<li><a href="disciplinaListar.jsp">Disciplina</a></li>
	<li><a href="alunoListar.jsp">Aluno</a></li>
	<li><a href="cursoListar.jsp">Curso</a></li>
	<li><a href="curriculoListar.jsp">Curriculo</a></li>
	
</ul>
<a href="index.jsp?sair">Sair</a>

<%
	}else{
%>

<h1>Sistema de Controle Acadêmico</h1>
<h2>Autenticação</h2>

<form action="index.jsp" method="post">
<p>
	Informe seu nome: <input type="text" name="usuario" /> <br/>
	Informe sua senha: <input type="password" name="senha" /> <br/>
	<input type="submit" value="Entrar" />
</p>
</form>

<%	
	}
%>

</body>
</html>