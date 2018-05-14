

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
                <h3 class="bla blb">Catalogos o Cuentas</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                <% String idOperacion = request.getParameter("numeroOperacion");   %>
            </div>    
            <i class="fa fa-object-group" style="font-size:48px"></i>
            <a class="btn btn-md bla blb text-right" data-toggle="modal" href="#registroCatalogo">Crear Catalogo <i class="fa fa-plus-square" ></i></a>
            <hr>
            
                
            
                
            <div class="tab-content">
                
                
                    <div class="bkz aav aaj">
                        
                        
                       

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Id</th>
                                    <th class="header">Nombre</th>
                                    <th class="header">Descripcion</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    catalogo_servicio catalogo = new catalogo_servicio();
                                    
                                    String catalogos[][]=catalogo.listaCuentas();
                                    for (int i=0;i<catalogos.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+catalogos[i][0]+"</td>");
                                            out.println("<td class=\"text-left\">"+catalogos[i][1]+"</td>");
                                            out.println("<td>"+catalogos[i][2]+"</td>");
                                        %>
                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                 
                
                
                
                                    

            </div>  
        
        </div>

                                    
                                    
                                    
                                    
                                    
<div id="registroCatalogo" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Crear Catalogo o Cuenta</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formCrearCatalogoCuenta" action = "Servlet?controlador=crearCatalogo" method = "post" >
                <div class="modal-body">
                    
                    <span class="col-md-12">Nombre</span>
                    <input type="text" name="NombreCuenta"  id="NombreCuenta"  class="col-md-12" >
                    
                    <span class="col-md-12">Descripción</span>
                    <textarea rows="4" name="DescrpcionCuenta" id="DescrpcionCuenta"     cols="50"  class="col-md-12"  ></textarea>
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Crear" onclick="crearCatalogo()"/>
                    
                </div>
            </form>
        </div>
    </div>
</div>

             
                        
                        
                        
                        
                        
                

<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=listaCatalogo';  
    }
    
    function crearCatalogo(){
        var valido=1;
            
        var Nombre = document.getElementById("NombreCuenta").value;

        if (Nombre == '' ){
            valido=0;
            alert("Por favor llena el Nombre");
        }
        
        var ApellidoMaterno = document.getElementById("DescrpcionCuenta").value;

        if (ApellidoMaterno == '' ){
            valido=0;
            alert("Por favor llena el Descripción Cuenta");
        }
        
        if (valido==1){
            document.getElementById("formCrearCatalogoCuenta").submit();
        }
 
    }
    


</script>




        <jsp:include page="../pieDePagina.jsp" flush="true"/>