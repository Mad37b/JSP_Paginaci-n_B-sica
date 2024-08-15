package clases;

import clases.Mensajes;
import java.sql.*;

public class conexion {

	private String url;
	private String controlador ;
	private String usuario ;
	private String contraseña ;
	private Statement estado ;
	private Connection conexion;

	public conexion() {
		// le paso los valores en el constructor
		
		usuario = "Admin";
		contraseña = "Admin";
		url = "jdbc:mysql://localhost:3307/pagina";
		controlador = "com.mysql.cj.jdbc.Driver";
		// Driver
		try {

			Class.forName(controlador);
			System.out.println("Diver establecido");
		} catch (Exception e) {
			System.out.println("Fallo al inicializar el driver JDBC en la clase Conexion" + e.toString() + "\n" + "\n");
		}
		// Conexion
		try {
			conexion = DriverManager.getConnection(url, usuario, contraseña);

			System.out.println("Estado de la conexion realizada  :" + conexion);
		} catch (Exception e2) {

			System.out.println(" Conexion no realizada  : " + e2);
			System.out.println("url : "+url +"\n"+"usuario :"+ usuario +"\n" +"contraseña :"+ contraseña);
			System.out.println(conexion);

			e2.printStackTrace();
		}
		try {
			estado = conexion.createStatement();
		} catch (SQLException e3) {
			System.out.println("el estado es " + estado +"\n" + e3);
			e3.printStackTrace();

		}

	}

	   public String toString() {
	        return "Conexion [url=" + url + ", usuario=" + usuario + ", conexion=" + conexion + "]";
	    }

	public Statement getEstado() {
		return estado;
	}

	public void setEstado(Statement estado) {
		this.estado = estado;
	}

}
