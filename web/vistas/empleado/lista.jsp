


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="serviciosBD.usuario_servicio"%>
<%@page import="serviciosBD.lugar_servicio"%>
<%@page import="serviciosBD.persona_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>
<jsp:include page="../cabecera.jsp" flush="true"/>




<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>



            <div class="bkz aav aaj">
                <h3 class="bla blb">Personal</h3>
                
            </div>    
            
            
            <% String buscar = request.getParameter("buscar");  %>
            <% String nombreFiltro = request.getParameter("nombreFiltro");   %>
            <% String LugarFiltro = request.getParameter("LugarFiltro");     %>
            
            <% if (buscar == null){
                buscar=nombreFiltro;
            }%>
            
            

            <div class="row">
                <i class="fa fa-address-book" style="font-size:48px;"></i>
                <hr>
            </div>
           
            <div class="row">
                <div class="col-md-3">
                    <a class="btn btn-md bla blb text-right" data-toggle="modal" href="#registroEmpleado">Crear Empleado <i class="fa fa-user-plus" ></i></a>
                </div>
                
                
                    
                        <div class="col-md-6">
                            
                            
                            <form id="formFiltrar" action = "Servlet?controlador=empleadosInformacion" method = "post" >
                                <select id="LugarFiltro"  name="LugarFiltro" class="form-control col-md-12" >
                                    <%
                                        lugar_servicio LUGAR = new lugar_servicio();
                                        String LUGARES[][]=LUGAR.listaLugares();

                                        %>
                                            <option value=""></option>
                                        <%
                                        for (int i=0;i<LUGARES.length;i++){  %>
                                        <option value="<% out.print(LUGARES[i][0]); %>"> <% out.print(LUGARES[i][1]); %> </option>
                                    <%  } %>
                                </select>
                                <input type="hidden" id="nombreFiltro" name="nombreFiltro" value="">
                            </form>
                        </div>
                        <div class="col-md-3">
                            <a class="btn btn-md bla blb text-right"  href="#"  onclick="filtrar();">Filtrar <i class="fa fa-filter" ></i></a>
                        </div>
            </div>
            
                        
            
            <% 
                persona_servicio empleado;
                String empleados[][];
            %>
            
            <div class="bkz aav aaj">
          
                <ul class="nav nav-tabs">
                    
                    
                       
                       <li class="active"><a class="btn btn-success bla blb" data-toggle="tab" href="#menu0">Activos <i class="fa fa-arrow-circle-o-up" ></i></a></li>&nbsp
                       <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Bajas <i class="fa fa-arrow-circle-down" ></i></a></li>&nbsp;
                       <li><a class="btn btn-warning btn-md bla blb" data-toggle="tab" href="#menu4">Sol. de Baja <i class="fa fa-exclamation-circle" ></i></a></li>&nbsp;
                       <li><a class="btn btn-primary btn-md bla blb" data-toggle="tab" href="#menu2">Sin definir <i class="fa fa-question" ></i></a></li>&nbsp;
                       <li><a class="btn btn-md btn-md bla blb" data-toggle="tab" href="#menu5">Paro Tecnico <i class="fa fa-pause-circle" ></i></a></li>&nbsp;
                       <!--li><a class="btn btn-outline-primary btn-md bla blb" data-toggle="tab" href="#menu5">Ingresado <i class="fa fa-caret-square-o-right" ></i></a></li-->&nbsp;
                       <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu3">Todos <i class="fa fa-group" ></i></a></li>&nbsp;
                       
                </ul>
                
                <div class="tab-content">
               
                    
                    
                    
                    
                    

                    <div id="menu0" class="tab-pane fade in active">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre</th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Lugar</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.LISTAempleadosEstadoActivoString(empleado.ALTA,buscar,LugarFiltro);
                                                                       
                                        
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                            
                                        
                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>      

                                    
                    <div id="menu1" class="tab-pane fade">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre </th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Lugar</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.LISTAempleadosEstadoActivoString(empleado.BAJA,buscar,LugarFiltro);
                                    
                                    
                                    
                                 
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                    </div>   
                                    
                                    
                    
                                    
                    <div id="menu2" class="tab-pane fade">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre </th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Antigüedad</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    
                                   
                                    empleados=empleado.LISTAempleadosEstadoSinAsignar(buscar,LugarFiltro);
                                   
                                    
                                    
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            
                                            String sDate1=empleados[i][5];  
                                            Date date1=new SimpleDateFormat("dd/MM/yyyy").parse(sDate1); 
                                            Date fechaActual=new Date();
                                            
                                            
                                            int dias=(int) ((fechaActual.getTime()-date1.getTime())/86400000);
                                            
                                            String color="";
                                            if (dias>90){
                                                color="bgcolor= \"#FFFF00\"";
                                            }
                                            
                                            out.println("<td "+color+"class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td "+color+">"+empleados[i][1]+"</td>");
                                            out.println("<td "+color+">"+empleados[i][4]+"</td>");
                                            out.println("<td "+color+">"+empleados[i][5]+"</td>");
                                            


                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                    </div>
                                    
                                    
                    <div id="menu3" class="tab-pane fade ">

                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre</th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    
                                    empleado = new persona_servicio();
                                    empleados=empleado.LISTAempleadosString(buscar,LugarFiltro);
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%for (int j=0;j<empleados[0].length;j++){
                                            out.println("<td class=\"text-left\">"+empleados[i][j]+"</td>");
                                        }
                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>

                    </div>
                                    
                                    
                                    
                    <div id="menu4" class="tab-pane fade">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre</th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Lugar</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.LISTAempleadosEstadoActivoString(empleado.SOLICITUD_BAJA,buscar,LugarFiltro);
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                    </div> 
                                    
                    <div id="menu5" class="tab-pane fade">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre</th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Lugar</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.LISTAempleadosEstadoActivoString(empleado.PARO_TECNICO,buscar,LugarFiltro);
                                   
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                        %>

                                         <% String host=application.getInitParameter("host");  %>

                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=empleadosPerfil&empleadoId=<% out.println(empleados[i][1]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                    </div>                
                                    
                    
                
                </div>
            </div>
           

   

            <hr class="aav">

                
                
            </div>

            <div class="dh bmk">
                <div class="et bmj">

                </div>
            </div>
    </div>
</div>
                                    

<div id="registroEmpleado" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Crear Empleado</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <form id="formCrearEmpleado" action = "Servlet?controlador=crearEmpleado" method = "post" >
                <div class="modal-body">
                    <span class="col-md-12">Apellido Paterno</span>
                    <input type="text" name="ApellidoPaterno" id="ApellidoPaterno" class="col-md-12"   >
                    
                    <span class="col-md-12">Apellido Materno</span>
                    <input type="text" name="ApellidoMaterno" id="ApellidoMaterno" class="col-md-12"   >
                    
                    <span class="col-md-12">Nombre</span>
                    <input type="text" name="Nombre" id="Nombre" class="col-md-12"   >
                    
                    
                    <span class="col-md-12">Lugar</span>
                    <select id="Lugar"  name="Lugar" class="form-control" onchange="modificarPropietario()">

                        <%
                            lugar_servicio lugar = new lugar_servicio();
                            String lugares[][]=lugar.listaLugares();
                            
                            %>
                                <option value=""></option>
                            <%
                            for (int i=0;i<lugares.length;i++){  %>
                            <option value="<% out.print(lugares[i][0]); %>"> <% out.print(lugares[i][1]); %> </option>
                        <%  } %>


                    </select>
                    
                    
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Crear" onclick="crearEmpleado()"/>
                </div>
            </form>
        </div>
    </div>
</div>
                            
                 
<script>
    
    
    
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=empleadosInformacion';  
    }
    
    var input = document.getElementById("buscar");
    input.addEventListener("keyup", function(event) {
        event.preventDefault();
        if (event.keyCode === 13) {
            
            var FORM=document.getElementById("buscarParametro");
            FORM.setAttribute("action", "Servlet?controlador=empleadosInformacion");
            document.getElementById("buscarParametro").submit();
           
        }
    });
    
    function filtrar(){
        var value = $("#buscar").val();
        $("#nombreFiltro").val(value);
        document.getElementById("formFiltrar").submit();
    }
    
    function crearEmpleado(){
         
        var valido=1;
        
        var ApellidoPaterno = document.getElementById("ApellidoPaterno").value;

        if (ApellidoPaterno == '' ){
            valido=0;
            alert("Por favor llena el Apellido Paterno");
        }
        
        var ApellidoMaterno = document.getElementById("ApellidoMaterno").value;

        if (ApellidoMaterno == '' ){
            valido=0;
            alert("Por favor llena el Apellido Materno");
        }
            
        var Nombre = document.getElementById("Nombre").value;

        if (Nombre == '' ){
            valido=0;
            alert("Por favor llena el Nombre");
        }
        
        var Lugar = document.getElementById("Lugar").value;

        if (Lugar == '' ){
            valido=0;
            alert("Por favor llena el Lugar");
        }
        
        if (valido==1){
            document.getElementById("formCrearEmpleado").submit();
        }
        
    }
    
    
    
    
</script>
                              


        <jsp:include page="../pieDePagina.jsp" flush="true"/>