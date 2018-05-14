

<%@page import="serviciosBD.lugar_servicio"%>
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
                <h3 class="bla blb">Reportes</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                
            </div>    
                
                
            <i class="fa fa-bar-chart" style="font-size:48px"></i>
            
            <form id="formGraficaFiltrada" action = "Servlet?controlador=graficaFiltrada" method = "post" >
            
                <input type="hidden" id="tipoGrafica" name="tipoGrafica" value="">
                
                <span >Fecha Inicio</span>
                <input type="date" name="fechaInicio"  id="fechaInicio"  class="col-md-3" >
                <span >Fecha Fin</span>
                <input type="date" name="fechaFin"  id="fechaFin"  class="col-md-3" >

                <hr>
                <!--span class="col-md-6">Lugar</span-->
                <!--select id="Lugar"  name="Lugar" class="form-control col-md-6" -->



                    <%
                        /* lugar_servicio lugar = new lugar_servicio();
                        String lugares[][]=lugar.listaLugares(); */

                        %>
                            <!--option value=""></option-->
                        <%
                        /* for (int i=0;i<lugares.length;i++){   */%>
                        <!--option value="<% //out.print(lugares[i][0]); %>"> <% //out.print(lugares[i][1]); %> </option-->
                    <% // }   %>


                <!--/select-->

            </form>
            
            <hr>
            
            <div class="tab-content">
                
                <input type="button" class="btn btn-md btn-success col-md-12"  value="Gasto Tortal Mensual" onclick="openGrafica()"/> <hr>
                <input type="button" class="btn btn-md col-md-12 "  value="Meses " onclick="openGraficaFiltrada(1)"/> <hr>
                <!--input type="button" class="btn btn-md col-md-12 "  value="Lugar" onclick="openGraficaFiltrada(2)"/> <hr-->
                <input type="button" class="btn btn-md col-md-12 "  value="Semana" onclick="openGraficaFiltrada(3)"/> <hr>
            </div>
        </div>
    </div>                         
</div>               
                                    
                                    
                                    
    
                        
                        
                        
                        
                

<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=listaPagosFijos';  
    }
    
    
    function openGrafica(){
       window.open("Servlet?controlador=graficaGeneral", "Grafica"); 
    }
    
    function openGraficaFiltrada(tipoGrafica){
        
        
        $('#tipoGrafica').val(  tipoGrafica  );
        
        
        
        var valido=1;
            
        var fechaInicio = document.getElementById("fechaInicio").value;

        if (fechaInicio == ''   ){
            valido=0;
            alert("Por favor llena la Fecha Incial");
        }
        
        var fechaFin = document.getElementById("fechaFin").value;

        if (fechaFin == '' ){
            valido=0;
            alert("Por favor llena la fecha Final");
        }
        
        
        /*
        var Lugar = document.getElementById("Lugar").value;

        if (Lugar == '' ){
            valido=0;
            alert("Por favor llena el Lugar");
        }
        */
      
        
        if (valido==1){
            document.getElementById("formGraficaFiltrada").submit();
        }
        
        
        
    }
    

</script>




        <jsp:include page="../pieDePagina.jsp" flush="true"/>