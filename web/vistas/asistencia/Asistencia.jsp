
<%@page import="serviciosBD.asistencia_servicio"%>
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
                <h3 class="bla blb">Asistencia</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                <% String idLugar = request.getParameter("idLugar");   %>
            </div>    
            
            <hr>
            
                
            
                
            <div class="tab-content">
                
                
                    <div class="bkz aav aaj">
                        
                        
                       

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Fecha</th>
                                    <th class="header">Hora</th>
                                    <th class="header">Apellido Paterno</th>
                                    <th class="header">Apellido Materno</th>
                                    <th class="header">Nombre</th>
                                    <th class="header">Lugar</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    asistencia_servicio checadas = new asistencia_servicio();
                                    
                                    String catalogos[][]=checadas.listaChecadas();
                                    for (int i=0;i<catalogos.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+catalogos[i][0]+"</td>");
                                            out.println("<td>"+catalogos[i][1]+"</td>");
                                            out.println("<td>"+catalogos[i][2]+"</td>");
                                            out.println("<td>"+catalogos[i][3]+"</td>");
                                            out.println("<td>"+catalogos[i][4]+"</td>");
                                            out.println("<td>"+catalogos[i][5]+"</td>");
                                         
                                            
                                            
                                        %>
                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
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