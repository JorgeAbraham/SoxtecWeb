


<%@page import="serviciosBD.catalogo_servicio"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="serviciosBD.operaciones_servicio"%>
<%@page import="serviciosBD.usuario_servicio"%>
<%@page import="serviciosBD.lugar_servicio"%>
<%@page import="serviciosBD.persona_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>
<jsp:include page="../cabecera.jsp" flush="true"/>




<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>



            <div class="bkz aav aaj">
                <h3 class="bla blb">Registro de Personal</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
            </div>    
            
            
            <i class="fa fa-id-badge" style="font-size:48px;"></i>
       
           
            <hr class="aav">
            
            
            <form id="crearRegistroAsistencia" action="Servlet?controlador=registroHorario" method = "post"  enctype = "multipart/form-data">
            
                
                 <input type="hidden" name="idUsuario" class="col-md-6"  value="<% out.print(idUsuario); %>" >
                
                <%

                    persona_servicio empleados = new persona_servicio();
                    String empleado1[][]=empleados.LISTAempleadosString(true);

                    String empleadosCatalogo="";
                    for (int j=0;j<empleado1.length;j++){
                        empleadosCatalogo = empleadosCatalogo + "<option value=\'" + empleado1[j][1] + "\'>" + empleado1[j][0] + "</option>";
                    }


                    String LugaresLista="";
                    lugar_servicio L = new lugar_servicio();
                    String lugares[][]=L.listaLugares();
                    for (int i=0;i<lugares.length;i++){  
                        LugaresLista=LugaresLista+"<option value=\'"+lugares[i][0]+"\'>"+lugares[i][1]+"</option>";
                    }  


                    catalogo_servicio C = new catalogo_servicio();
                    String areas[][]=C.listaPorTipoCatalogo(15); 
                    String AreaLista="";
                    for (int i=0;i<areas.length;i++){  
                        AreaLista=AreaLista+"<option value=\'"+areas[i][0]+"\'>"+areas[i][1]+"</option>";
                    }  


                    operaciones_servicio operacion = new operaciones_servicio();
                    String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("21");

                    String plantillaDeTexto="";
                    String idLista="";


                    String fragmentoTabla0="<table  id=\"tabla";
                    String fragmentoTabla1="\"  class=\"table table-responsive table-striped\"      class=\"col-md-12\" >"+
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





                    for (int i=0;i<requisicionesForm.length;i++){


                        idLista=requisicionesForm[i][2];

                        if (  requisicionesForm[i][2]==null  ){  //No es una Lista

                            if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTexto)){

                                plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\"  id=\""+requisicionesForm[i][4]+"\"  class=\"col-md-6\" >";

                            }
                            if (requisicionesForm[i][3].equals(operaciones_servicio.tipoArchivo)){

                                plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                plantillaDeTexto=plantillaDeTexto+"<input type=\"file\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\" class=\"col-md-6\"  >";

                            }
                            if (requisicionesForm[i][3].equals(operaciones_servicio.tipoNumero)){

                                plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-6\"  >";

                            }
                            if (requisicionesForm[i][3].equals(operaciones_servicio.tipoFecha)){

                                plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                plantillaDeTexto=plantillaDeTexto+"<input type=\"date\" name=\""+requisicionesForm[i][4]+"\"   id=\""+requisicionesForm[i][4]+"\"        class=\"col-md-6\"    value=\""+ (new SimpleDateFormat("yyyy-MM-dd").format(fechaActual))  +"\"     >";

                            }
                            if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTextoLargo)){

                                plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                plantillaDeTexto=plantillaDeTexto+"<textarea rows=\"4\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"     cols=\"50\"  class=\"col-md-6\"  ></textarea>";

                            }
                            if (requisicionesForm[i][3].equals(operaciones_servicio.catalogo)){


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
                                    valores=valores+"<td  >";

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

                                        if (requisicionesForm[j][3].equals(operaciones_servicio.catalogo)){



                                            if (requisicionesForm[j][4].equals("personaAsistencia")){
                                                        valores=valores+"<div class=\"form-group\">"+
                                                                                        "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"\">"+
                                                                                            "<option value=\"\"></option>"+
                                                                                            empleadosCatalogo+
                                                                                        "</select>"+
                                                                                    "</div>";
                                            }



                                            if (requisicionesForm[j][4].equals("plantaAsistencia")){
                                                        valores=valores+"<div class=\"form-group\">"+
                                                                                        "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"\">"+
                                                                                            "<option value=\"\"></option>"+
                                                                                            LugaresLista+
                                                                                        "</select>"+
                                                                                    "</div>";
                                            }

                                            if (requisicionesForm[j][4].equals("areaAsistencia")){
                                                        valores=valores+"<div class=\"form-group\">"+
                                                                                        "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"\">"+
                                                                                            "<option value=\"\"></option>"+
                                                                                            AreaLista+
                                                                                        "</select>"+
                                                                                    "</div>";
                                            }

                                            if (
                                                    requisicionesForm[j][4].equals("H1") ||
                                                    requisicionesForm[j][4].equals("H2") ||
                                                    requisicionesForm[j][4].equals("H3") ||
                                                    requisicionesForm[j][4].equals("H4") ||
                                                    requisicionesForm[j][4].equals("H5") ||
                                                    requisicionesForm[j][4].equals("H6") ||
                                                    requisicionesForm[j][4].equals("H7") ||
                                                    requisicionesForm[j][4].equals("H8") ||
                                                    requisicionesForm[j][4].equals("H9") ||
                                                    requisicionesForm[j][4].equals("H10") ||
                                                    requisicionesForm[j][4].equals("H11") ||
                                                    requisicionesForm[j][4].equals("H12") ||
                                                    requisicionesForm[j][4].equals("H13") ||
                                                    requisicionesForm[j][4].equals("H14") ||
                                                    requisicionesForm[j][4].equals("H15") ||
                                                    requisicionesForm[j][4].equals("H16") ||
                                                    requisicionesForm[j][4].equals("H17") ||
                                                    requisicionesForm[j][4].equals("H18") ||
                                                    requisicionesForm[j][4].equals("H19") ||
                                                    requisicionesForm[j][4].equals("H20") ||
                                                    requisicionesForm[j][4].equals("H21") ||
                                                    requisicionesForm[j][4].equals("H22") ||
                                                    requisicionesForm[j][4].equals("H23") 

                                                ){

                                                valores=valores+"<div class=\"form-check\">"+
                                                                    "<input type=\"checkbox\"   id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\"    >"+
                                                                "</div>";

                                            }


                                        }



                                    valores=valores+"</td>";
                                    i=j;
                                }

                            }

                            plantillaDeTexto=plantillaDeTexto+valores;

                            valores=valores+"";
                            plantillaDeTexto=plantillaDeTexto+fragmentoTabla3;
                            plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"agregaFila("+requisicionesForm[i][2]+");\" >Agregar <i class=\"fa fa-plus-circle\" ></i> </a>";
                            plantillaDeTexto=plantillaDeTexto+"<div class=\"col-md-8\"></div>";
                            plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2  btn btn-white btn-md bla blb \" onclick=\"eliminaFila("+requisicionesForm[i][2]+");\" >Eliminar <i class=\"fa fa-remove\" ></i></a>";

                        }


                    }

                    out.print(plantillaDeTexto);

                %>
                
                
                <div class="container">
                    <hr>
                    <div class="row">
                        
                            <input type="button" class="btn btn-primary col-12" name="Guardar" id="submit_value" value="Guardar" onclick="validacion()"/>
                        
                    </div>
                </div>
                
            </form>
            
            
            
        </div>

        <div class="dh bmk">
            <div class="et bmj">

            </div>
        </div>
    </div>
</div>
                                    

    
                 
<script>
    
    
    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=eleccionTrabajadores';  
    }
    
    
    var numeroFilas=1;
    
    function eliminaFila(tabla) {
        
        
        if (numeroFilas>0){
            document.getElementById("tabla"+tabla).deleteRow(numeroFilas);
            numeroFilas=numeroFilas-1;
        }
        
    }
    
    
    function agregaFila(tabla) {
        numeroFilas=numeroFilas+1;
        var table = document.getElementById("tabla"+tabla);
        var row = table.insertRow(numeroFilas);
        
        <%  
            
            int numeroColumna=0;
            
            String filaValor="";
            idLista="";
            
            
            for (int i=0;i<requisicionesForm.length;i++){
                
                idLista=requisicionesForm[i][2];
                
                if (  requisicionesForm[i][2]!=null  &&   requisicionesForm[i][2].equals(idLista)){
                        
                    out.println("var cell"+numeroColumna+" = row.insertCell("+numeroColumna+");");

                        if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTexto)){
                            filaValor="<input type=\'text\' name=\'"+requisicionesForm[i][4]+"[]\' id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' class=\'col-md-12\' onkeyup=\'calcularTotales(event);\'     >";
                        }
                        if (requisicionesForm[i][3].equals(operaciones_servicio.tipoArchivo)){
                            filaValor="<input type=\'file\' name=\'"+requisicionesForm[i][4]+"[]\' id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' class=\'col-md-12\' onkeyup=\'calcularTotales(event);\'    >";
                        }
                        if (requisicionesForm[i][3].equals(operaciones_servicio.tipoNumero)){
                            filaValor="<input type=\'text\' name=\'"+requisicionesForm[i][4]+"[]\' id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' class=\'col-md-12\'  onkeyup=\'calcularTotales(event);\'   >";
                        }
                        if (requisicionesForm[i][3].equals(operaciones_servicio.tipoFecha)){
                            filaValor="<input type=\'date\' name=\'"+requisicionesForm[i][4]+"[]\' id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\'  class=\'col-md-12\'  onkeyup=\'calcularTotales(event);\'      >";
                        }
                        if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTextoLargo)){
                            filaValor="<textarea rows=\'4\' cols=\'50\'  name=\'"+requisicionesForm[i][4]+"[]\' id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\'  class=\'col-md-12\'  onkeyup=\'calcularTotales(event);\'   ></textarea>";
                        }
                        
                        if (requisicionesForm[i][3].equals(operaciones_servicio.catalogo)){
                            
                            
                            
                            
                            if (requisicionesForm[i][4].equals("personaAsistencia")){
                                filaValor="<div class=\'form-group\'>"+
                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'\'>"+
                                                    "<option value=\'\'></option>"+
                                                    empleadosCatalogo+
                                                "</select>"+
                                          "</div>";
                            }
                            
                            
                            if (requisicionesForm[i][4].equals("plantaAsistencia")){
                                filaValor="<div class=\'form-group\'>"+
                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'\'>"+
                                                    "<option value=\'\'></option>"+
                                                    LugaresLista+
                                                "</select>"+
                                          "</div>";
                            }
                            
                            if (requisicionesForm[i][4].equals("areaAsistencia")){
                                filaValor="<div class=\'form-group\'>"+
                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'\'>"+
                                                    "<option value=\'\'></option>"+
                                                    AreaLista+
                                                "</select>"+
                                          "</div>";
                            }
                            
                            
                            if (
                                      requisicionesForm[i][4].equals("H1") ||
                                                requisicionesForm[i][4].equals("H2") ||
                                                requisicionesForm[i][4].equals("H3") ||
                                                requisicionesForm[i][4].equals("H4") ||
                                                requisicionesForm[i][4].equals("H5") ||
                                                requisicionesForm[i][4].equals("H6") ||
                                                requisicionesForm[i][4].equals("H7") ||
                                                requisicionesForm[i][4].equals("H8") ||
                                                requisicionesForm[i][4].equals("H9") ||
                                                requisicionesForm[i][4].equals("H10") ||
                                                requisicionesForm[i][4].equals("H11") ||
                                                requisicionesForm[i][4].equals("H12") ||
                                                requisicionesForm[i][4].equals("H13") ||
                                                requisicionesForm[i][4].equals("H14") ||
                                                requisicionesForm[i][4].equals("H15") ||
                                                requisicionesForm[i][4].equals("H16") ||
                                                requisicionesForm[i][4].equals("H17") ||
                                                requisicionesForm[i][4].equals("H18") ||
                                                requisicionesForm[i][4].equals("H19") ||
                                                requisicionesForm[i][4].equals("H20") ||
                                                requisicionesForm[i][4].equals("H21") ||
                                                requisicionesForm[i][4].equals("H22") ||
                                                requisicionesForm[i][4].equals("H23") 
                                    
                          
                                    
                                    
                                    ){
                                filaValor="<div class='form-check'>"+
                                                "<input type='checkbox'   id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\'   >"+
                                            "</div>";
                            }
                            
                            
                        }
                  
                    out.println("cell"+numeroColumna+".innerHTML = \""+filaValor+"\"   ;  ");
                    
                    
                   
                    numeroColumna++;
                    

                }

                filaValor="";
                
            }
            
         
        %>
        
       
        
      
        
    }
    
    function validacion() {
        
        document.getElementById("submit_value").value = "Enviando...";
        document.getElementById("submit_value").disabled = true;
        
        var valido=1;
         
        
        
        
        var plantaAsistencia;
        var areaAsistencia;
        var personaAsistencia;
        
        
                                                
        
        for (var i = 1; i <= numeroFilas ; i++) { 
          
            plantaAsistencia=document.getElementById("plantaAsistencia_"+i).value ;  
            
            if (plantaAsistencia == ''){
                valido=0;
                alert("Por favor llena la Planta");
                break;
            }
            
            
            areaAsistencia=document.getElementById("areaAsistencia_"+i).value ;  
            
            if (areaAsistencia == ''){
                valido=0;
                alert("Por favor llena la Area");
                break;
            }
            
            personaAsistencia=document.getElementById("personaAsistencia_"+i).value ;  
            
            
            if (personaAsistencia == ''){
                valido=0;
                alert("Por favor llena la Persona");
                break;
            }
            
             
        }
        
        if (valido==1){
            document.getElementById("crearRegistroAsistencia").submit();
        }
        else{
            document.getElementById("submit_value").value = "Guardar";
            document.getElementById("submit_value").disabled = false;
        }
        
        
            
    }


    
    
    
    
</script>
                              


<jsp:include page="../pieDePagina.jsp" flush="true"/>