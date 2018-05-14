


<%@page import="libreriaApoyo.tablaHtml"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="serviciosBD.persona_servicio"%>
<%@page import="serviciosBD.operaciones_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>
<jsp:include page="../cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>

                    <div class="bkz aav aaj">
                        <h3 class="bla blb">REVISIÓN DE ORDENES DE PAGO</h3>
                    </div>

          
              
                    <% String host=application.getInitParameter("host");  %>
                    <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                    <% Date fechaActual = new Date(); %>
                    <% String idOperacion = request.getParameter("numeroOperacion");   %>
                
                    <div class=row>
                         <br><br><br>
                    </div>
                    
                    
                    

                    <form id="" action="Servlet?controlador=crearOrdenDeCompra" method = "post"  enctype = "multipart/form-data">
                         
                        <%

                        operaciones_servicio operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesPorTipo("7",idOperacion);

                         
                        tablaHtml tabla=new tablaHtml();
                        String plantillaDeTexto="";
                       

                        out.println("<div class=\"row\">");


                        for (int i=0;i<requisicionesForm.length;i++){

                            if (  requisicionesForm[i][6]==null  ){  //No es una Lista

                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTexto)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoArchivo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    
                                    plantillaDeTexto=plantillaDeTexto+"<a href=\""+host+"Servlet?controlador=descargaDocumentoEmpleado&requisitoId="+requisicionesForm[i][12]+"\"    class=\"btn btn-md bla blb col-md-6\"  > ";
                                    plantillaDeTexto=plantillaDeTexto+"<span>Descarga</span>";
                                    plantillaDeTexto=plantillaDeTexto+"</a> ";
                                    
                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoNumero)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][10]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoFecha)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][11]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTextoLargo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.catalogo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+ "</span>";
                                    if (requisicionesForm[i][14].equals("UsuarioP")){
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            persona_servicio empleados = new persona_servicio();
                                            empleados.setIdPersona(Integer.parseInt(requisicionesForm[i][9]));
                                            empleados.get();
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"</span>";
                                        }
                                        
                                        
                                    }
                                    if (requisicionesForm[i][14].equals("PersonaReceptora")){
                                        
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            persona_servicio empleados = new persona_servicio();
                                            empleados.setIdPersona(Integer.parseInt(requisicionesForm[i][9]));
                                            empleados.get();
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"</span>";
                                        } 
                                    }

                                }

                            }
                            else{ //Listas

                                tabla.agregaRegistro(  
                                                        requisicionesForm[i][13], 
                                                        requisicionesForm[i][7], 
                                                        requisicionesForm[i][6],
                                                        requisicionesForm[i][8],
                                                        requisicionesForm[i][9], 
                                                        requisicionesForm[i][10],
                                                        requisicionesForm[i][11], 
                                                        requisicionesForm[i][12]
                                                    );
                        
                            }
                           
                           

                        }
                        out.print( tabla.printHTMLtabla() );
                        out.print(plantillaDeTexto);

                        %>

                                    
                        
                       
                        <div class="col-md-12"><br></div>
                        
                        <%

                        operacion = new operaciones_servicio();
                        requisicionesForm=operacion.listaOperacionesRelacionadasPorTipoOperacion(idOperacion,"3");

                         
                        tabla=new tablaHtml();
                        plantillaDeTexto="";
                       

                        out.println("<div class=\"row\">");


                        for (int i=0;i<requisicionesForm.length;i++){

                            if (  requisicionesForm[i][6]==null  ){  //No es una Lista

                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTexto)){
                                    
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoArchivo)){


                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    
                                    plantillaDeTexto=plantillaDeTexto+"<a href=\""+host+"Servlet?controlador=descargaDocumentoEmpleado&requisitoId="+requisicionesForm[i][12]+"\"    class=\"btn btn-md bla blb col-md-6\"  > ";
                                    plantillaDeTexto=plantillaDeTexto+"<span>Descarga</span>";
                                    plantillaDeTexto=plantillaDeTexto+"</a> ";
                                    
                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoNumero)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][10]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoFecha)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][11]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTextoLargo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.catalogo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][7]+ "</span>";
                                    if (requisicionesForm[i][14].equals("UsuarioP")){
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            persona_servicio empleados = new persona_servicio();
                                            empleados.setIdPersona(Integer.parseInt(requisicionesForm[i][9]));
                                            empleados.get();
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"</span>";
                                        }
                                        
                                        
                                    }
                                    if (requisicionesForm[i][14].equals("PersonaReceptora")){
                                        
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            persona_servicio empleados = new persona_servicio();
                                            empleados.setIdPersona(Integer.parseInt(requisicionesForm[i][9]));
                                            empleados.get();
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"</span>";
                                        } 
                                    }

                                }

                            }
                            else{ //Listas

                              
                        
                            }
                           
                           

                        }
                        out.print( tabla.printHTMLtabla() );
                        out.print(plantillaDeTexto);
                        %>
                        
                        
                        
                        
                           <a href="#procesarComprobante"  class="btn btn-block bla blb  col-md-12"    data-toggle="modal">Procesar <i class="fa fa-gavel" ></i></a>
                        
                       
                    </form>
           
         </div>   
        
   </div>
</div>
                
                        
<div id="procesarComprobante" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">  
   <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Procesar Comprobación</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="procesarOrdenPago" action = "Servlet?controlador=procesarPagoPendiente" method = "post" >
                <div class="modal-body">
                    
                    <input type="hidden" id="aprobacionComprobada" name="aprobacionComprobada" value="">
                    <input type="hidden" id="idOperacionComprobada" name="idOperacionComprobada" value="<%out.println(idOperacion);%>">
                    
                    <% 
                        operacion = new operaciones_servicio();
                        requisicionesForm=operacion.listaOperacionesBasePorTipo("8");
                        
                        plantillaDeTexto="";
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


                                        if (requisicionesForm[i][4].equals("UsuarioApruebaRechazaOrdenesPag")){

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
                        
                            out.print(plantillaDeTexto);

                    %>
                    
                            
                </div>
                <div class="om">
                    <input type="button" class="btn btn-md btn-danger"  value="Denegar" onclick="seleccionaEstadoComprobacion(4)"/>
                    <input type="button" class="btn btn-md btn-success"  value="Aprobar" onclick="seleccionaEstadoComprobacion(3)"/>
                    
                </div>
            </form>
        </div>
    </div>
</div>                       
                        
                        
            
          
                
<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=revisarPagoPendiente&numeroOperacion=<%out.print(idOperacion);%>';  
    }
    
    function seleccionaEstadoComprobacion(aprovacionDesaprovacion){
        $('#aprobacionComprobada').val(  aprovacionDesaprovacion  );
        
        var valido=1;
        
        if(aprovacionDesaprovacion==4){ //Aprovar
            var motivo = document.getElementById("MotivoApruebaRechazaOrdenesPag").value;
            if (motivo == ''    ){
                valido=0;
                alert("Por favor llena el Motivo");
            }
            if (valido==1){
                document.getElementById("procesarOrdenPago").submit();
            }

        }else{
            document.getElementById("procesarOrdenPago").submit();
        }  
    }
    
    
    
</script>


<jsp:include page="../pieDePagina.jsp" flush="true"/>