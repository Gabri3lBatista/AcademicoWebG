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
<jsp:useBean id="p" scope="page" class="br.ufac.academico.entity.Professor" />
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
		pl.atualizar(matricula, nome, rg, cpf, endereco, fone, centro);
		
%>
<jsp:forward page="professorListar.jsp" />
<%
	}
%>
<%
	List<Centro> centros = cl.recuperarTodosPorNome();

 	if(request.getParameter("matricula") != null &&
 		request.getParameter("nome") == null &&
 		request.getParameter("rg") == null &&
 		request.getParameter("cpf") == null &&
 		request.getParameter("endereco") == null &&
 		request.getParameter("fone") == null &&
 		request.getParameter("centro") == null)
 	{
 		long matricula = Long.parseLong(request.getParameter("matricula")); 
 		p = pl.recuperar(matricula);
 	}

%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Edição de Professor</h2>
<form action="professorEditar.jsp" method="post">
<p>
	Matrícula: <input type="text" name="matricula" value="<%= p.getMatricula() %>" readonly="readonly" /> <br/>
	Nome: <input type="text" name="nome" value="<%= p.getNome() %>" /> <br/>
	RG: <input type="text" name="rg" value="<%= p.getRg() %>" /> <br/>
	CPF: <input type="text" name="cpf" value="<%= p.getCpf() %>" /> <br/>	
	Endereço: <input type="text" name="endereco" value="<%= p.getEndereco() %>" /> <br/>
	Telefone: <input type="text" name="fone" value="<%= p.getFone() %>" /> <br/>
	Centro: <select name="centro">
<%
	for(Centro c : centros){
%>
		<option value="<%= c.getSigla()%>" <%= (c.getSigla().equals(p.getCentro().getSigla()))?"selected":"" %> >
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