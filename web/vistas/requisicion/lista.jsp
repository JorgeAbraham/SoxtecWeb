



<%@page import="serviciosBD.operaciones_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>
<jsp:include page="../cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>



            <div class="bkz aav aaj">
                <h3 class="bla blb">Requerimientos</h3>
                
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
            </div>    
            <i class="fa fa-shopping-basket" style="font-size:48px"></i>
            <hr>
            
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">Ordenes de Compra <i class="fa fa-shopping-cart" style="font-size:24px"></i></a></li>&nbsp;
                <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Devolución de Pago <i class="fa fa-handshake-o" style="font-size:24px"></i></a></li>&nbsp;
                
            </ul>
                
            <div class="tab-content">
                
                <div id="menu0" class="tab-pane fade in active">
                    

                        <h6 class="atf">
                            <a href="<% out.println(host); %>Servlet?controlador=crearRequisicion" class="btn btn-md bla blb">Crear <i class="fa fa-plus" ></i></a>
                        </h6>
                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header text-center">Número de Operación</th>
                                    <th class="header text-center">Estado</th>
                                    <th class="header text-center">Fecha</th>
                                    <th class="header text-center">Descripción</th>
                                    <th class="header text-center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operaciones_servicio operacion = new operaciones_servicio();
                                    String requisiciones[][]=operacion.listaOperecionesPorUsuarioYTipoOperacion(idUsuario,"1","4");
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td  class=\"text-center\">"+requisiciones[i][0]+"</td>");
                                            out.println("<td  class=\"text-center\">"+requisiciones[i][1]+"</td>");
                                            out.println("<td  class=\"text-center\">"+requisiciones[i][2]+"</td>");
                                            out.println("<td  class=\"text-center\">"+requisiciones[i][3]+"</td>");
                                        
                                        %>



                                         <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=verRequisicion&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                </div> 
                
                
                <div id="menu1" class="tab-pane fade">
                    
                    

                        <h6 class="atf">
                            <a href="<% out.println(host); %>Servlet?controlador=crearPagoPendiente" class="btn btn-md bla blb">Crear <i class="fa fa-plus" ></i></a>
                        </h6>
                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header text-center">Número de Operación</th>
                                    <th class="header text-center">Estado</th>
                                    <th class="header text-center">Fecha</th>
                                    <th class="header text-center">Descripción</th>
                                    <th class="header text-center"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operacion = new operaciones_servicio();
                                    requisiciones = operacion.listaOperecionesPorUsuarioYTipoOperacion(idUsuario,"7","24");
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>

                                        <%
                                            out.println("<td class=\"header text-center\">"+requisiciones[i][0]+"</td>");
                                            out.println("<td class=\"header text-center\">"+requisiciones[i][1]+"</td>");
                                            out.println("<td class=\"header text-center\">"+requisiciones[i][2]+"</td>");
                                            out.println("<td class=\"header text-center\">"+requisiciones[i][3]+"</td>");
                                        
                                        %>


                                        <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=verRequisicionPagoPendiente&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>
                                         

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                    
                </div>
                                    
                
                                    

            </div>  
        
        </div>

<div id="docsModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Example modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <p>You're looking at an example modal in the dashboard theme.</p>
            </div>
            <div class="om">
                <button type="button" class="ce kh" data-dismiss="modal">Cool, got it!</button>
            </div>
        </div>
    </div>
</div>
                            
<script>
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=requisiciones';  
    } 
</script>                            


        <jsp:include page="../pieDePagina.jsp" flush="true"/>