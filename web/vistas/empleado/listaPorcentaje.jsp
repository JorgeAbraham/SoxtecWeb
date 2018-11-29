


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
            
            
            <i class="fa fa-percent" style="font-size:48px;"></i>
            <input type="button" class="btn btn-md bla blb text-right"  value="Generar Reporte de Información Faltante " onclick="openGrafica()"/> <hr>
          
            
            
            <% 
                persona_servicio empleado;
                String empleados[][];
            %>
            
            <div class="bkz aav aaj">
          
                <ul class="nav nav-tabs">
                       
                       <li class="active"><a class="btn btn-success bla blb" data-toggle="tab" href="#menu0">Información <i class="fa fa-arrow-circle-o-up" ></i></a></li>&nbsp
                       <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Documentos <i class="fa fa-arrow-circle-down" ></i></a></li>&nbsp;
                       
                </ul>
                
                <div class="tab-content">
               
                    
                    
                    
                    
                    

                    <div id="menu0" class="tab-pane fade in active">
                        <table class="ck" data-sort="table">
                            <thead>
                                <tr>
                                    <th class="header">Nombre</th>
                                    <th class="header">Numero de Empleado</th>
                                    <th class="header">Lugar</th>
                                    <th class="header">Información</th>
                                    <th class="header">Información Faltante</th>
                                    <th class="header">Porcentaje</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.porcentajeRequisitosLlenos("1");
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][2]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                            out.println("<td>"+empleados[i][5]+"</td>");
                                            out.println("<td>"+empleados[i][6]+"</td>");
                                            out.println("<td>"+empleados[i][7]+"</td>");
                                            
                                        
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
                                    <th class="header">Información</th>
                                    <th class="header">Información Faltante</th>
                                    <th class="header">Porcentaje</th>
                                    <th class="header">Ver</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    empleado = new persona_servicio();
                                    
                                    empleados=empleado.porcentajeRequisitosLlenos("2");
                                    for (int i=0;i<empleados.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"text-left\">"+empleados[i][0]+"</td>");
                                            out.println("<td>"+empleados[i][1]+"</td>");
                                            out.println("<td>"+empleados[i][2]+"</td>");
                                            out.println("<td>"+empleados[i][4]+"</td>");
                                            out.println("<td>"+empleados[i][5]+"</td>");
                                            out.println("<td>"+empleados[i][6]+"</td>");
                                            out.println("<td>"+empleados[i][7]+"</td>");
                                            
                                            
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
                                    
                 
                 
<script>
    
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=empleadosInformacion';  
    }
    
    
    function openGrafica(){
       window.open("Servlet?controlador=reporteInformacionFaltante", "Grafica"); 
    }
    
   
    
    
    
</script>
                              


        <jsp:include page="../pieDePagina.jsp" flush="true"/>