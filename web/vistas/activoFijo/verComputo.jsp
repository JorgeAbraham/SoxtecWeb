
<%@page import="serviciosBD.catalogo_servicio"%>
<%@page import="serviciosBD.lugar_servicio"%>
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
                        <h3 class="bla blb">Equipo De Computo</h3>
                    </div>

          
              
                    <% String host=application.getInitParameter("host");  %>
                    <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                    <% Date fechaActual = new Date(); %>
                    <% String idOperacion = request.getParameter("numeroOperacion");   %>
                
                    <div class=row>
                         <br><br><br>
                    </div>
                    
                    
                    

                         
                        <%

                        operaciones_servicio operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesPorTipo("19",idOperacion);

                         
                        tablaHtml tabla=new tablaHtml();
                        String plantillaDeTexto="";
                       

                        out.println("<div class=\"row\">");


                        for (int i=0;i<requisicionesForm.length;i++){

                            if (  requisicionesForm[i][6]==null  ){  //No es una Lista

                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTexto)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(  "+requisicionesForm[i][15]+"  ,  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"   )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>   ";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoArchivo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(  "+requisicionesForm[i][15]+",  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"   )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+"</span>";
                                    
                                    plantillaDeTexto=plantillaDeTexto+"<a href=\""+host+"Servlet?controlador=descargaDocumentoEmpleado&requisitoId="+requisicionesForm[i][12]+"\"    class=\"btn btn-md bla blb col-md-6\"  > ";
                                    plantillaDeTexto=plantillaDeTexto+"<span>Descarga</span>";
                                    plantillaDeTexto=plantillaDeTexto+"</a> ";
                                    
                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoNumero)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(  "+requisicionesForm[i][15]+" ,  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"   )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+"<a href=\"\"><div class=\"fa fa-edit\"></div></a></span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][10]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoFecha)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(  "+requisicionesForm[i][15]+"  ,  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"  )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][11]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.tipoTextoLargo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(    "+requisicionesForm[i][15]+"  ,  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"   )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][9]+"</span>";

                                }
                                if (requisicionesForm[i][8].equals(operaciones_servicio.catalogo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\"><a href=\"#editAuto\"  onclick=\"seleccionaAuto(    "+requisicionesForm[i][15]+"  ,  "+requisicionesForm[i][8]+"  ,  "+requisicionesForm[i][13]+"  )\" data-toggle=\"modal\"><div class=\"fa fa-edit\"></div></a>"+requisicionesForm[i][7]+ "</span>";
                                    if (requisicionesForm[i][14].equals("asignacionComputo")){
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            persona_servicio empleados = new persona_servicio();
                                            empleados.setIdPersona(  Integer.parseInt(requisicionesForm[i][9])   );
                                            empleados.get();
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"</span>";
                                        }
                                        
                                        
                                    }
                                    if (requisicionesForm[i][14].equals("tipoEquipoComputo")){
                                        
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            
                                            catalogo_servicio catalogo=new catalogo_servicio();
                                            String L[][] = catalogo.catalogoPorId(requisicionesForm[i][9]);
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+L[0][0]+"</span>";
                                        } 
                                    }
                                    if (requisicionesForm[i][14].equals("lugarComputo")){
                                        
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            
                                            lugar_servicio lugar=new lugar_servicio();
                                            String L[][] = lugar.lugaresPorId(requisicionesForm[i][9]);
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+L[0][1]+"</span>";
                                        } 
                                    }
                                    
                                     if (requisicionesForm[i][14].equals("marcaComputo")){
                                        
                                        if( requisicionesForm[i][9]!=null &&  !requisicionesForm[i][9].equals("")){ 
                                            
                                            catalogo_servicio catalogo=new catalogo_servicio();
                                            String L[][] = catalogo.catalogoPorId(requisicionesForm[i][9]);
                                            plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+L[0][0]+"</span>";
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

                          
                        
                        
                        
                          
                       
                       
                  
           
         </div>   
        
   </div>
</div>
                
                        
             
                          
                            
<div id="editAuto" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Edición</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="formRegistroAutomovil" action = "Servlet?controlador=editaValorAuto" method = "post"    enctype="multipart/form-data"  >
                <div class="modal-body">
                    
                    
                    
                    <div id="valorEditar"></div>
                    
                    
                    <input type="hidden" id="numeroOperacion" name="numeroOperacion" value="<% out.print(idOperacion);  %>" />
                    <input type="hidden" id="idConceptoOperacion" name="idConceptoOperacion" value="" />
                    <input type="hidden" id="idTipoVariable" name="idTipoVariable" value="" />
                    <input type="hidden" id="idConcepto" name="idConcepto" value="" />


                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type="button" class="ce kh" name="Cambiar" id="btsubmit" value="Cambiar" onclick="validacion()"/>
                   
                </div>
            </form>
        </div>
    </div>
</div>
       
                
<script>
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=verAutomovil&numeroOperacion=<%out.print(idOperacion);%>';  
    } 
    
    
    function seleccionaAuto(idConceptoOperacion, idTipoVariable, idConcepto){
        $('#idConceptoOperacion').val(  idConceptoOperacion  );
        $('#idTipoVariable').val(  idTipoVariable  );
        $('#idConcepto').val(  idConcepto  );
        
        
        if (idTipoVariable == 1){
            $( "#valorEditar" ).html( '<input type="text" id="valorEdicion" name="valorEdicion" />' );
        }
        if (idTipoVariable == 2){
            $( "#valorEditar" ).html(  '<input type="file" id="valorEdicion" name="valorEdicion"    />' );
        }
        if (idTipoVariable == 3){
            $( "#valorEditar" ).html(  '<input type="text" id="valorEdicion" name="valorEdicion" />' );
        }
        if (idTipoVariable == 4){
            $( "#valorEditar" ).html( '<input type="date" name="valorEdicion"   id="valorEdicion"    value="<% out.print(  (new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)));  %>"     >' );
        }
        if (idTipoVariable == 5){
            $( "#valorEditar" ).html( '<textarea rows="4" cols="50"></textarea>' );
        }
        if (idTipoVariable == 6){
            
            if (idConcepto ==86){
                
                <%
                    persona_servicio empleados = new persona_servicio();
                    String empleado[][]=empleados.LISTAempleadosEstadoActivoString(empleados.ALTA);
                    String usuarios[][]=empleados.LISTAUsuarioString();

                    plantillaDeTexto="";
                    String opciones="";

                    for (int j=0;j<usuarios.length;j++){
                        opciones = opciones + "<option value=\"" + usuarios[j][1] + "\">" + usuarios[j][0] + "</option>";
                    }

                    for (int j=0;j<empleado.length;j++){
                        opciones = opciones + "<option value=\"" + empleado[j][1] + "\">" + empleado[j][0] + "</option>";
                    }
                    plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group\">"+
                                                            "<select id=\"valorEdicion\" name=\"valorEdicion\" class=\"form-control\">"+
                                                                "<option value=\"\">Selecciona...</option>"+
                                                                opciones+
                                                            "</select>"+
                                                        "</div>";
                    
                    
                    
                %>                      
                $( "#valorEditar" ).html( '<% out.print(plantillaDeTexto); %>'   );
                
            }
            if (idConcepto ==87){
                <%
                    
                    
                    plantillaDeTexto="";
                    plantillaDeTexto=plantillaDeTexto+"<select id=\"valorEdicion\" name=\"valorEdicion\" class=\"form-control\">";

                    lugar_servicio L = new lugar_servicio();
                    String lugares[][]=L.listaLugares();  

                    plantillaDeTexto=plantillaDeTexto+"<option value=\"\">Selecciona...</option>";
                    for (int j=0;j<lugares.length;j++){  
                        plantillaDeTexto=plantillaDeTexto+"<option value=\""+lugares[j][0]+"\">"+lugares[j][1]+"</option>";
                    }
                    plantillaDeTexto=plantillaDeTexto+"</select>";
                    
                    
                    
                %>                      
                $( "#valorEditar" ).html( '<% out.print(plantillaDeTexto); %>'   );
            }
                        
            if (idConcepto ==82){
                <%
                    plantillaDeTexto="";
                    plantillaDeTexto=plantillaDeTexto+"<select id=\"valorEdicion\" name=\"valorEdicion\" class=\"form-control\">";

                    catalogo_servicio catalogo = new catalogo_servicio();
                    String catalogos[][]=catalogo.listaPorTipoCatalogo(12);  

                    plantillaDeTexto=plantillaDeTexto+"<option value=\"\">Selecciona...</option>";
                    for (int j=0;j<catalogos.length;j++){  
                        plantillaDeTexto=plantillaDeTexto+"<option value=\""+catalogos[j][0]+"\">"+catalogos[j][1]+"</option>";
                    }
                    plantillaDeTexto=plantillaDeTexto+"</select>";
                    
                    
                    
                %>                      
                $( "#valorEditar" ).html( '<% out.print(plantillaDeTexto); %>'   );
                
            }
            
            
            
            
         
        }
        
        
        
        
       
        
        
    }
    
    
    
    
     function validacion(){
        
        
        var valido=1;
          
        
        document.getElementById("btsubmit").value = "Enviando...";
        document.getElementById("btsubmit").disabled = true;
        
      
        var valorEdicion = document.getElementById("valorEdicion").value;
        if (valorEdicion == ''   ){
            valido=0;
            alert("Por favor llena un valor");
        }
    
        
        
        if (valido==1){
            document.getElementById("formRegistroAutomovil").submit();
            
            
        }else{
            document.getElementById("btsubmit").value = "Cambiar";
            document.getElementById("btsubmit").disabled = false;
        
        }
 
    }
    
    
    
  
    
    
</script>


<jsp:include page="../pieDePagina.jsp" flush="true"/>