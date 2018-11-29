


<%@page import="serviciosBD.formatos_servicio"%>
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
                        <h3 class="bla blb">Formato de revisión de pruertas</h3>
                    </div>

          
              
                    <% String host=application.getInitParameter("host");  %>
                    <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                    <% Date fechaActual = new Date(); %>
                
                    <div class=row>
                         <br><br><br>
                    </div>
                    
                    
                    

                    <form id="crearRegistroFormato" action="Servlet?controlador=crearRegistroFormato" method = "post"  enctype = "multipart/form-data">
                        
                        
                        <input type="hidden" name="idUsuario" class="col-md-6"  value="<% out.print(idUsuario); %>" >

                        <%

                            
                           operaciones_servicio catalogo=new  operaciones_servicio();
                           String catalogoZona[][]=catalogo.listaCatalogoPorTipo("1");
                           
                           
                           String zonas="";
                           for (int i=0;i<catalogoZona.length;i++){
                               zonas=zonas+"<option value=\'"+catalogoZona[i][1]+"\'>"+catalogoZona[i][1]+"</option>";
                           }
                            
                           String catalogoTurno[][]=catalogo.listaCatalogoPorTipo("4");
                           String turno="";
                           for (int i=0;i<catalogoTurno.length;i++){
                               turno=turno+"<option value=\'"+catalogoTurno[i][1]+"\'>"+catalogoTurno[i][1]+"</option>";
                           }
                            
                           String catalogoLinea[][]=catalogo.listaCatalogoPorTipo("3");
                           String Linea="";
                           for (int i=0;i<catalogoLinea.length;i++){
                               Linea=Linea+"<option value=\'"+catalogoLinea[i][1]+"\'>"+catalogoLinea[i][1]+"</option>";
                           }
                          
                           String catalogoDefectos[][]=catalogo.listaCatalogoPorTipo("2");
                           String Defectos="";
                           for (int i=0;i<catalogoDefectos.length;i++){
                               Defectos=Defectos+"<option value=\'"+catalogoDefectos[i][1]+"\'>"+catalogoDefectos[i][1]+"</option>";
                           }
                            
                            
                            
                            
                        operaciones_servicio operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("13");

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
                                    plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"resta('"+requisicionesForm[i][4]+"');\" ><i class=\"fa fa-minus-square-o\" ></i> </a>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"   class=\"col-md-2\" value=\"0\" >";
                                    plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"suma('"+requisicionesForm[i][4]+"');\" ><i class=\"fa fa-plus-square\" ></i> </a>";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoFecha)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"date\" name=\""+requisicionesForm[i][4]+"\"   id=\""+requisicionesForm[i][4]+"\"        class=\"col-md-6\"    value=\""+ (new SimpleDateFormat("yyyy-MM-dd").format(fechaActual))  +"\"   readonly=\"readonly\"     >"; 
                                        
                                    
                                    

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.tipoTextoLargo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+"</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<textarea rows=\"4\" name=\""+requisicionesForm[i][4]+"\" id=\""+requisicionesForm[i][4]+"\"     cols=\"50\"  class=\"col-md-6\"  ></textarea>";

                                }
                                if (requisicionesForm[i][3].equals(operaciones_servicio.catalogo)){

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+ "</span>";
                                    
                                     if (requisicionesForm[i][4].equals("TurnoInspeccion")){
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-6\">"+
                                            "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                "<option value=\"\"></option>"+
                                                turno+
                                            "</select>"+
                                        "</div>";       
                                                
                                    }
                                 
                                    
                                    
                                    if (requisicionesForm[i][4].equals("LineaInspeccion")){
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-6\">"+
                                            "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                "<option value=\"\"></option>"+
                                                Linea+
                                            "</select>"+
                                        "</div>";       
                                                
                                    }
                                    
                                    if (requisicionesForm[i][4].equals("inspectorPuerta")){
                                        
                                        persona_servicio empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        
                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" class=\"col-md-6\" value=\""+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"\"  disabled >";
                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"hidden\" name=\"userName\" value=\""+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"\"  >";
                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"hidden\" name=\""+requisicionesForm[i][4]+"\" class=\"col-md-6\" value=\""+idUsuario+"\" >";
                                        
                                    }
                                    if (requisicionesForm[i][4].equals("PersonaReceptora")){
                                        
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
                                        plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-6\">"+
                                                                                "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                                                    "<option value=\"\"></option>"+
                                                                                    opciones+
                                                                                "</select>"+
                                                                            "</div>";
                                        
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
                                            
                                            if (requisicionesForm[j][3].equals(operaciones_servicio.catalogo)){
                                            
                                                
                                                if (requisicionesForm[j][4].equals("ZonaDefectoPuerta")){
                                                    valores=valores+"<div class=\"form-group col-md-12\">"+
                                                                                    "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"form-control\">"+
                                                                                        "<option value=\"\"></option>"+
                                                                                        zonas+
                                                                                    "</select>"+
                                                                                "</div>";
                                                }
                                               
                                                
                                                
                                                if (requisicionesForm[j][4].equals("DefectoPuerta")){
                                                    

                                                    
                                                    valores=valores+"<div class=\"form-group col-md-12\">"+
                                                                                    "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"form-control\">"+
                                                                                        "<option value=\"\"></option>"+
                                                                                        Defectos+
                                                                                    "</select>"+
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
                                plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-6\">";
                                plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-12 btn btn-white btn-md bla blb \" onclick=\"agregaFila("+requisicionesForm[i][2]+");\" >Agregar <i class=\"fa fa-plus-circle\" ></i> </a>";
                                plantillaDeTexto=plantillaDeTexto+ "</div>";
                                plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-6\">";
                                plantillaDeTexto=plantillaDeTexto+"<div class=\"col-md-2\"></div>";
                                plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-12 btn btn-white btn-md bla blb \" onclick=\"eliminaFila("+requisicionesForm[i][2]+");\" >Eliminar <i class=\"fa fa-remove\" ></i></a>";
                                plantillaDeTexto=plantillaDeTexto+ "</div>";
                            }


                        }

                        out.print(plantillaDeTexto);

                        %>

                        
                        
                        <div class=row>
                            <br><br><br>
                        </div>
                        <div class="col-md-6 text-left">
                            <a href='Servlet?controlador=formatoRevisionPuertas' class="btn btn-white btn-md bla blb">Cancelar</a>
                        </div>

                        <div class="col-md-6 text-right">
                            <input type="button" class="btn btn-white btn-md bla blb" name="Guardar" id="submit_value" value="Guardar" onclick="validacion()"/>
                        </div>

                        <% out.println("</div>"); %>

                    </form>
                        
                        <hr>
                        
                        
                        
                        <div class="container">
                            <h2>Ultimos Registros</h2>
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Fecha Inspeccion</th>
                                        <th>Hora de Registro</th>
                                        <th>Inspector</th>
                                        <th>Número de Parte</th>
                                        <th>Turno</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    
                                    <%

                                        formatos_servicio formatoServicio = new formatos_servicio();
                                        String formatoRevision[][]=formatoServicio.listaRevisionesDePuertas(idUsuario);


                                        for (int i=0;i<formatoRevision.length;i++){ %>
                                            <tr>
                                                <td><% 
                                                    out.println(formatoRevision[i][1]); 
                                                %></td>
                                                <td><% 
                                                    out.println(formatoRevision[i][2]); 
                                                %></td>
                                                <td><% 
                                                    out.println(formatoRevision[i][3]); 
                                                %></td>
                                                <td><% 
                                                    out.println(formatoRevision[i][4]); 
                                                %></td>
                                                <td><% 
                                                    out.println(formatoRevision[i][5]); 
                                                %></td>
                                                <td>
                                                    <a href='javascript:;' class="btn btn-white btn-md bla blb" >Borrar </a>
                                                </td>
                                            </tr>
                                        <% }

                                    %>
                                    
                                    
                                    
                                    
                                    
                                </tbody>
                            </table>
                        </div>

                        
                       
                        
                      

         </div>   
        
   </div>
</div>



                
                
<script>


    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=formatoRevisionPuertas';  
    } 

    function ponerReadOnly(id)
    {
        // Ponemos el atributo de solo lectura
        $("#"+id).attr("readonly","readonly");
        // Ponemos una clase para cambiar el color del texto y mostrar que
        // esta deshabilitado
        // $("#"+id).addClass("readOnly");
    }
 
    function quitarReadOnly(id)
    {
        // Eliminamos el atributo de solo lectura
        $("#"+id).removeAttr("readonly");
        // Eliminamos la clase que hace que cambie el color
        // $("#"+id).removeClass("readOnly");
    }
 


    $(document).ready(function(){
    
        document.getElementById("NumeroPartePuertaInspeccion").focus();
        
        ponerReadOnly("HoraInspeccion");
        ponerReadOnly("fechaPuertaInspeccion");
    
        new_clock();
        
        
    }); 


    function new_clock(){ 
        
       

        var clock = new Date();
        var hour =   clock.getHours(); 
        var minutes = clock.getMinutes();
        var seconds = clock.getSeconds();

        
        var formattedHour = ("0" + hour).slice(-2);
        var formattedMinutes = ("0" + minutes).slice(-2);
        var formattedSeconds = ("0" + seconds).slice(-2);


        var print_clock =   formattedHour + ":" + formattedMinutes + ":" + formattedSeconds; 

        document.getElementById("HoraInspeccion").value = print_clock;
        setTimeout(new_clock, 1000);
    
    }


    

    function validacion() {
        
        document.getElementById("submit_value").value = "Enviando...";
        document.getElementById("submit_value").disabled = true;
        
         var valido=1;
         
         
        var TurnoInspeccion = document.getElementById("TurnoInspeccion").value;
        
        if (TurnoInspeccion == '' ){
            valido=0;
            alert("Por favor llena el turno");
        }
        
        var LineaInspeccion = document.getElementById("LineaInspeccion").value;
        
        if (LineaInspeccion == '' ){
            valido=0;
            alert("Por favor selecciona la linea");
        }
        
        var NumeroPartePuertaInspeccion = document.getElementById("NumeroPartePuertaInspeccion").value;
          
        if (NumeroPartePuertaInspeccion == '' ){
            valido=0;
            alert("Por favor llena la numero de parte");
        }
        
        var TotalInspeccionPuerta = document.getElementById("TotalInspeccionPuerta").value;
          
        if (TotalInspeccionPuerta == '' || TotalInspeccionPuerta == '0' ){
            valido=0;
            alert("Por favor llena la Total Inspeccion, debe ser mayor que 0");
        }
        
        
        
        var evidencia;
        var defecto;
        
        
        for (var i = 1; i <= numeroFilas ; i++) { 
            evidencia=document.getElementById("ZonaDefectoPuerta_"+i).value ;  
            defecto=document.getElementById("DefectoPuerta_"+i).value ;  
            
            
            if (evidencia == ''){
                valido=0;
                alert("Por favor llena el defecto");
                break;
            }
            
            if (defecto == ''){
                valido=0;
                alert("Por favor llena la zona del defecto ");
                break;
            }
            
            
             
        }
        
        
        
        
        
        if (valido==1){
            document.getElementById("crearRegistroFormato").submit();
        }
        else{
            document.getElementById("submit_value").value = "Guardar";
            document.getElementById("submit_value").disabled = false;
        }
        
        
            
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
                                
                            
                            
                            if (requisicionesForm[i][4].equals("ZonaDefectoPuerta")){



                                filaValor="<div class=\'form-group col-md-12\'>"+
                                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'form-control\'>"+
                                                                    "<option value=\'\'></option>"+
                                                                    zonas+
                                                                "</select>"+

                                                            "</div>";
                            }

                            if (requisicionesForm[i][4].equals("DefectoPuerta")){

                                

                                filaValor="<div class=\'form-group col-md-12\'>"+
                                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'form-control\'>"+
                                                                    "<option value=\'\'></option>"+
                                                                    Defectos+
                                                            "</select>"+
                                                        "</div>";

                            }


                            
                            
                            
                            
                            
                           
                        }

                    out.println("cell"+numeroColumna+".innerHTML = \""+filaValor+"\"   ;  ");
                    numeroColumna++;
                    

                }

            }
            
         
        %>
        
       
        
      
        
    }



    function resta(nombreHTML) {
        
        var valor=document.getElementById(nombreHTML).value;
        
        if (valor != 0){
            valor=valor-1;
            document.getElementById(nombreHTML).value=valor;    
        }
        
        
    }

    function suma(nombreHTML) {
        
       var valor=document.getElementById(nombreHTML).value;
       valor=parseInt(valor)+1;
       document.getElementById(nombreHTML).value=valor;
        
    }


</script>


<jsp:include page="../pieDePagina.jsp" flush="true"/>