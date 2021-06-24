package br.ufac.academico.db;
import br.ufac.academico.entity.*;
import br.ufac.academico.exception.*;

import java.sql.*;
import java.util.*;

public class CursoDB {

	private Conexao cnx;
	private ResultSet rs ;
	
	public CursoDB(Conexao cnx) {
		this.cnx = cnx;
	}
	public CursoDB() {
		
	}
	
	public void setConexao(Conexao cnx) {
		this.cnx = cnx;		
	}
	
	public void adicionar(Curso curso) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "INSERT INTO cursos (codigo, nome) "
				+ "VALUES (" + curso.getCodigo() + ", "
						+ "'"+ curso.getNome() + "');";
			
		cnx.atualize(sqlAtualize);
		
	}
	
	public void atualizar(Curso curso) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "UPDATE cursos "
				+ "SET nome = '" + curso.getNome() + "' "
				+ "WHERE codigo = " + curso.getCodigo() + ";";

		cnx.atualize(sqlAtualize);
		
	}
	
	public void remover(Curso curso) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{

		String sqlAtualize = "DELETE FROM cursos "
				+ "WHERE codigo = " + curso.getCodigo() + ";";

		cnx.atualize(sqlAtualize);
		
	}
	
	public Curso recuperar(int codigo) 
	throws DataBaseNotConnectedException, DataBaseGenericException,
		EntityNotExistsException
	{
		
		String sqlConsulta = "SELECT codigo, nome "
				+ "FROM cursos "
				+ "WHERE codigo = " + codigo + ";";
		
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);
			
		try {
			if(rs.next()) {
				curso = new Curso(rs.getInt(1), rs.getString(2));
			}else{
				// CONSEGUIU EXECUTAR next, MAS RETORNOU false
				throw new EntityNotExistsException("Curso [codigo = " + codigo + "]");
			}
		} catch (SQLException e) {
			//HOUVE ALGUMA FALHA NA EXECUÇÃO DO next
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());
		}
		return curso;
	}

	public List<Curso> recuperarTodos() 
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityTableIsEmptyException 
	{
		
		String sqlConsulta = 
				"SELECT codigo, nome "
				+ "FROM cursos;";

		List<Curso> cursos = new ArrayList<Curso>();
		Curso curso = null;
		
		rs = cnx.consulte(sqlConsulta);		
		
		try {
			while(rs.next()) {
				curso = new Curso(rs.getInt(1), rs.getString(2));
				cursos.add(curso);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());		
		}
		if (cursos.size() < 1) {
			throw new EntityTableIsEmptyException("Curso");
		}		
		return cursos;
	}

	public List<Curso> recuperarTodosPorNome() 
	throws DataBaseNotConnectedException, DataBaseGenericException, 
		EntityTableIsEmptyException
	{
		
		String sqlConsulta = 
				"SELECT codigo, nome "
				+ "FROM cursos "
				+ "ORDER BY nome;";

		List<Curso> cursos = new ArrayList<Curso>();
		Curso curso=null;
		
		rs = cnx.consulte(sqlConsulta);		
		
		try {
			while(rs.next()) {
				curso = new Curso(rs.getInt(1), rs.getString(2));
				cursos.add(curso);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());			
		}
		if (cursos.size() < 1) {
			throw new EntityTableIsEmptyException("Curso");
		}
		return cursos;
	}
	
	public List<Curso> recuperarTodosPorNomeContendo(String nome) 
	throws DataBaseNotConnectedException, DataBaseGenericException 
	{
		
		String sqlConsulta = 
				"SELECT codigo, nome "
				+ "FROM cursos "
				+ "WHERE nome like '%" + nome + "%' "
				+ "ORDER BY nome;";

		List<Curso> cursos = new ArrayList<Curso>();
		Curso curso=null;
		
		rs = cnx.consulte(sqlConsulta);
		
		try {
			while(rs.next()) {
				curso = new Curso(rs.getInt(1), rs.getString(2));
				cursos.add(curso);
			}
		} catch (SQLException e) {
			throw new DataBaseGenericException(e.getErrorCode(), e.getMessage());			
		}
		return cursos;
	}	
	
}



