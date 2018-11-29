

<%@page import="serviciosBD.catalogo_servicio"%>
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
                <h3 class="bla blb">Equipo de Computo</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
            </div>    
            
            
            
            
            <i class="fa fa-laptop" style="font-size:48px"></i>
            
            <a class="btn btn-md bla blb text-right" data-toggle="modal" href="#registroAuto">Crear Registro De Equipo de Computo <i class="fa fa-plus-square" ></i></a>
            
            
            <hr>
                
            
                    <div class="bkz aav aaj">

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Número de Registro</th>
                                    <th class="header">Estado</th>
                                    <th class="header">Fecha</th>
                                    <th class="header">Usuario</th>
                                    <th class="header"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 

                                    operaciones_servicio operacion = new operaciones_servicio();
                                    
                                    ArrayList<String> tipoOperacion=new ArrayList();
                                    tipoOperacion.add("19");
                                    
                                    ArrayList<String> estadosOperacion=new ArrayList();
                                    estadosOperacion.add("17");
                                    estadosOperacion.add("18");
                                    estadosOperacion.add("21");
                                    
                                    
                                    ArrayList<String> idConcepto=new ArrayList();
                                    idConcepto.add("82");
                                    idConcepto.add("83");
                                    idConcepto.add("84");
                                    idConcepto.add("85");
                                    idConcepto.add("86");
                                    idConcepto.add("87");
                                    idConcepto.add("94");
                                    
                                    String requisiciones[][]=operacion.listaOperacionesConcatenadas(idConcepto,estadosOperacion,tipoOperacion);



                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        <%
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            out.println("<td>"+requisiciones[i][3]+"</td>");
                                            out.println("<td>"+requisiciones[i][4]+"</td>");
                                            out.println("<td>"+requisiciones[i][5]+"</td>");
                                            out.println("<td>"+requisiciones[i][6]+"</td>");
                                            out.println("<td>"+requisiciones[i][7]+"</td>");
                                            out.println("<td>"+requisiciones[i][8]+"</td>");
                                            out.println("<td>"+requisiciones[i][9]+"</td>");
                                            out.println("<td>"+requisiciones[i][10]+"</td>");
                                            out.println("<td>"+requisiciones[i][11]+"</td>");
                                        
                                            
                                        %>
                                        
                                        <td class="bv aaj"> <a href="<% out.println(host); %>Servlet?controlador=verComputo&numeroOperacion=<% out.println(requisiciones[i][0]); %>" class="btn btn-md bla blb">Ver <i class="fa fa-eye" ></i></a></td>
                                        
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
                <h4 class="modal-title" id="myModalLabel">Registro Equipo de Computo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formRegistroComputo" action = "Servlet?controlador=registroComputo" method = "post"  enctype = "multipart/form-data" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionAplicacion" name="idOperacionAplicacion" >
                    <input type="hidden" id="idUsuario" name="idUsuario" value="<%out.print(idUsuario);%>" >
                    
                    <%
                        
                        operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("19");

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

                                    
                                    
                                    if (requisicionesForm[i][4].equals("tipoEquipoComputo")){
                                          
                                        catalogo_servicio catalogo = new catalogo_servicio();
                                        String catalogos[][]=catalogo.listaPorTipoCatalogo(12);
                                    
                                        String opciones="";
                                  
                                     
                                        for (int j=0;j<catalogos.length;j++){
                                            opciones = opciones + "<option value=\"" + catalogos[j][0] + "\">" + catalogos[j][1] + "</option>";
                                        }
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group\">"+
                                                                                "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                                                    "<option value=\"\">Selecciona...</option>"+
                                                                                    opciones+
                                                                                "</select>"+
                                                                            "</div>";

                                    }
                                    
                                    if (requisicionesForm[i][4].equals("marcaComputo")){
                                             
                                        catalogo_servicio catalogo = new catalogo_servicio();
                                        String catalogos[][]=catalogo.listaPorTipoCatalogo(13);
                                         
                                        String opciones="";
                                  
                                     
                                        for (int j=0;j<catalogos.length;j++){
                                            opciones = opciones + "<option value=\"" + catalogos[j][0] + "\">" + catalogos[j][1] + "</option>";
                                        }
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group\">"+
                                                                                "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                                                    "<option value=\"\">Selecciona...</option>"+
                                                                                    opciones+
                                                                                "</select>"+
                                                                            "</div>";

                                    }
                                    
                                    if (requisicionesForm[i][4].equals("asignacionComputo")){
                                        
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
                                    
                                    if (requisicionesForm[i][4].equals("lugarComputo")){
                                             
                                         
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
            
        var valor1 = document.getElementById("tipoEquipoComputo").value;

        if (valor1 == ''   ){
            valido=0;
            alert("Por favor llena la Tipo de Equipo de Computo");
        }
        
        var valor2 = document.getElementById("marcaComputo").value;

        if (valor2 == '' ){
            valido=0;
            alert("Por favor llena la Marca");
        }
        
        var valor3 = document.getElementById("modeloComputo").value;

        if (valor3 == '' ){
            valido=0;
            alert("Por favor llena el Modelo");
        }
        
        var valor4 = document.getElementById("serieComputo").value;

        if (valor4 == '' ){
            valido=0;
            alert("Por favor llena la serie");
        }
        
        var valor5 = document.getElementById("asignacionComputo").value;

        if (valor5 == '' ){
            valido=0;
            alert("Por favor llena la asignación");
        }
        
        var valor6 = document.getElementById("lugarComputo").value;

        if (valor6 == ''   ){
            valido=0;
            alert("Por favor llena el lugar");
        }
        
        if (valido==1){
            document.getElementById("formRegistroComputo").submit();
        }
 
    }
    
    
    
    
    
</script>                            


<jsp:include page="../pieDePagina.jsp" flush="true"/>                   