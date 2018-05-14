

<%@page import="java.text.DecimalFormat"%>
<%@page import="serviciosBD.usuario_servicio"%>
<%@page import="serviciosBD.pagos_fijos_servicio"%>
<%@page import="serviciosBD.catalogo_servicio"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="serviciosBD.persona_servicio"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviciosBD.operaciones_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>
<jsp:include page="../cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>



            <div class="bkz aav aaj">
                <h3 class="bla blb">Pagos fijos</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                
            </div>    
            <i class="fa fa-calendar" style="font-size:48px"></i>
                <a class="btn btn-md bla blb text-center" data-toggle="modal" href="#registroPago">Programar Pago <i class="fa fa-plus-square" ></i></a>
            <hr>
            
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">Pagos Planeados <i class="fa fa-calendar-check-o" style="font-size:24px"></i></a></li>&nbsp;
                <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Pagos Programados <i class="fa fa-clock-o" style="font-size:24px"></i></a></li>&nbsp;
            </ul>    
            
                
            <div class="tab-content">
                
                <div id="menu0" class="tab-pane fade in active">
                    <div class="bkz aav aaj">
                       <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Id</th>
                                    <th class="header">Fecha de Ultima de Pago</th>
                                    <th class="header">Titilo</th>
                                    <th class="header">Descripción</th>
                                    <th class="header">Periodo</th>
                                    <th class="header">Monto</th>
                                    <th class="header">Fecha de Cálculo</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    pagos_fijos_servicio pagoFijos = new pagos_fijos_servicio();
                                    
                                    String pagosFijos[][]=pagoFijos.listaPagosFijos();
                                    for (int i=0;i<pagosFijos.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+pagosFijos[i][0]+"</td>");
                                            out.println("<td>"+pagosFijos[i][1]+"</td>");
                                            out.println("<td>"+pagosFijos[i][2]+"</td>");
                                            out.println("<td>"+pagosFijos[i][3]+"</td>");
                                            out.println("<td>"+pagosFijos[i][4]+"</td>");
                                            out.println("<td>"+pagosFijos[i][5]+"</td>");
                                            out.println("<td>"+pagosFijos[i][6]+"</td>");
                                        %>
                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                 
                </div>
                
                <div id="menu1" class="tab-pane fade">
                    <div class="bkz aav aaj">
                       <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Titulo</th>
                                    <th class="header">Descripción</th>
                                    <th class="header">Monto</th>
                                    <th class="header">Cuenta</th>
                                    <th class="header">Fecha De Pago</th>
                                    <th class="header">Activo</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    pagoFijos = new pagos_fijos_servicio();
                                    
                                    pagosFijos=pagoFijos.listaPagosProgramados();
                                    for (int i=0;i<pagosFijos.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+pagosFijos[i][2]+"</td>");
                                            out.println("<td>"+pagosFijos[i][3]+"</td>");
                                            out.println("<td>"+pagosFijos[i][5]+"</td>");
                                            DecimalFormat formatea = new DecimalFormat("###,###.##");
                                            out.println("<td>"+"$ "+formatea.format(Float.parseFloat(requisiciones[i][7]))+" M.N.</td>");
                                            out.println("<td>"+pagosFijos[i][9]+"</td>");
                                            out.println("<td>"+pagosFijos[i][12]+"</td>");
                                            
                                        %>
                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                                    

            </div>  
        
        </div>

                                    
                                    
                                    
                                    
                                    
<div id="registroPago" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Crear Pago Fijo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formCrearPagoFijo" action = "Servlet?controlador=crearPagoFijo" method = "post" >
                <div class="modal-body">
                    
                    
                    <input type="hidden" name="idUsuario"  id="idUsuario" value="<%out.print(idUsuario);  %>" >
                    
                    <span class="col-md-12">Fecha último pago</span>
                    <input type="date" name="fechaUltimaPago"  id="fechaUltimaPago"  class="col-md-12" >
                    
                    
                    <span class="col-md-12">Titulo</span>
                    <input type="text" name="titulo"  id="titulo"  class="col-md-12" >
                            
                    <span class="col-md-12">Descripción</span>
                    <textarea rows="4" name="descripcion" id="descripcion"     cols="50"  class="col-md-12"  ></textarea>
                    
                    <span class="col-md-12">Periodo</span>
                    <div class="form-group col-md-6">

                         <% 
                            pagos_fijos_servicio periodo = new pagos_fijos_servicio();
                            String periodos[][]=periodo.listaPeriodos(); %>


                            <div class="form-group col-md-12">
                                <select class="form-control" id="periodo" name="periodo" >
                                    <option value=""></option>

                                    <% for (int i=0;i<periodos.length;i++){ %>
                                        <option value="<% out.print(periodos[i][0]); %>"><% out.print(periodos[i][1]); %></option>
                                    <% } %>
                                </select>
                            </div>
                    </div>
                                    
                    <span class="col-md-12">Monto</span>
                    <input type="text" name="Monto"  id="Monto"  class="col-md-12" >
                    
                    <span class="col-md-12">Cuenta</span>
                    <input type="text" name="Cuenta"  id="Cuenta"  class="col-md-12" >
                    
                    <span class="col-md-12">Fecha de cálculo</span>
                    <input type="date" name="fechaCalculoFinal"  id="fechaCalculoFinal"  class="col-md-12" >
                    
                    <span class="col-md-12">Avisos al:</span>
                    <select class="col-md-12" name="usuarios" id="usuarios"  multiple>
                        
                        <% 
                            usuario_servicio usuario = new usuario_servicio();
                            String usuarios[][]=usuario.getUsuarios();
                        %>
                        
                        <% for (int i=0;i<usuarios.length;i++){ %>
                            <option value="<% out.print(usuarios[i][0]); %>"><% out.print(usuarios[i][1]+" => "+usuarios[i][4]); %></option> 
                        <% } %>
                        
                        
                        
                    </select>
                    
            


                    
                    
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Crear" onclick="crearPagoFijo()"/>
                    
                </div>
            </form>
        </div>
    </div>
</div>

             
                        
                        
                        
                        
                        
                

<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=listaPagosFijos';  
    }
    
    function crearPagoFijo(){
        var valido=1;
            
        var fechaUltimaPago = document.getElementById("fechaUltimaPago").value;

        if (fechaUltimaPago == ''   ){
            valido=0;
            alert("Por favor llena la Fecha último pago");
        }
        
        var titulo = document.getElementById("titulo").value;

        if (titulo == '' ){
            valido=0;
            alert("Por favor llena el Titulo");
        }
        
        var descripcion = document.getElementById("descripcion").value;

        if (descripcion == '' ){
            valido=0;
            alert("Por favor llena la Descripción");
        }
        
        var periodo = document.getElementById("periodo").value;

        if (periodo == '' ){
            valido=0;
            alert("Por favor llena el Periodo");
        }
        
        var Monto = document.getElementById("Monto").value;

        if (Monto == '' ){
            valido=0;
            alert("Por favor llena el Periodo");
        }
        
        var fechaCalculoFinal = document.getElementById("fechaCalculoFinal").value;

        if (fechaCalculoFinal == ''   ){
            valido=0;
            alert("Por favor llena la Fecha de Cálculo");
        }
        
        var Cuenta = document.getElementById("Cuenta").value;

        if (Cuenta == ''   ){
            valido=0;
            alert("Por favor llena la Cuenta");
        }
        
        if (valido==1){
            document.getElementById("formCrearPagoFijo").submit();
        }
 
    }
    


</script>




        <jsp:include page="../pieDePagina.jsp" flush="true"/>