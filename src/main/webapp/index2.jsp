<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="clases.conexion"%>
<%@ page import="clases.Consulta"%>
<%@ page import="clases.Mensajes"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index2</title>
</head>
<body>
	<!--  Me conecto a la base de datos -->

	<%
	Connection conexion = null;
	Statement estado = null;
	ResultSet resultado = null;

	try {
		out.println(" Deputacion de la conexion : ");
		out.println("Estacleciendo conexion con el controlador, -->");
		String controlador = "com.mysql.cj.jdbc.Driver";
		out.println("  Conexion Estaclecida con el controlador " + controlador);
		Class.forName(controlador);
		out.println("  Iniciando sesion - 0");

		String url = "jdbc:mysql://localhost:3307/pagina";
		String usuario = "Admin";
		String pass = "11111";

		out.println(
		" ,Sesion iniciada  =" + " -- " + url + " - " + "  Usuario :" + usuario + " - " + " Contraseña : " + pass);

		conexion = DriverManager.getConnection(url, usuario, pass);
		out.println("conexion" + conexion);

		estado = conexion.createStatement();
		out.println("Conexión realizada" + estado);

		int contador = 1;

	} catch (Exception e) {
		out.print("\n" + "conexion index2 null : " + e);
	}
	%>

	<!--  hago la consulta desde una clase java  -->

	<%
	// Variables 
	
	int limites = 12;
	int pagina = 1; 
	int offset = (pagina - 1) * limites;
	//String resultadoConsulta = consultasjsp.paginacion(limite, pagina); decartar
	String limiteParam = request.getParameter("limitesForm");
	String paginaParam = request.getParameter("pagina");
	String formParam = request.getParameter("form");
	String selectParam = request.getParameter("limitForm");
	String formularioParam = request.getParameter("limiteForm");
	
	
	//SQL 
	
		String nombreSQL = request.getParameter("Nombre");
		String precioSQL = request.getParameter("Precio");
		String imagenSQL = request.getParameter("Imagen");
		
		// instancias 
		
	//Consulta consultasjsp = new Consulta ();  
	Mensajes mensajejsp = new Mensajes();
	// Query 
	
	
	
	
	%>


	<h1>Paginacion basica</h1>
	<hr>
	<p> Vamos a hacer una consulta con Limit y Offset y que nos devuelva la consulta </p>
	
	<%
	String mensaje = " ";
	String query = "SELECT * FROM productos LIMIT " + limites + " OFFSET " + offset;
	// ejecucamos consulta 
	resultado = estado.executeQuery(query);

	//if (resultado == null) {
	%>
	
	<%
	if ( resultado  != null){
	while(resultado.next())	{
	%>
	<table class="tpl-tabla" border="1">

		<tr>
			<th>-</th>
			<th>ID</th>
			<th>Precio</th>
			<th>Precio</th>
			<th>Imagen</th>
			<th></th>
			<th></th>
		</tr>
		<tr>
			<th>-</th>
			<th><%out.print(resultado.getString("nombre")); %></th>
			<th><%out.print(resultado.getDouble("Precio")); %></th>
			<th><%out.print(resultado.getString("Imagen")); %></th>
			<th>5</th>
			<th>6</th>
			<th>7</th>
		</tr>

	</table>
	<%
	}} else { 
		out.print("no se ha podido dar resultado " + resultado);
	}
	
	%>
	<br>
	<form action="index2.jsp" name="form">
		<p>limite :</p>
		<input type="submit" value="Mostrar" id="datos" method="post">
		<select name="limiteForm" id="nProductosVista">
			<option value="3">3</option>
			<option value="6">6</option>
			<option value="9">9</option>
			<option value="12">12</option>
		</select>
		<br><br>
		<form action="index2.jps" name="pageform">
		
		<input type="hidden" id="sumaPagina" name="NextPage">
		<input type="submit" name="Siguiente" value="Siguiente" >
		<input type= "number" min="1" >
		</form>
		<br>
		<form action="index2.jps" name="pageform2">
		
		<input type="hidden" id="restaPagina" name="prevPage">
		<input type="submit" name="Anterior" value="Anterior">
		
		</form>
		<%

	out.print("Offset : "+offset+"\n");

		//resultado = estado.executeQuery(query); //Mensajes.verMensaje("la consulta ha sido"+ resultadoConsulta);
		%>

	<%Mensajes.verMensaje(query); %>

	</form>

</body>
</html>