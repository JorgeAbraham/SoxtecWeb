



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
                        <h3 class="bla blb">ORDEN DE COMPRA</h3>
                    </div>

          
              
                    <% String host=application.getInitParameter("host");  %>
                    <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                    <% Date fechaActual = new Date(); %>
                
                    <div class=row>
                         <br><br><br>
                    </div>
                    
                    
                    

                    <form id="crearOrdenDeCompra" action="Servlet?controlador=crearOrdenDeCompra" method = "post"  enctype = "multipart/form-data">
                        
                        
                        <input type="hidden" name="idUsuario" class="col-md-6"  value="<% out.print(idUsuario); %>" >

                        <%

                        operaciones_servicio operacion = new operaciones_servicio();
                        String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("1");

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

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+ "</span>";
                                    if (requisicionesForm[i][4].equals("UsuarioP")){
                                        
                                        persona_servicio empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        
                                        plantillaDeTexto=plantillaDeTexto+"<input type=\"text\"  class=\"col-md-6\" value=\""+empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()+"\"  disabled >";
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

                        
                        
                        <div class=row>
                            <br><br><br>
                        </div>
                        <div class="col-md-6 text-left">
                            <a href='Servlet?controlador=requisiciones' class="btn btn-white btn-md bla blb">Cancelar</a>
                        </div>

                        <div class="col-md-6 text-right">
                            <input type="button" class="btn btn-white btn-md bla blb" name="Guardar" id="submit_value" value="Guardar" onclick="validacion()"/>
                        </div>

                        <% out.println("</div>"); %>

                    </form>
           
              

         </div>   
        
   </div>
</div>

<div id="docsModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Example modal</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <p>You're looking at an example modal in the dashboard theme.</p>
            </div>
            <div class="om">
                <button type="button" class="ce kh" data-dismiss="modal">Cool, got it!</button>
            </div>
        </div>
    </div>
</div>

                
                
<script>


    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=crearRequisicion';  
    } 

    

    function validacion() {
        var desc = document.getElementById("DescRazon").value;
        var total = document.getElementById("Total").value;
        var persona = document.getElementById("PersonaReceptora").value;
        
        
        
        
        var valido=1;
        if (desc == '' ){
            valido=0;
            alert("Por favor llena la Descripción");
        }
        
        
        
        if (persona == '' ){
            valido=0;
            alert("Por favor selecciona el Responsable");
        }
        
        var cantidad;
        var descripcionArticulo;
        var precioUnitario;
        var importe;
        
        for (var i = 1; i <= numeroFilas ; i++) { 
            cantidad=document.getElementById("Cantidad_"+i).value ;  
            descripcionArticulo=document.getElementById("DescripcioDeAriculo_"+i).value ;  
            precioUnitario=document.getElementById("PrecioUnitario_"+i).value ;  
            importe=document.getElementById("Importe_"+i).value ;  
            
            if (cantidad == ''){
                valido=0;
                alert("Por favor llena la Cantidad del articulo");
                break;
            }
            
            if (descripcionArticulo == ''){
                valido=0;
                alert("Por favor llena la Descripcion del articulo");
                break;
            }
            
            if (precioUnitario == ''){
                valido=0;
                alert("Por favor llena el Precio Unitario del articulo");
                break;
            }
            
            if (importe == ''){
                valido=0;
                alert("Por favor llena el Precio Unitario del articulo");
                break;
            }
            
             
        }
        
        if (total == '' ){
            valido=0;
            alert("Por favor llena el Total");
        }
        
        
        
        if (valido==1){
            document.getElementById("crearOrdenDeCompra").submit();
        }
        
        
            
    }



    function calcularTotales(e){
        
        var elemento=e.srcElement.id;
        var res = elemento.split("_");
            
        var valor_numerico=isNaN(   document.getElementById(elemento).value  );
        
        if (elemento=="Cantidad_"+res[1] ||  elemento=="PrecioUnitario_"+res[1]  ){
            
            if (!valor_numerico){
                
                document.getElementById("Importe_"+res[1]).value = document.getElementById("PrecioUnitario_"+res[1]).value * document.getElementById("Cantidad_"+res[1]).value;
                document.getElementById(elemento).value
                
            }else{
                document.getElementById(elemento).value = "0";
            }
            
        }
        
        
        
        var valorSubtotal=0;
        for (var i = 1; i <= numeroFilas ; i++) { 
            valorSubtotal=Number(valorSubtotal)+Number(   document.getElementById("Importe_"+i).value  ) ;  
        }
        
         document.getElementById("Total").value = valorSubtotal;
        
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

                    out.println("cell"+numeroColumna+".innerHTML = \""+filaValor+"\"   ;  ");
                    numeroColumna++;
                    

                }

            }
            
         
        %>
        
       
        
      
        
    }



</script>


<jsp:include page="../pieDePagina.jsp" flush="true"/>