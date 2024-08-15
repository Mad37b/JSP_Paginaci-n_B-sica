<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <%@ page import="clases.conexion"%>
    <%@ page import="clases.Consulta"%>
    <%@ page import="clases.Mensajes"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<!--  Me conecto a la base de datos -->

<% conexion conexionjsp = new conexion ();


%>

<!--  hago la consulta desde una clase java  -->

<% 
String limiteParam = request.getParameter("limites");
Consulta consultasjsp = new Consulta ();  

int limite = 1;
int pagina = 1; // Puedes ajustar esto según tus necesidades.
String resultadoConsulta = consultasjsp.paginacion(limite, pagina);
%>

<% Mensajes mensajejsp = new Mensajes (); %>
<h1> Paginacion basica</h1>
<%

String mensaje = " "; 




%>
<br> 
<form action= "" name="limit">
<p> limite : </p>
<input type="submit" value="Mostrar" id="datos" method="post">
			<select name="limiteForm" id="nProductosVista">
						<option value="3">3</option>
						<option value="6">6</option>
						<option value="9">9</option>
						<option value="12">12</option>
					</select>
<% Mensajes.verMensaje("la consulta ha sido"+ resultadoConsulta); %>



<% String formulario = request.getParameter("limiteForm"); %>
</form>

</body>
</html>