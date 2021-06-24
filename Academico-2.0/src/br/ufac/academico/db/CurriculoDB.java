package br.ufac.academico.db;

import br.ufac.academico.entity.*;
import br.ufac.academico.exception.DataBaseGenericException;
import br.ufac.academico.exception.DataBaseNotConnectedException;
import br.ufac.academico.exception.EntityNotExistsException;
import br.ufac.academico.exception.EntityTableIsEmptyException;

import java.sql.*;
import java.util.*;

public class CurriculoDB {

	private Conexao cnx;
	private CursoDB cdb;
	private ResultSet rs;
	
	public CurriculoDB(Conexao cnx) {
		this.cnx = cnx;
		cdb = new CursoDB(cnx);
	}
	
	public CurriculoDB() {
		cdb = new CursoDB();
	}
	
	public void setConexao(Conexao cnx) {
		this.cnx = cnx;
		cdb.setConexao(cnx);
	}

	public void adicionar(Curriculo curriculo) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "INSERT INTO curriculos (codigo, curso, descricao) "
				+ "VALUES ("
				+ 		curriculo.getCodigo() +", "
				+ "" + curriculo.getCurso().getCodigo() + ", "
				+ "'"+ curriculo.getDescricao() +"');";

		cnx.atualize(sqlAtualize);
		
	}
	
	public void atualizar(Curriculo curriculo) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "UPDATE curriculos SET "
                + "curso = " + 	curriculo.getCurso().getCodigo() + ", "
				+ "descricao = '"+ 	curriculo.getDescricao() +"'"
				+ " WHERE codigo = " + curriculo.getCodigo() +";";

		cnx.atualize(sqlAtualize);
		
	}
	
	public void remover(Curriculo curriculo) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "DELETE FROM curriculos "
				+ " WHERE codigo = '" + curriculo.getCodigo() +"';";

		cnx.atualize(sqlAtualize);
		
	}
	
	public Curriculo recuperar(long codigo) 
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityNotExistsException 
	{
		
		String sqlConsulta = "SELECT codigo AS 'Código', "
				+ "curso AS 'Curso', "
                + "descricao AS 'Descrição' "
				+ "FROM curriculos "
				+ "WHERE codigo = " + codigo +";";
		
		Curriculo curriculo = null;
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);
			
		try {
			if(rs.next()) {				
				curso = cdb.recuperar(rs.getInt(2));
				curriculo = new Curriculo(rs.getLong(1), curso, 
							rs.getString(3));
			}else {
				throw new EntityNotExistsException("Curriculo [codigo = " + codigo + "]");
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());				
		}
		return curriculo;
	}

	public List<Curriculo> recuperarTodos() 
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityNotExistsException, EntityTableIsEmptyException 
	{
		
		String sqlConsulta = "SELECT codigo AS 'Código', "
				+ "curso AS 'Curso', "
				+ "descricao AS 'Descrição' "
				+ "FROM curriculos;";

		List<Curriculo> curriculos = new ArrayList<Curriculo>();
		Curriculo curriculo = null;
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);		
		
		try {
			while(rs.next()) {
				curso = cdb.recuperar(rs.getInt(2));
				curriculo = new Curriculo(rs.getLong(1), curso, 
							rs.getString(3));
				curriculos.add(curriculo);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());			
		}
		if (curriculos.size() < 1) {
			throw new EntityTableIsEmptyException("Curriculo");
		}
		return curriculos;
	}

	public List<Curriculo> recuperarTodosPorNome()  
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityNotExistsException, EntityTableIsEmptyException 
	{
		
		String sqlConsulta = "SELECT codigo AS 'Código', "
				+ "curso AS 'Curso', "
				+ "descricao AS 'Descrição' "
				+ "FROM curriculos "
				+ "ORDER BY descricao;";

		List<Curriculo> curriculos = new ArrayList<Curriculo>();
		Curriculo curriculo = null;
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);		
		
		try {
			while(rs.next()) {
				curso = cdb.recuperar(rs.getInt(2));
				curriculo = new Curriculo(rs.getLong(1), curso, 
							rs.getString(3));
				curriculos.add(curriculo);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());			
		}
		if (curriculos.size() < 1) {
			throw new EntityTableIsEmptyException("Curriculo");
		}
		return curriculos;
	}
	
	public List<Curriculo> recuperarTodosPorNomeContendo(String descricao) 
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityNotExistsException 
	{
		
		String sqlConsulta = "SELECT codigo AS 'Código', "
				+ "curso AS 'Curso', "
				+ "descricao AS 'Descrição' "
				+ "FROM curriculos "
				+ "WHERE descricao like '%" + descricao + "%' "
				+ "ORDER BY descricao;";

		List<Curriculo> curriculos = new ArrayList<Curriculo>();
		Curriculo curriculo = null;
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);
		
		try {
			while(rs.next()) {
				
				curso = cdb.recuperar(rs.getInt(2));
				curriculo = new Curriculo(rs.getLong(1), curso, 
							rs.getString(3));
				curriculos.add(curriculo);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());				
		}
		return curriculos;
	}	
	
}