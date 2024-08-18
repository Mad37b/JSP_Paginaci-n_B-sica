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

		

	} catch (Exception e) {
		out.print("\n" + "conexion index2 null : " + e);
	}
	%>

	<!--  hago la consulta desde una clase java  -->

	<%
	// Variables 
    int contador = 1;
	int limites = 12;
	int pagina = 2;
	
	
	//Form
	
	//String limiteParam = request.getParameter("limitesForm");
	String paginaParam = request.getParameter("pagina");
	//
	String formParam = request.getParameter("form");
	//String selectParam = request.getParameter("");
	String formularioParam = request.getParameter("limiteForm");
	
	//Paginacion 
	
	String paginacionPrev = request.getParameter("prevPage");
	String paginacionNext = request.getParameter("NextPage");
	
	//Limit 
	
	String limitParam = request.getParameter("limitSelect");
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);
	out.print("limiteParam : " + limitParam);
	//SQL 

	String nombreSQL = request.getParameter("Nombre");
	String precioSQL = request.getParameter("Precio");
	String imagenSQL = request.getParameter("Imagen");

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
	String pageQuery="";
	// ejecucamos consulta 
	resultado = estado.executeQuery(query);

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
	
	

	
	
	%>
	
	
	<br>
	
	<!--  limite seria como tener un filtro de elementos que se muestran en pantalla por eso no lo unimos con la paginacion s -->
	<div class ="limite">
	<form action="index2.jsp"  name="limitForm" method="POST">
		<p>limite :</p>
		<select name="limitSelect " id="nProductosVista">
			<option value=<%=selected3 %>>3</option>
			<option value=<%=selected6 %>>6</option>
			<option value=<%=selected9 %>>9</option>
			<option value=<%=selected12 %>>12</option>
		</select>
		<input type="submit" value="Mostrar" id="datos" >
		
		
	</form>
	<%	if (limitParam != null && !limitParam.trim().isEmpty()){
		limites = Integer.parseInt(limitParam);
		Mensajes.verMensaje("el valor de limite es  :" +limites);
		
	}else{
	Mensajes.verMensaje("el valor por ahora es " + limites);
	Mensajes.verMensaje("Parámetro limitSelect: " + limitParam);} %>
	</div>
	 	<br>
		<br>
		<!--  form para la Paginacion -->
		<div class="contenedor">
		<form action="index2.jps" name="pageform" method="POST">

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
				

		%>



</body>
</html>