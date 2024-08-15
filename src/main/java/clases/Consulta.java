package clases;

import java.sql.*;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import clases.Mensajes;
import clases.conexion;

public class Consulta {
	static Consulta consulta = new Consulta();
	conexion conexion = new conexion();
	Mensajes mensajes = new Mensajes();
	ResultSet resultado = null;
	//Connection connection = conexion.getConnection();

	public static void main(String[] arg) {

		String query = consulta.paginacion(2, 2);

	}

	public String paginacion(int limite, int pagina) {

		int paginas = pagina;
		int limites = limite;

		int offset = (pagina - 1) * limite;

		System.out.println(paginas);
		System.out.println(paginas);
		System.out.println(offset);

		String queryLimit = " Select * From productos where LIMIT " + limite + " OffSET " + offset;
		Mensajes.verMensaje("la consulta a sido " + queryLimit);

		// result Set resultado

		if (resultado != null) {
			System.out.println("entro");
			String nombre = "";
			try {
				while (resultado.next()) {
					try {
						String nombres = resultado.getString(nombre);
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}

				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
			System.out.println("no entre");
		}

		return queryLimit;
	}

}
