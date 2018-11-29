



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
                <h3 class="bla blb">Revisión</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
            </div>    
            <i class="fa fa-thumbs-up" style="font-size:48px"></i>
            <hr>
                
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">Ordenes de Compra <i class="fa fa-shopping-cart" style="font-size:24px"></i></a></li>&nbsp;
                <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Devolución de Pago <i class="fa fa-handshake-o" style="font-size:24px"></i></a></li>&nbsp;
            </ul>
                
            <div class="tab-content">
                
                <div id="menu0" class="tab-pane fade in active">
                    <div class="bkz aav aaj">

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Número de Operación</th>
                                    <th class="header">Estado</th>
                                    <th class="header">Fecha</th>
                                    <th class="header">Descripción</th>
                                    <th class="header">Nombre</th>
                                    <th class="header"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operaciones_servicio operacion = new operaciones_servicio();
                                    
                                    ArrayList<String> tipoOperacion=new ArrayList();
                                    tipoOperacion.add("1");
                                    
                                    ArrayList<String> estadosOperacion=new ArrayList();
                                    estadosOperacion.add("1");
                                    estadosOperacion.add("2");
                                    estadosOperacion.add("6");
                                    
                                    
                                    String requisiciones[][]=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"4",estadosOperacion);
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            out.println("<td>"+requisiciones[i][3]+"</td>");
                                            out.println("<td>"+requisiciones[i][4]+" "+requisiciones[i][5]+" "+requisiciones[i][6]+"</td>");
                                        %>
                                        
                                        
                                        
                                        <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=revisionOrdenPago&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Revisar <i class="fa fa-search" ></i></a></td>
                                        
                                            

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
                                    <th class="header">Número de Operación</th>
                                    <th class="header">Estado</th>
                                    <th class="header">Fecha</th>
                                    <th class="header">Descripción</th>
                                    <th class="header">Nombre</th>
                                    <th class="header"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operacion = new operaciones_servicio();
                                    
                                    tipoOperacion=new ArrayList();
                                    tipoOperacion.add("7");
                                    
                                    estadosOperacion=new ArrayList();
                                    estadosOperacion.add("1");
                                    estadosOperacion.add("2");
                                  
                                    
                                    
                                    
                                    requisiciones=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"24",estadosOperacion);
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            out.println("<td>"+requisiciones[i][3]+"</td>");
                                            out.println("<td>"+requisiciones[i][4]+" "+requisiciones[i][5]+" "+requisiciones[i][6]+"</td>");
                                        %>
                                        
                                        
                                        
                                        <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=revisarPagoPendiente&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Revisar <i class="fa fa-search" ></i></a></td>
                                        
                                            

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    
                    
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
        window.location='Servlet?controlador=revisionOrdenesPago';  
    }                                         
</script>

        <jsp:include page="../pieDePagina.jsp" flush="true"/>