<%@page import="br.ufac.academico.entity.Centro"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="pl" scope="page" class="br.ufac.academico.logic.ProfessorLogic" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CentroLogic" />
<jsp:useBean id="centro" scope="page" class="br.ufac.academico.entity.Centro" />
<head>
<meta charset="UTF-8">
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
<jsp:forward page="professorListar.jsp" />
<%
	}
%>

<%
	//PESSOAL, FALTOU LIGAR pl A cnx;
	pl.setConexao(cnx);
	cl.setConexao(cnx);
	

	if(request.getParameter("confirmar") != null){
		
		long matricula = Long.parseLong(request.getParameter("matricula")); 
		String nome = request.getParameter("nome");
		long rg = Long.parseLong(request.getParameter("rg")); 
		long cpf = Long.parseLong(request.getParameter("cpf"));
		String endereco = request.getParameter("endereco");
		String fone = request.getParameter("fone");
		String sigla = request.getParameter("centro");
		centro = cl.recuperar(sigla);
		pl.adicionar(matricula, nome, rg, cpf, endereco, fone, centro);
		
%>
<jsp:forward page="professorListar.jsp" />
<%
	}
%>
<%
	List<Centro> centros = cl.recuperarTodosPorNome();
%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Inclusão de Professor</h2>
<form action="professorIncluir.jsp" method="post">
<p>
	Matrícula: <input type="text" name="matricula" /> <br/>
	Nome: <input type="text" name="nome" /> <br/>
	RG: <input type="text" name="rg" /> <br/>
	CPF: <input type="text" name="cpf" /> <br/>	
	Endereço: <input type="text" name="endereco" /> <br/>
	Telefone: <input type="text" name="fone" /> <br/>
	Centro: <select name="centro">
<%
	for(Centro c : centros){
%>
		<option value="<%= c.getSigla()%>"><%= c.getNome()%></option>
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