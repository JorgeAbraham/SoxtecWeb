



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
                <h3 class="bla blb">Aplicación de Pagos</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                <% String idOperacion = request.getParameter("numeroOperacion");   %>
            </div>    
            <i class="fa fa-money" style="font-size:48px"></i>
            <hr>
            
                
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">Ordenes de Compra <i class="fa fa-shopping-cart" style="font-size:24px"></i></a> </li>&nbsp;
                <li><a class="btn btn-danger btn-md bla blb" data-toggle="tab" href="#menu1">Devolución de Pago <i class="fa fa-handshake-o" style="font-size:24px"></i></a> </li>&nbsp;
                <li><a class="btn btn-info btn-md bla blb" data-toggle="tab" href="#menu2">Pagos Fijos <i class="fa fa-clock-o" style="font-size:24px"></i></a></li>&nbsp;
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
                                    estadosOperacion.add("3");
                                
                                    
                                    String requisiciones[][]=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"10",estadosOperacion);
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
                                        
                                        <td class="bv aaj"> <a href="#registro"  class="btn btn-block bla blb  col-md-12"  onclick="aplicacion(<% out.println(requisiciones[i][0]);  %>)"  data-toggle="modal">REGISTRAR PAGO <i class="fa fa-pencil-square " ></i></a></td>

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
                                    <th class="header">Monto</th>
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
                                    estadosOperacion.add("3");
                                
                                    
                                    requisiciones=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"25",estadosOperacion);
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
                                        
                                        <td class="bv aaj"> <a href="#registroOrdenPago"  class="btn btn-block bla blb  col-md-12"  onclick="aplicacionOrdenPago(<% out.println(requisiciones[i][0]);  %>)"  data-toggle="modal">REGISTRAR PAGO <i class="fa fa-pencil-square " ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    
                    
                    
                </div>
                                    
                                    
                                    
                                    
                <div id="menu2" class="tab-pane fade">
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
                                    tipoOperacion.add("10");
                                    
                                     estadosOperacion=new ArrayList();
                                    estadosOperacion.add("9");
                                    estadosOperacion.add("10");
                                    estadosOperacion.add("11");
                                    estadosOperacion.add("12");
                                    estadosOperacion.add("13");
                                    estadosOperacion.add("14");
                                    estadosOperacion.add("16");
                                
                                    
                                    requisiciones=operacion.listaOperecionesPorTipoOperacion(tipoOperacion,"33",estadosOperacion);
                                    for (int i=0;i<requisiciones.length;i++){%>
                                    <tr>
                                        
                                        
                                        <%
                                            
                                            out.println("<td>"+requisiciones[i][0]+"</td>");
                                            out.println("<td>"+requisiciones[i][1]+"</td>");
                                            out.println("<td>"+requisiciones[i][2]+"</td>");
                                            out.println("<td>"+requisiciones[i][3]+"</td>");
                                            out.println("<td>"+requisiciones[i][4]+" "+requisiciones[i][5]+" "+requisiciones[i][6]+"</td>");
                                            
                                            
                                        
                                        %>
                                        
                                        <td class="bv aaj"> <a href="#registroPagoFijo"  class="btn btn-block bla blb  col-md-12"  onclick="aplicacionPagoFijo(<% out.println(requisiciones[i][0]);  %>)"  data-toggle="modal">REGISTRAR PAGO <i class="fa fa-pencil-square " ></i></a></td>

                                    <%}%>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                                    

            </div>  
        
        </div>

                                    
                                    
                                    
                                    
                                    
<div id="registro" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Aplicar Pago</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formAplicarPagoOrdenCompra" action = "Servlet?controlador=aplicarPago" method = "post" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionAplicacion" name="idOperacionAplicacion" >
                    
                    
                    <%
                        
                        operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("3");

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


                                    if (requisicionesForm[i][4].equals("UsuarioAplicado")){

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
                        plantillaDeTexto=plantillaDeTexto+"</div>";
                        out.print(plantillaDeTexto);

                        %>
                           
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Aplicar" onclick="validacion2()"/>
                    
                </div>
            </form>
        </div>
    </div>
</div>

                        
<div id="registroOrdenPago" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Aplicar Pago</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formAplicarPagoOrdenPago" action = "Servlet?controlador=aplicarPagoPendiente" method = "post" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionAplicacionOrdenPago" name="idOperacionAplicacionOrdenPago" >
                    <%
                        operacion = new operaciones_servicio();
                        requisicionesForm=operacion.listaOperacionesBasePorTipo("9");

                        plantillaDeTexto="";
                        idLista="";

                        fragmentoTabla0="<table  id=\"tabla";
                        fragmentoTabla1="\"  class=\"table\" class=\"col-md-12\" >"+
                                                    "<thead>"+
                                                "<tr>";
                        cabeceras=""; 

                        fragmentoTabla2="</tr>"+
                                                    "</thead>"+
                                                        "<tbody>";

                        valores=""; 
                        fragmentoTabla3=
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
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-12\" onkeyup=\"formatoNumerico(event);\"   >";

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


                                    if (requisicionesForm[i][4].equals("UsuarioAplicadoOrdenesPago")){

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
                        
                        
     
                        
                        
                   
<div id="registroPagoFijo" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Aplicar Pago Fijo</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formAplicarPagoFijo" action = "Servlet?controlador=aplicarPagoFijo" method = "post" >
                <div class="modal-body">
                    
                    <input type="hidden" id="idOperacionAplicacionPagoFijo" name="idOperacionAplicacionPagoFijo" >
                    <%
                        operacion = new operaciones_servicio();
                        requisicionesForm=operacion.listaOperacionesBasePorTipo("11");

                        plantillaDeTexto="";
                        idLista="";

                        fragmentoTabla0="<table  id=\"tabla";
                        fragmentoTabla1="\"  class=\"table\" class=\"col-md-12\" >"+
                                                    "<thead>"+
                                                "<tr>";
                        cabeceras=""; 

                        fragmentoTabla2="</tr>"+
                                                    "</thead>"+
                                                        "<tbody>";

                        valores=""; 
                        fragmentoTabla3=
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
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-12\" onkeyup=\"formatoNumerico(event);\"   >";

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


                                    if (requisicionesForm[i][4].equals("UsuarioPagadoFijo")){

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
                        plantillaDeTexto=plantillaDeTexto+"</div>";
                        out.print(plantillaDeTexto);

                        %>
                           
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-success"  value="Aplicar" onclick="validacion3()"/>
                </div>
            </form>
        </div>
    </div>
</div>                        
                        
                        
             
                        
                        
                        
                        
                        
                        
                

<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=aplicacionPago';  
    }
    
    
    function validacion3(){
        var valido=1;
        
        var fecha = document.getElementById("FechaPagadoFijo").value;
        var monto = document.getElementById("MontoPagadoFijo").value;
        
                        
        if (fecha == ''){
            valido=0;
            alert("Por favor llena la Fecha de Pago");
        }
        
        if (monto == '' ){
            valido=0;
            alert("Por favor llena el monto");
        }
            
        if (valido==1){
            document.getElementById("formAplicarPagoFijo").submit();
        }

        
    }
    
    function validacion2(){
        var valido=1;
        
        var monto = document.getElementById("montoAplicado").value;
        var cuenta = document.getElementById("cuentaAplicada").value;
                        
        if (monto == ''){
            valido=0;
            alert("Por favor llena el Monto");
        }
        
        if (cuenta == '' ){
            valido=0;
            alert("Por favor llena la Cuenta a Aplicar");
        }
            
        if (valido==1){
            document.getElementById("formAplicarPagoOrdenCompra").submit();
        }

        
    }
    
    
    
    
    function validacion(){
        var valido=1;
        
        var monto = document.getElementById("montoAplicadoOrdenesPago").value;
        var cuenta = document.getElementById("cuentaAplicadaOrdenesPago").value;
                        
        if (monto == ''){
            valido=0;
            alert("Por favor llena el Monto");
        }
        
        if (cuenta == '' ){
            valido=0;
            alert("Por favor llena la Cuenta a Aplicar");
        }
            
        if (valido==1){
            document.getElementById("formAplicarPagoOrdenPago").submit();
        }

        
    }
    
    
    function formatoNumerico(e){
        var elemento=e.srcElement.id;
        var valor_numerico=isNaN(   document.getElementById(elemento).value  );
        if (!valor_numerico){
            document.getElementById(elemento).value
        }else{
            document.getElementById(elemento).value = "0.0";
        }
        
    }
    
    
    function aplicacion(idOperacionAplicacion){
        $('#idOperacionAplicacion').val(  idOperacionAplicacion  );
     
        
    }
    
    function aplicacionOrdenPago(idOperacionAplicacion){
     
        $('#idOperacionAplicacionOrdenPago').val(  idOperacionAplicacion  );
        
    }
   
   function aplicacionPagoFijo(idOperacionAplicacion){
     
        $('#idOperacionAplicacionPagoFijo').val(  idOperacionAplicacion  );
        
    }



</script>




        <jsp:include page="../pieDePagina.jsp" flush="true"/>