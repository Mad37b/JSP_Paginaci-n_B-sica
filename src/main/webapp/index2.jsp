<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="clases.conexion"%>
<%@ page import="clases.Consulta"%>
<%@ page import="clases.Mensajes"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css">
<title>index2</title>
</head>
<body>
	<!--  Me conecto a la base de datos -->

	<%
	Connection conexion = null;
	Statement estado = null;
	Statement estado2=null;
	ResultSet resultado = null;
	ResultSet resultado2 = null;

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

		

	} catch (Exception e) {
		out.print("\n" + "conexion index2 null : " + e);
	}
	%>

	<!--  hago la consulta desde una clase java  -->

	<%

	
	
	//Form
	
	//int porLimit = (int) request.getAttribute(porLimit);
	//Paginacion 
	
	String paginacionPrev = request.getParameter("prevPage");
	String paginacionNext = request.getParameter("NextPage");
	
	//Limit Selectec
	
	String limitParam = request.getParameter("limitSelect");
	//inicia en null limitSelect
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);
	
	//Limit Form
	
	String limitForm = request.getParameter ("formLimit");
	Mensajes.verMensaje("Parametro Form Limit : " + limitForm);
	
	//SQL 

	String nombreSQL = request.getParameter("Nombre");
	String precioSQL = request.getParameter("Precio");
	String imagenSQL = request.getParameter("Imagen");
	
	// Variables 
    int contador = 1;
	int pagina = 2;
	

	
	if ( limitParam == null){
		
		limitParam ="3";
	}
	
	int intLimit  = Integer.parseInt(limitParam);
	 int limites = intLimit;
	// instancias 

	//Consulta consultasjsp = new Consulta ();  
	Mensajes mensajejsp = new Mensajes();
	// Query
	
	
	
					// verificar que si la paginacion es -1 siempre sea 0 
			
				if (paginacionNext != null) {
			pagina = Integer.parseInt(paginacionNext);
		
			Mensajes.verMensaje("valor de la pagina ++: " + pagina);
				}

				if (paginacionPrev != null) {
			pagina = Integer.parseInt(paginacionPrev);
		
			Mensajes.verMensaje("valor de la pagina --: " + pagina);
			
			if (pagina < 1) {
				pagina = 1; 
			}
				}
				
				int offset = (pagina - 1) * limites;
	%>


	<h1>Paginacion basica</h1>
	<hr>
	<p>Vamos a hacer una consulta con Limit y Offset y que nos devuelva
		la consulta</p>

	<%
	String mensaje = " ";
	String query = "SELECT * FROM productos LIMIT " + limites + " OFFSET " + offset;
	String querypage = "SELECT COUNT(*) AS total FROM productos";

	
	// ejecucamos consulta 
	resultado = estado.executeQuery(query);
	resultado2 = estado2.executeQuery(querypage);
	
	int totalRegistros = 0;

	if (resultado2.next()) {
	    totalRegistros = resultado2.getInt("total"); // Obtienes el valor de la columna 'total'
	}
	//out.print("el resultado de la consulta de las paginas ha sido :" + querypage);

	//if (resultado == null) {
	%>
	<table class="tabla" border="1">

		<tr>
			<th>-</th>
			<th>Nombre</th>
			<th>Precio</th>
			<th>Imagen</th>
			<th></th>
			<th></th>
			<th></th>
		</tr>

		<%
		if (resultado != null) {
			while (resultado.next()) {
		%>

		<tr>
			<th>-</th>
			<th>
				<%out.print(resultado.getString("nombre"));%>
			</th>
			<th>
				<%out.print(resultado.getDouble("Precio"));%>
			</th>
			<th>
				<%out.print(resultado.getString("Imagen"));%>
			</th>
			<th>5</th>
			<th>6</th>
			<th>7</th>
		</tr>


		<%
		}
		} else {
		out.print("no se ha podido dar resultado " + resultado);
		}
		%>
	</table>
	<!-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< FORM >>>>>>>>>>>>>>>>>>>>>>>> -->
	<!-- FORM  -->
	<!-- Select -->
	<%
	// usamos Ternaria if para recortar el codigo y hacer la condicion if 
	String selected3 = (limites == 3) ? "seleted" : "";
	String selected6 = (limites == 6) ? "seleted" : "";
	String selected9 = (limites == 9) ? "seleted" : "";
	String selected12 = (limites == 12) ? "seleted" : "";
	
	//int select3 = (int) request.getAtributte(0);
	
	

	
	
	%>
	
	
	<br>
	
	<!--  limite seria como tener un filtro de elementos que se muestran en pantalla por eso no lo unimos con la paginacion s -->
	<div class ="limite">
	<form action="index2.jsp"  name="limitForm" method="POST">
		<p>limite :</p>
		<select name="limitSelect" id="nProductosVista">
			<option value="3">3</option>
			<option value="6">6</option>
			<option value="9">9</option>
			<option value="12">12</option>
		</select>
		<input type="submit" value="Mostrar" id="datos" >
		
		
	</form>
	<%	if (limitParam != null && !limitParam.trim().isEmpty()){
		limites = Integer.parseInt(limitParam);
		Mensajes.verMensaje("el valor de limite es  :" +limites);
		
	}else{
	Mensajes.verMensaje("el valor por ahora es " + limites);
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);} 
	Mensajes.verMensaje("El form por ahora es :" + limitForm);
	
	if (limitForm !=null){
		 out.println("La opción seleccionada es: " + limitForm);
	}else{
		out.print("la opcion no ha sido seleccionada" + limitForm);
	}
	
	
	// convertir parametro String a int 
	
	
	if( limitParam !=null){
		 intLimit  = Integer.parseInt(limitParam);
		Mensajes.verMensaje("el parametro String a int ha sido : " + intLimit);
	}else{
		
		Mensajes.verMensaje("el parametro String a int no se ha convertido");
	}

	
	
	%>
	</div>
	 	<br>
		<br>
		<!--  form para la Paginacion -->
		<div class="contenedor">
		<form action="index2.jsp" name="pageform" method="POST">

			<input type="hidden" id="sumaPagina" name="NextPage"value=<%=pagina+1%>>
			 <input type="submit" class="boton"name="Siguiente" value="Siguiente" value=> 
		</form>
		<br>
		<%
	

		out.print("Offset : " + offset + "\n"+" | "+"Paginas : "+pagina);

		
		%>
		<form action="index2.jsp" name="pageform2">

			<input type="hidden" id="restaPagina" name="prevPage"value=<%=pagina-1%>> 
				<input type="submit" class="boton" name="Anterior" value="Anterior">

		</form>
</div>

		<%
		Mensajes.verMensaje(query);
		resultado2.close();

		%>



</body>
</html>