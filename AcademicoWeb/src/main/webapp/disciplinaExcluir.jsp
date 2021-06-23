<%@page import="br.ufac.academico.entity.Centro"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page errorPage="erro.jsp" %>
<!DOCTYPE html>
<html>
<jsp:useBean id="cnx" scope="session" class="br.ufac.academico.db.Conexao" />
<jsp:useBean id="dl" scope="page" class="br.ufac.academico.logic.DisciplinaLogic" />
<jsp:useBean id="cl" scope="page" class="br.ufac.academico.logic.CentroLogic" />
<jsp:useBean id="centro" scope="page" class="br.ufac.academico.entity.Centro" />
<jsp:useBean id="d" scope="page" class="br.ufac.academico.entity.Disciplina" />
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
<jsp:forward page="disciplinaListar.jsp" />
<%
	}
%>

<%
	//PESSOAL, FALTOU LIGAR pl A cnx;
	dl.setConexao(cnx);
	cl.setConexao(cnx);
	

	if(request.getParameter("confirmar") != null){
		String codigo = request.getParameter("codigo" ); 
		dl.remover(codigo);
		
%>
<jsp:forward page="disciplinaListar.jsp" />
<%
	}
%>
<%
	List<Centro> centros = cl.recuperarTodosPorNome();

 	if(request.getParameter("codigo") != null &&
 		request.getParameter("nome") == null &&
 		request.getParameter("ch") == null &&
 		request.getParameter("centro") == null)
 	{
 		String codigo = request.getParameter("codigo"); 
 		d = dl.recuperar(codigo);
 	}

%>
<h1>Sistema de Controle Acadêmico</h1>
<h2>Edição de Disciplina</h2>
<form action="disciplinaEditar.jsp" method="post">
<p>
	Codigo: <input type="text" name="codigo" value="<%= d.getCodigo() %>" readonly="readonly" /> <br/>
	Nome: <input type="text" name="nome" value="<%= d.getNome() %>" /> <br/>
	CH: <input type="text" name="rg" value="<%= d.getCh() %>" /> <br/>
	Centro: <select name="centro" disabled="disabled">
<%
	for(Centro c : centros){
%>
		<option value="<%= c.getSigla()%>" <%= (c.getSigla().equals(d.getCentro().getSigla()))?"selected":"" %> >
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