
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="utilidadesWeb.utilidadWeb" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="../../../../favicon.ico">

        <title>Soxtec IntraNET</title>

        <!-- Bootstrap core CSS -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="assets/css/signin.css" rel="stylesheet">
        <script src="assets/js/jquery.min.js"></script>
        
        <style>
        body {
            background-color: #F0F0F0;
            background-image: url(imagenes/world.png) ;
            height: 100%;
            /* Center and scale the image nicely */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            position: relative;
            overflow: hidden;
        }
        </style>

       
        
    </head>

    <body style="color:">

        
        
        <div class="container">
          
            
        </div>
        
        <div class="container">

            <form class="form-signin" id="form1">
                  <img src="imagenes/logoSox.png"  width="300" height="80">
                <h2 class="form-signin-heading text-center">Soxtec Connecting</h2>
                <label for="inputEmail" class="sr-only">Usuario</label>
                <input type="email" id="inputEmail" class="form-control" placeholder="User Name" required autofocus>
                <label for="inputPassword" class="sr-only">Contraseña</label>
                <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
                <div class="checkbox">
                    <label>
                        <input type="checkbox"  value="remember-me"> Remember me
                    </label>
                </div>
                <input type="button" id="submit" class="btn btn-lg btn-primary btn-block" value="Sign in" /> 
              
                <p class="text-right">IntraNET.</p>
             
            </form>

        </div> <!-- /container -->
    </body>
</html>


   


 <%  out.println ( utilidadWeb.printAjaxCodeAbrirUbicacion("submit", "accesoPantallaContrasenia",  new String[]{"inputEmail","inputPassword"} )   );      %>







