

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
                <h3 class="bla blb">Formatos</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
            </div>    
            <i class="fa fa-wpforms" style="font-size:48px"></i>
            <hr>
                
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">GA Core</a></li>&nbsp;
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu1">GA Sec</a></li>&nbsp;
            </ul>
                
            <div class="tab-content">
                
                <div id="menu0" class="tab-pane fade in active">
                    <div class="bkz aav aaj">

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Formato</th>
                                    <th class="header">Descripción</th>
                                    <th class="header"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operaciones_servicio operacion = new operaciones_servicio();
                                    
                                    ArrayList<String> idCatalogoOperacion=new ArrayList();
                                    idCatalogoOperacion.add("14");
                                    idCatalogoOperacion.add("15");
                                    
                                    
                                    String requisiciones[][]=operacion.getCatalogosOperaciones(idCatalogoOperacion);
                                    
                                    
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            
                                        %>
                                        
                                        
                                        <%  if (requisiciones[i][0].equals("14")) { %>
                                        
                                        
                                            <td class="bv aaj"> <input type="button" class="btn btn-md bla blb"  value="Generar Reporte" onclick="abrirReporte()"/> </td>
                                        <%  } %>
                                            
                                        <%  if (requisiciones[i][0].equals("15")) { %>
                                            <td class="bv aaj"> 
                                                
                                                
                                                <form id="fechaIncial" action="Servlet?controlador=formatoRevisionPuertasFecha" method = "post" target="_blank" >
                        
                                                    <input type="date" name="fechaIncial"  id="fechaIncial"   >
                                                    <input type="date" name="fechaFinal"  id="fechaFinal"   >
                                                    <input type="time" name="horaIncial"  id="horaIncial"  value="00:00:00" max="23:59:00" min="00:00:00" >
                                                    <input type="time" name="horaFinal"  id="horaFinal"  value="23:59:00" max="23:59:00" min="00:00:00" >
                                                    

                                                    <input type="submit" class="btn btn-white btn-md bla blb" name="submitValue" id="submitValue" value="Generar Reporte" />
                                                    
                                                </form>
                                                    
                                            </td>
                                        <%  } %>
                                            

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                </div> 
                
                <div id="menu1" class="tab-pane fade in active">
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
    
    function abrirReporte(){
       window.open("Servlet?controlador=reportesFormatosPuertasHoy", "Reporte"); 
    }
    
    
    
    
</script>

<jsp:include page="../pieDePagina.jsp" flush="true"/>