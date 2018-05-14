



<%@page import="java.text.DecimalFormat"%>
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
                <h3 class="bla blb">Comprobante de Pago</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                <% String idOperacion = request.getParameter("numeroOperacion");   %>
            </div> 
            <i class="fa fa-clone" style="font-size:48px"></i>
            <hr>
                	
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0" >Ordenes de Compra<i class="fa fa-shopping-cart" style="font-size:24px"></i></a></li>&nbsp;
                
            </ul>
                
            <div class="tab-content">
                
                <div id="menu0" class="tab-pane fade in active">
                    

                        <table class="ck" >
                            <thead>
                                <tr>
                                    <th class="header">Número de Operación</th>
                                    <th class="header">Estado</th>
                                    <th class="header">Fecha</th>
                                    <th class="header">Monto</th>
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
                                    estadosOperacion.add("5");
                                    estadosOperacion.add("8");
                                
                                    
                                    String requisiciones[][]=operacion.listaOperecionesPorTipoOperacionPorUsuario(tipoOperacion,"10",estadosOperacion,idUsuario);
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        
                                        
                                        <%
                                            
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            DecimalFormat formatea = new DecimalFormat("###,###.##");
                                            out.println("<td>"+"$ "+formatea.format(Float.parseFloat(requisiciones[i][7]))+" M.N.</td>");
                                            out.println("<td>"+requisiciones[i][4]+" "+requisiciones[i][5]+" "+requisiciones[i][6]+"</td>");
                                            
                                            
                                        
                                        %>
                                        
                                        <td class="bv aaj"> <a href="#registro"  class="btn btn-block bla blb  col-md-12"  onclick="aplicacion(<% out.println(requisiciones[i][0]);  %>)"  data-toggle="modal">Comprobar <i class="fa fa-file-image-o"></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    
                </div> 
                
                
                

            </div>  
        
        </div>

<div id="registro" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Subir Comprobantes de Pago</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="comprobantesOrdenesCompra" action = "Servlet?controlador=subirComprobantesPago" method = "post"  enctype = "multipart/form-data" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionComprobantes" name="idOperacionComprobantes" >
                    <input type="hidden" id="idUsuarioComprueba" name="idUsuarioComprueba" value="<% out.println(idUsuario);  %>"  >
                    
                    
                    <%
                        
                        operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("4");

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
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-12\"  >";

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


                                    if (requisicionesForm[i][4].equals("UsuarioComprobado")){

                                        persona_servicio empleados = new persona_servicio(Integer.parseInt(idUsuario));

                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"text\"  class=\"col-md-12\" value=\""+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"\"  disabled >";
                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"hidden\" name=\""+requisicionesForm[i][4]+"\" class=\"col-md-12\" value=\""+idUsuario+"\" >";
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
                        out.print(plantillaDeTexto);

                        %>
                           
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Subir" onclick="validacion()"/>
                </div>
            </form>
        </div>
    </div>
</div>

                

<script>
    
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=comprobarPago';  
    }
    
    
    function aplicacion(idOperacionComprobantes){
        $('#idOperacionComprobantes').val(  idOperacionComprobantes  );
    }
    
    
    
    function validacion(){
        var valido=1;
        
        var comentarios = document.getElementById("comentariosComprobacion").value;
        
                        
        if (comentarios == ''){
            valido=0;
            alert("Por favor llena los comentarios");
        }
        
        if (valido==1){
            document.getElementById("comprobantesOrdenesCompra").submit();
        }

        
    }

</script>




        <jsp:include page="../pieDePagina.jsp" flush="true"/>