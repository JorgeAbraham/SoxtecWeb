



<%@page import="serviciosBD.lugar_servicio"%>
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
                <h3 class="bla blb">Revisión</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
            </div>    
            
            
            
            
            <i class="fa fa-car" style="font-size:48px"></i>
            
            <a class="btn btn-md bla blb text-right" data-toggle="modal" href="#registroAuto">Crear Registro Automitriz <i class="fa fa-plus-square" ></i></a>
            
            
            <hr>
                
            
                    <div class="bkz aav aaj">

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Número de Registro</th>
                                    <th class="header">Estado</th>
                                    <th class="header">Fecha</th>
                                    <th class="header">Marca</th>
                                    <th class="header"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operaciones_servicio operacion = new operaciones_servicio();
                                    
                                    ArrayList<String> tipoOperacion=new ArrayList();
                                    tipoOperacion.add("12");
                                    
                                    ArrayList<String> estadosOperacion=new ArrayList();
                                    estadosOperacion.add("17");
                                    estadosOperacion.add("18");
                                    
                                    String requisiciones[][]=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"41",estadosOperacion);
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            out.println("<td>"+requisiciones[i][3]+"</td>");
                                        %>
                                        
                                        
                                        
                                        <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=verAutomovil&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>
                                        
                                            

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                
                
                
                      

            </div>  
        
        </div>

           
                                    
                                    
                                    
                                    
<div id="registroAuto" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Registro Automovil</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formRegistroAutomovil" action = "Servlet?controlador=registroAutomovil" method = "post"  enctype = "multipart/form-data" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionAplicacion" name="idOperacionAplicacion" >
                    
                    
                    <%
                        
                        operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("12");

                        String plantillaDeTexto="";
                        String idLista="";


                        String fragmentoTabla0="<table  id=\"tabla";
                        String fragmentoTabla1="\"  class=\"table\" class=\"col-md-12\" >"+
                                                    "<thead>"+
                                                "<tr>";
                        String cabeceras=""; 

                        String fragmentoTabla2="</tr>"+
                                                    "</thead>"+
                                                        "<tbody>";

                        String valores=""; 
                        String fragmentoTabla3=
                                                        "</tbody>"+
                                                    "</table>";

                        out.println("<div class=\"row\">");

                        out.println("<div class=\"col-md-12\">"); 



                        for (int i=0;i<requisicionesForm.length;i++){


                            idLista=requisicionesForm[i][2];


                            if (  requisicionesForm[i][2]==null  ){  //No es una Lista

                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTexto)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\"  id=\""+requisicionesForm[i][4]+"\"  class=\"col-md-12\" >";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoArchivo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"file\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\" class=\"col-md-12\"  >";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoNumero)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-12\"  onkeyup=\"formatoNumerico(event);\"  >";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoFecha)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"date\" name=\""+requisicionesForm[i][4]+"\"   id=\""+requisicionesForm[i][4]+"\"        class=\"col-md-12\"    value=\""+ (new SimpleDateFormat("yyyy-MM-dd").format(fechaActual))  +"\"     >";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTextoLargo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<textarea rows=\"4\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"     cols=\"50\"  class=\"col-md-12\"  ></textarea>";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.catalogo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-12\">"+requisicionesForm[i][1]+ "</span>";

                                    
                                    
                                    if (requisicionesForm[i][4].equals("NombreAuto")){
                                          
                                        persona_servicio empleados = new persona_servicio();
                                        String empleado[][]=empleados.LISTAempleadosEstadoActivoString(empleados.ALTA);
                                        String usuarios[][]=empleados.LISTAUsuarioString();
                                        
                                        
                                        String opciones="";
                                  
                                        for (int j=0;j<usuarios.length;j++){
                                            opciones = opciones + "<option value=\"" + usuarios[j][1] + "\">" + usuarios[j][0] + "</option>";
                                        }
                                        
                                        for (int j=0;j<empleado.length;j++){
                                            opciones = opciones + "<option value=\"" + empleado[j][1] + "\">" + empleado[j][0] + "</option>";
                                        }
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group\">"+
                                                                                "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                                                    "<option value=\"\">Selecciona...</option>"+
                                                                                    opciones+
                                                                                "</select>"+
                                                                            "</div>";

                                    }
                                    
                                    if (requisicionesForm[i][4].equals("LugarAuto")){
                                             
                                         
                                        plantillaDeTexto=plantillaDeTexto+"<select id=\""+requisicionesForm[i][4]+"\"  name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">";

                                        lugar_servicio L = new lugar_servicio();
                                        String lugares[][]=L.listaLugares();  
                                        
                                        plantillaDeTexto=plantillaDeTexto+"<option value=\"\">Selecciona...</option>";
                                        for (int j=0;j<lugares.length;j++){  
                                            plantillaDeTexto=plantillaDeTexto+"<option value=\""+lugares[j][0]+"\">"+lugares[j][1]+"</option>";
                                        }
                                        plantillaDeTexto=plantillaDeTexto+"</select>";

                                    }




                                }

                            }
                            else{ //Listas

                                plantillaDeTexto=plantillaDeTexto+fragmentoTabla0+requisicionesForm[i][2];
                                plantillaDeTexto=plantillaDeTexto+fragmentoTabla1;
                                for (int j=0;j<requisicionesForm.length;j++){
                                    if (  requisicionesForm[j][2]!=null  &&   requisicionesForm[j][2].equals(idLista)){
                                        cabeceras=cabeceras+"<th>"+requisicionesForm[j][1]+"</th>";
                                        i=j;
                                    }
                                }
                                plantillaDeTexto=plantillaDeTexto+cabeceras;
                                cabeceras=cabeceras+"";
                                plantillaDeTexto=plantillaDeTexto+fragmentoTabla2;
                                for (int j=0;j<requisicionesForm.length;j++){
                                    if (  requisicionesForm[j][2]!=null  &&   requisicionesForm[j][2].equals(idLista)){
                                        valores=valores+"<td>";



                                            if (requisicionesForm[j][3].equals(operaciones_servicio.tipoTexto)){
                                                valores=valores+"<input type=\"text\" name=\""+requisicionesForm[j][4]+"[]\" id=\""+requisicionesForm[j][4]+"_1\" class=\"col-md-12\" onkeyup=\"calcularTotales(event);\"  >";
                                            }
                                            if (requisicionesForm[j][3].equals(operaciones_servicio.tipoArchivo)){
                                                valores=valores+"<input type=\"file\" name=\""+requisicionesForm[j][4]+"[]\" id=\""+requisicionesForm[j][4]+"_1\" class=\"col-md-12\"  onkeyup=\"calcularTotales(event);\"   >";
                                            }
                                            if (requisicionesForm[j][3].equals(operaciones_servicio.tipoNumero)){
                                                valores=valores+"<input type=\"text\" name=\""+requisicionesForm[j][4]+"[]\"  id=\""+requisicionesForm[j][4]+"_1\"   class=\"col-md-12\"  onkeyup=\"calcularTotales(event);\"  >";
                                            }
                                            if (requisicionesForm[j][3].equals(operaciones_servicio.tipoFecha)){
                                                valores=valores+"<input type=\"date\" name=\""+requisicionesForm[j][4]+"[]\"  id=\""+requisicionesForm[j][4]+"_1\"   class=\"col-md-12\"  onkeyup=\"calcularTotales(event);\"    >";
                                            }
                                            if (requisicionesForm[j][3].equals(operaciones_servicio.tipoTextoLargo)){
                                                valores=valores+"<textarea rows=\"4\" cols=\"50\" name=\""+requisicionesForm[j][4]+"[]\"  id=\""+requisicionesForm[j][4]+"_1\"   class=\"col-md-12\"   onkeyup=\"calcularTotales(event);\"    ></textarea>";
                                            }
                                        valores=valores+"</td>";
                                        i=j;
                                    }

                                }

                                plantillaDeTexto=plantillaDeTexto+valores;

                                valores=valores+"";
                                plantillaDeTexto=plantillaDeTexto+fragmentoTabla3;
                                plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"agregaFila("+requisicionesForm[i][2]+");\" >Agregar (+) </a>";
                                plantillaDeTexto=plantillaDeTexto+"<div class=\"col-md-8\"></div>";
                                plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2  btn btn-white btn-md bla blb \" onclick=\"eliminaFila("+requisicionesForm[i][2]+");\" >Eliminar (-)</a>";

                            }


                        }

                        plantillaDeTexto=plantillaDeTexto+"</div>";
                        plantillaDeTexto=plantillaDeTexto+"</div>";
                        out.print(plantillaDeTexto);

                        %>
                           
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Aplicar" onclick="validacion()"/>
                    
                </div>
            </form>
        </div>
    </div>
</div>

                                    
                                    
                                    
                                    
<script>
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=verExpedienteAutos';  
    } 
    
    
    
    function validacion(){
        
        
        var valido=1;
            
        var NombreAuto = document.getElementById("NombreAuto").value;

        if (NombreAuto == ''   ){
            valido=0;
            alert("Por favor llena la Nombre del Asignado");
        }
        
        var DescripcioDeAuto = document.getElementById("DescripcioDeAuto").value;

        if (DescripcioDeAuto == '' ){
            valido=0;
            alert("Por favor llena el Descripcion del Auto");
        }
        
        var MarcaAuto = document.getElementById("MarcaAuto").value;

        if (MarcaAuto == '' ){
            valido=0;
            alert("Por favor llena la Marca del Auto");
        }
        
        var SubmarcaAuto = document.getElementById("SubmarcaAuto").value;

        if (SubmarcaAuto == '' ){
            valido=0;
            alert("Por favor llena la Submarca");
        }
        
        var AnioAuto = document.getElementById("AnioAuto").value;

        if (AnioAuto == '' ){
            valido=0;
            alert("Por favor llena el Año del Auto");
        }
        
        var PlacasAuto = document.getElementById("PlacasAuto").value;

        if (PlacasAuto == ''   ){
            valido=0;
            alert("Por favor llena la Placas del Auto");
        }
        
        var SerieMotorAuto = document.getElementById("SerieMotorAuto").value;

        if (SerieMotorAuto == ''   ){
            valido=0;
            alert("Por favor llena la serie del Motor");
        }
        
        var AseguradoraAuto = document.getElementById("AseguradoraAuto").value;

        if (AseguradoraAuto == ''   ){
            valido=0;
            alert("Por favor llena la aseguradora");
        }
        
         var NumeroPolizaAuto = document.getElementById("NumeroPolizaAuto").value;

        if (NumeroPolizaAuto == ''   ){
            valido=0;
            alert("Por favor llena el numero de Poliza");
        }
        
        
        var LugarAuto = document.getElementById("LugarAuto").value;

        if (LugarAuto == ''   ){
            valido=0;
            alert("Por favor llena el Lugar Automovil");
        }
        
        var DepartamentoAuto = document.getElementById("DepartamentoAuto").value;

        if (DepartamentoAuto == ''   ){
            valido=0;
            alert("Por favor llena el Dapartamento");
        }
        
        
        var VigenciaAuto = document.getElementById("VigenciaAuto").value;

        if (VigenciaAuto == ''   ){
            valido=0;
            alert("Por favor llena la vigencia del la poliza");
        }
        
        
        var ObservacionesAuto = document.getElementById("ObservacionesAuto").value;

        if (ObservacionesAuto == ''   ){
            valido=0;
            alert("Por favor llena las Pbservaciones del Automivil");
        }
        
        
        if (valido==1){
            document.getElementById("formRegistroAutomovil").submit();
        }
 
    }
    
    
    
    
    
</script>                            


<jsp:include page="../pieDePagina.jsp" flush="true"/>                                                           