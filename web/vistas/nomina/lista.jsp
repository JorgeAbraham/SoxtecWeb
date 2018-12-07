


<%@page import="java.util.Calendar"%>
<%@page import="libreriaApoyo.tablaHtml"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.ArrayList"%>
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
                <h3 class="bla blb">Nomina</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                
                <% float NominaTotal=0;  %>
                
                
                <% 
                    Calendar calendar = Calendar.getInstance();
                    
                    //calendar.set(Calendar.YEAR, 2018); // set the year
                    //calendar.set(Calendar.MONTH, 0); // set the month
                    //calendar.set(Calendar.DAY_OF_MONTH, 6); // set the day
                    
                    int numberYear = calendar.get(Calendar.YEAR);
                    int numberWeekOfYear = calendar.get(Calendar.WEEK_OF_YEAR);
                    int numberDayOFWeek = calendar.get(Calendar.DAY_OF_WEEK)-1;
                    
                    if (numberDayOFWeek == 6 || numberDayOFWeek == 0  ){  //Si es sabado o domingo se aumenta 1
                        
                        numberWeekOfYear=numberWeekOfYear+1;
                        
                    }


                %>
                        
                
                
                
                
                <%
                
                    //Fragmento de Codigo para traer la informacion de la nomina de esta semana
                    
                    operaciones_servicio operacionNomina = new operaciones_servicio();
                                    
                    ArrayList<String> tipoOperacionNomina=new ArrayList();
                    tipoOperacionNomina.add("22");
                    

                    ArrayList<String> estadosOperacionNomina=new ArrayList();
                    estadosOperacionNomina.add("19");
                    estadosOperacionNomina.add("24");
                    

                    ArrayList<String> idConceptoNomina=new ArrayList();
                    idConceptoNomina.add("124");
                    idConceptoNomina.add("125");
                    idConceptoNomina.add("126");
                    idConceptoNomina.add("127");


                    String  nombre="nombreCompleto.NombresCompletos";
                    String  condicion=" LEFT JOIN 	(            "
                                                            + "   SELECT o.idOperacion,  coA.valorTexto, CONCAT(p.apellidoPaterno,' ',p.apellidoMaterno,' ',p.nombre) as NombresCompletos "
                                                            + "   FROM Operacion o    "
                                                            + "    INNER JOIN pertenenciadevalores pvA on (o.idOperacion=pvA.idOperacion)      "
                                                            + "    INNER JOIN concepto cA on cA.idConcepto = pvA.idConcepto   AND  (cA.idConcepto=127 )      "
                                                            + "    INNER JOIN conceptooperacion coA on coA.idConceptoOperacion = pvA.idConceptoOperacion   "
                                                            + "    INNER JOIN persona p on p.idPersona=coA.valorTexto "
                                                    + "   ) AS nombreCompleto  ON o.idOperacion  =  nombreCompleto.idOperacion    ";


                    String req[][]=operacionNomina.listaOperacionesConcatenadas(idConceptoNomina,estadosOperacionNomina,tipoOperacionNomina,nombre,condicion,1," AND valor1="+numberWeekOfYear+"    AND valor2="+numberYear+"   ");
                
                    /*
                        for (int i=0;i<req.length;i++){
                            for (int j=0;j<req[0].length;j++){
                                out.println("["+i+"]["+j+"]");
                                out.println(req[i][j]);
                            }
                        }
                    */
                    
                %>
                

                
                <%
                
                    //Fragmento de Codigo para traer la informacion de la nomina de esta semana CONCEPTOS
                    
                    operaciones_servicio operacionNominaConceptos = new operaciones_servicio();
                                    
                    ArrayList<String> tipoOperacionNominaConceptos=new ArrayList();
                    tipoOperacionNominaConceptos.add("22");

                    ArrayList<String> estadosOperacionNominaConceptos=new ArrayList();
                    estadosOperacionNominaConceptos.add("19");
                    estadosOperacionNominaConceptos.add("24");
                    
                    ArrayList<String> idConceptoNominaConceptos=new ArrayList();
                    ArrayList<Boolean> idConceptoNominaConceptosLista=new ArrayList();
                    idConceptoNominaConceptos.add("124"); idConceptoNominaConceptosLista.add(false);
                    idConceptoNominaConceptos.add("125"); idConceptoNominaConceptosLista.add(false);
                    idConceptoNominaConceptos.add("126"); idConceptoNominaConceptosLista.add(false);
                    
                    idConceptoNominaConceptos.add("128"); idConceptoNominaConceptosLista.add(true);
                    idConceptoNominaConceptos.add("129"); idConceptoNominaConceptosLista.add(true);
                    idConceptoNominaConceptos.add("130"); idConceptoNominaConceptosLista.add(true);
                    idConceptoNominaConceptos.add("131"); idConceptoNominaConceptosLista.add(true);

                    String reqConceptos[][]=operacionNominaConceptos.listaOperacionesConcatenadas(idConceptoNominaConceptos,estadosOperacionNominaConceptos,tipoOperacionNominaConceptos,"","",0," AND valor1="+numberWeekOfYear+"    AND valor2="+numberYear+"   ",idConceptoNominaConceptosLista);
                
                    
                    
                %>
                
                
                
                <%
                
                persona_servicio empleados = new persona_servicio();
                    
                String opciones="";  //List Completa
                String opcionesFaltantes="";  //Lista de Faltantessin la nomina
                String opcionesYaSeleccionadas="";  //Lista de Faltantessin la nomina
                
                
                
                String empleado[][]=empleados.LISTAempleadosEstadoActivoString(empleados.ALTA);
               
                empleado=empleados.LISTAEmpleadosPorStringYSinAsignar(" v.valorTexto='ingresado'  OR  v.valorTexto='alta'     OR   v.valorTexto='sinDefinir'   OR   v.valorTexto='paroTecnico'   ");
                boolean encontrado;
                
                
                for (int j=0;j<empleado.length;j++){
                    
                    opciones = opciones + "<option value=\"" + empleado[j][1] + "\">" + empleado[j][0] + "</option>";
                
                    
                    encontrado=false;
                    for (int k=0;k<req.length;k++){
                        
                        
               
                        if(req[k][8].equals(empleado[j][1])){
                          
                            encontrado=true;
                            break;
                        }
                    }

                        
                    if (encontrado==false){
                        opcionesFaltantes = opcionesFaltantes  + "<option value=\"" + empleado[j][1] + "\">" + empleado[j][0] + "</option>";
                        
                    }else{
                        opcionesYaSeleccionadas = opcionesYaSeleccionadas  + "<option value=\"" + empleado[j][1] + "\"  disable >" + empleado[j][0] + "</option>";
                    }
                    
                    
                
                }
   




                %>
                
            </div>    
            
             
            <i class="fa fa-users" style="font-size:48px;"> </i>
            <h3 >Semana <% out.print(numberWeekOfYear+"  "+numberYear);%></h3>
            <hr>
                <a href="https://1drv.ms/f/s!An8j2SVNtbXyg3VMmvtLyU1elK0N">Descargar informe completo [PDF]</a>
            
            
            <hr>
                
                <h3 >Tabla de Horas</h3><button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Mostrar<span class="caret"></span></button>
                <div class="dropdown-menu">
                    
                    <table   class="table table-responsive table-striped"    >
                        <thead>
                            <tr>

                                <th class="header">Lugar</th>
                                <th class="header">Costo Hora Normal</th>
                                <th class="header">Costo (48 Horas)</th>
                                <th class="header">Hora Extra Doble</th>
                                <th class="header">Hora Extra Triple</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 



                                lugar_servicio L = new lugar_servicio();
                                String lugares[][]=L.listaLugares();





                                operaciones_servicio operacion2 = new operaciones_servicio();

                                ArrayList<String> tipoOperacion=new ArrayList();
                                tipoOperacion.add("23");

                                ArrayList<String> estadosOperacion=new ArrayList();
                                estadosOperacion.add("19");
                                estadosOperacion.add("24");


                                ArrayList<String> idConcepto=new ArrayList();
                                idConcepto.add("132");
                                idConcepto.add("133");
                                idConcepto.add("134");
                                idConcepto.add("135");
                                idConcepto.add("136");


                                String requisiciones[][]=operacion2.listaOperacionesConcatenadas(idConcepto,estadosOperacion,tipoOperacion);

                                DecimalFormat formatea = new DecimalFormat("###,###.00");


                                for (int i=0;i<requisiciones.length;i++){%>
                                <tr>
                                    <%

                                        for (int j=0;j<lugares.length;j++){

                                            if (lugares[j][0].equals(requisiciones[i][6])){

                                                out.println("<td>"+lugares[j][1]+"</td>");
                                                break;
                                            }



                                        }


                                        out.println("<td>$ "+formatea.format(Float.parseFloat(requisiciones[i][7]))+"</td>");
                                        out.println("<td><b>$ "+formatea.format((Float.parseFloat(requisiciones[i][7])*48))+"</b></td>");
                                        out.println("<td><b>$ "+formatea.format(Float.parseFloat(requisiciones[i][8]))+"</b></td>");
                                        out.println("<td><b>$ "+formatea.format(Float.parseFloat(requisiciones[i][9]))+"</b></td>");


                                    %>

                                <%}%>
                                </tr>
                        </tbody>
                    </table>
                    
                </div>
            
            <div class="row">
                <hr>
                <a href="Servlet?controlador=imprimeReciboTotal&sem=<%out.print(numberWeekOfYear);%>&anio=<%out.print(numberYear);%>"  class="btn btn-primary"  target="_blank" >Formato de pago bancario<i class="fa fa-print" ></i></a>
            </div>
            
            
            <hr class="aav">
                
            <div class="card-body text-primary">

                    

                        
                        
                    <h3>Agrega Pago Manualmente</h3>

                    <br>

                    <form id="crearRegistroNomina" action="Servlet?controlador=registroNomina" method = "post"  enctype = "multipart/form-data">


                         <input type="hidden" name="idUsuario" class="col-md-6"  value="<% out.print(idUsuario); %>" >

                        <%

                           

                           



                            catalogo_servicio C = new catalogo_servicio();
                            String conceptos[][]=C.listaPorTipoCatalogo(16); 
                            String conceptosLista="";
                            for (int i=0;i<conceptos.length;i++){  
                                conceptosLista=conceptosLista+"<option value=\'"+conceptos[i][0]+"\'>"+conceptos[i][1]+"</option>";
                            }  


                            operaciones_servicio operacion = new operaciones_servicio();
                            String requisicionesForm[][]=operacion.listaOperacionesBasePorTipo("22");

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


                                        plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-6\">"+requisicionesForm[i][1]+ "</span>";
                                        plantillaDeTexto=plantillaDeTexto+("<a href=\"#selecccionaEmpleadoModal\"  class=\"btn btn-info col-md-6\" data-toggle=\"modal\">Seleccionar Persona <i class=\"fa fa-filter\" ></i></a>");
                                            
                                        
                                        if (requisicionesForm[i][4].equals("personaNomina")){

                                            
                                            plantillaDeTexto=plantillaDeTexto+"<div class=\"form-group col-md-12\"  onchange=\"cambiarComboPersona()\"   >"+
                                                                                    "<select id=\""+requisicionesForm[i][4]+"\" name=\""+requisicionesForm[i][4]+"\" class=\"form-control\">"+
                                                                                        "<option value=\"\"></option>"+
                                                                                        opcionesFaltantes+
                                                                                    "</select>"+
                                                                                "</div>";
                                            
                                            plantillaDeTexto=plantillaDeTexto+"<div id=\"valoresPersona\"></div>";

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



                                                    if (requisicionesForm[j][4].equals("conceptoNomina")){
                                                                valores=valores+"<div class=\"form-group\">"+
                                                                                                "<select id=\""+requisicionesForm[j][4]+"_1\" name=\""+requisicionesForm[j][4]+"[]\" class=\"\"  onchange=\"cambiarComboConcepto("+j+")\"    >"+
                                                                                                    "<option value=\"\"></option>"+
                                                                                                    conceptosLista+
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

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-8\">Horas Totales</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\"horasTotal\"  id=\"horasTotal\"   class=\"col-md-4\"   >";

                                    plantillaDeTexto=plantillaDeTexto+"<span class=\"col-md-8\">Total</span>";
                                    plantillaDeTexto=plantillaDeTexto+"<input type=\"text\" name=\"costoTotal\"  id=\"costoTotal\"   class=\"col-md-4\"   >";

                                    plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"agregaFila("+requisicionesForm[i][2]+");\" >Agregar <i class=\"fa fa-plus-circle\" ></i> </a>";
                                    plantillaDeTexto=plantillaDeTexto+"<div class=\"col-md-8\"></div>";
                                    plantillaDeTexto=plantillaDeTexto+"<a href='javascript:;' class=\"col-md-2  btn btn-white btn-md bla blb \" onclick=\"eliminaFila("+requisicionesForm[i][2]+");\" >Eliminar <i class=\"fa fa-remove\" ></i></a>";

                                }


                            }

                            out.print(plantillaDeTexto);

                        %>


                        <div class="container">

                            <div class="row">
                                
                                <a  name="Guardar" class="btn btn-secondary col-md-12" id="submit_value" onclick="validacion()"  ><i class="fa fa-caret-square-o-down" aria-hidden="true"></i>Guardar en la lista de Nomina<i class="fa fa-save" ></i> <i class="fa fa-caret-square-o-down" aria-hidden="true"></i></a>
                                
                  

                            </div>  
                           

                            
                        </div>

                    </form>
            
                </div></div></div>
            
        </div>

        <hr>
             
        
        
        
        
        
      

                      
                                <% 
                                    
                                    String estado="";
                                    String estadoTexto="";
                                    String idEstadoContrario="";
                                    String colorContrario="";
                                    String estadoBoton="";
                                    String square="";
                                    
                                    
                                    for (int i=0;i<req.length;i++){%>
                                        
                                        <%
                                        if (req[i][1].equals("19")){
                                            estado="success";
                                            estadoTexto="Sin Verificar";
                                            idEstadoContrario="24";
                                            colorContrario="primary";
                                            estadoBoton="Verificar";
                                            square="square-o";
                                                    
                                        }
                                        if (req[i][1].equals("24")){
                                            estado="primary";
                                            estadoTexto="Vericado";
                                            idEstadoContrario="19";
                                            colorContrario="success";
                                            estadoBoton="Desverificar";
                                            square="check-square-o";
                                        }
                                        
                                        %>  
                                           
                                        <div class="card border-success mb-3" >

                                            <div class="card-header">

                                                <div class="text-left">
                                                 
                                                    
                                                    Registro: <%   out.println( req[i][0] + "    [ "+  req[i][2].substring(0,10) +" ]"  );%>
                                                    
                                                     
                                                </div>
                                                <div class="text-right">
                                                 
                                                    <%   out.println( estadoTexto  );%> :
                                                    <a href="Servlet?controlador=verificaRegistroNomina&idRegistroNominaVerifica=<% out.println(req[i][0]); %>&verificaEstadoID=<%out.println(idEstadoContrario);%>" class="btn btn-<%out.println(colorContrario);%>" ><%out.println(estadoBoton);%> <i class="fa fa-<%out.println(square);%>"></i></a>
                                                    
                                                    
                                                     
                                                </div>


                                            </div>


                                            <div class="card-body text-<% out.println(estado); %>">





                                                <h1 class="card-title"><% out.println(req[i][9]/*.toUpperCase() */  );%></h1>
                                              


                                                
                                                <table class="table">
                                                    <thead class="thead-dark">
                                                        <tr>
                                                        
                                                           <th scope="col">Descripción</th>
                                                           <th scope="col">Cantidad</th>
                                                           <th scope="col">Importe</th>
                                                        </tr>
                                                    </thead>
                                                <tbody>
                                                    
                                   
                                                    
                                                    <%
                                                        
                                                        float Cantidad=0;
                                                        
                                                        
                                                        
                                                        for (int j=0;j<reqConceptos.length;j++){
                                                            String color="";
                                                            if (req[i][0].equals(reqConceptos[j][0])){ 

                                                                Cantidad=Cantidad+ Float.parseFloat(reqConceptos[j][11]);
                                                            
                                                                if (Float.parseFloat(reqConceptos[j][11])<0){
                                                                    color="class=\"table-danger\"";
                                                                }
                                                    
                                                            %>
                                                            
                                                            
                                                            
                                                            
                                                            <tr <% out.println(color); %> >
                                                                
                                                                <td><% out.println(reqConceptos[j][9]);  %></td>
                                                                <td><% out.println(reqConceptos[j][10]);  %></td>
                                                                <td><% out.println(reqConceptos[j][11]);  %></td>
                                                            </tr>
                                                            
                                                            
                                                            
                                                        <%  }
                                                           
                                                        }

                                                         NominaTotal=NominaTotal+Cantidad;

                                                    %>            
                                                    
                                                    
                                                    
                                                    
                                                    </tbody>
                                                </table>
                                                 <h1 class="text-right">Total $ <% out.println(Cantidad); %></h1>
                                            </div>


                                            <div class="card-footer bg-transparent border-success">

                                                <div class="text-right">
                                                    
                                                    <a href="#editaRegistroDeNominaModal"  class="btn btn-secondary" onclick="abreModalEdicion( <% out.print(req[i][0]); %> )"  data-toggle="modal" >Editar <i class="fa fa-edit" ></i></a>
                                                    <% if (req[i][1].equals("24")){ %>
                                                        <a href="Servlet?controlador=imprimeRecibo&op=<% out.print(req[i][0]);%>&sem=<%out.print(numberWeekOfYear);%>&anio=<%out.print(numberYear);%>"  class="btn btn-primary"  target="_blank" >Imprimir <i class="fa fa-print" ></i></a>
                                                    <% } %>
                                                    <a href="#borrarRegistroDeNominaModal"  class="btn btn-danger" onclick="borraRegistroDatos( <% out.print(req[i][0]); %> ,'<% out.print(req[i][9]/*.toUpperCase() */  ); %>'    )"   data-toggle="modal">Borrar <i class="fa fa-trash" ></i></a>
                                                
                                                </div>

                                            </div>

                                        </div>
                                           
                                        
                                    <%}%>
                             
                                    
                                    
                
                                    
                                    
                <div class="container">
                 
             
                    <div class="row">
                        <h1 class="col-md-12"><span>Nomina Total $<input type="text" name="totalNomina" id="totalNomina" class="col-md-6" value="<%  out.println(NominaTotal); %>"  disabled="true" ></span></h1>
                        
                    </div>     
             
                </div>
                                    
                
    </div>
</div>
            



<div id="selecccionaEmpleadoModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        
                        
                        <span class="col-md-12">Lugar</span>
                        <br>
                        <select id="lugarSeleccion" name="lugarSeleccion" class="form-control col-md-12" >
                            <option value="" selected disable>Selecciona Lugar</option>
                            
                            <%
                                
                            L = new lugar_servicio();
                            String lugaresSeleccion[][]=L.listaLugares();    
                                
                            for (int j=0;j<lugaresSeleccion.length;j++){
                                out.println("<option value=\""+lugaresSeleccion[j][0]+"\" >"+lugaresSeleccion[j][1]+"</option>");
                            }
                            %>
                  
                        </select>
                        
                        
                        <span class="col-md-12">Buscar</span>
                        <br>
                        <input type="text" class="col-md-8 " id="buscarFiltro" name="buscarFiltro">
                        <input type="button" class="btn btn-md btn-info col-md-3 "  id="botonBuscarPersona" value="Buscar" onclick="buscaEmpleado()"/>
                       
                        
                        
                        
                        
                        
                        <select id="SeleccionarSinNomina" name="SeleccionarSinNomina" class="mdb-select md-form col-md-12" size="10" >
                            <% out.println(opcionesFaltantes); %>
                            
                        </select>
                        
                        
                        <hr>
                        
                        <span class="col-md-12  text-success">Ya en nomina</span>
                        <select id="SeleccionarNomina" class="mdb-select md-form col-md-12" size="10" disabled>
                            <% out.println(opcionesYaSeleccionadas); %>
                        </select>
                        
                    </div>

                    <input type="hidden" id="idRegistroNomina" name="idRegistroNomina" value="" />
                    
                    <hr>
                    
                    <a  name="selecciona" class="btn btn-info col-md-12" data-dismiss="modal" onclick="seleccionado()"  >Selecciona <i class="fa fa-hand-o-up" aria-hidden="true"></i> </a>
                    <br>
                    <button type="button" class="btn btn-secondary col-md-12" data-dismiss="modal">Cancelar</button>
                    

                </div>
                
        </div>
    </div>
</div> 
                    
                





<div id="editaRegistroDeNominaModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                 <a class="close"  href="Servlet?controlador=verListaDeNomina">×</a>
               
            </div>
            
            <form id="editaRegistroNominaForm" action = "Servlet?controlador=editaRegistroNomina" method = "post" enctype = "multipart/form-data"  >
                
                
                 <input type="hidden" name="idUsuarioEditar" class="col-md-6"  value="<% out.print(idUsuario); %>" >
                
                <div class="modal-body">
                    <div id="textoEditaRegistroNomina"></div>
                </div>
                <div class="om">
                    <a class="btn btn-md btn-link" href="Servlet?controlador=verListaDeNomina">Cancelar</a>
                    <input type="button" class="btn btn-md btn-warning"  id="botonEditarRegistroNomina" value="Editar" onclick="checkSubmitEditar()"/>
                </div>
            </form>
        </div>
    </div>
</div> 
                    
                    
                    
                        
<div id="borrarRegistroDeNominaModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="borrarRegistroNominaForm" action = "Servlet?controlador=borrarRegistroNomina" method = "post" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Desea Borrar el Registro De Nomina: </span>
                        <input type="text"  class="col-md-12" id="nombreNominaBorrar" name="nombreNominaBorrar" value=""  disabled />
                       
                    </div>

                    <input type="hidden" id="idRegistroNominaBorrar" name="idRegistroNominaBorrar" value="" />
                    
                   


                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type="button" class="btn btn-md btn-danger"  id="botonElimintarRegistroNomina" value="Eliminar" onclick="checkSubmit()"/>
                </div>
            </form>
        </div>
    </div>
</div>       
                     
                 
<script>
    
    
    //Se va declarar un arreglo de precios para hacer los calculos
    var precios = new Array(<%out.println(requisiciones.length);%>);
    
    
    $(document).ready(function(){
    
    
        


    
        var semana=new Date().getWeekNumber()
        var diaSemana=new Date().getDay();
    
        if (  diaSemana == 6  || diaSemana == 7   ){
            
            if (semana!=52){
                semana=semana+1;
            }
            
        }
        
        
        document.getElementById("SemanaNomina").value = semana;
        document.getElementById("anioNomina").value =  new Date().getFullYear();
        
        eliminaFila("5");
        
        
        
        //Se meten los valores en el arreglo
          
        <%
            for (int i=0;i<requisiciones.length;i++){
        %>
                precios[<%   out.println(i);  %>] = new Array(5);
        <%
                out.println("precios["+i+"][0]="+requisiciones[i][6]); //Lugar
                out.println("precios["+i+"][1]="+requisiciones[i][7]); //Horas Nomrales
                out.println("precios["+i+"][2]="+requisiciones[i][8]); //Extra Dobles
                out.println("precios["+i+"][3]="+requisiciones[i][9]); //Extra Triples
                out.println("precios["+i+"][4]=\""+requisiciones[i][5]+"\""); //Descripcion
                
                
            }       
        %>
        
        
      
        
        
    }); 
    
    
    function seleccionado(){
    
    
    
        var seleccion=document.getElementById("SeleccionarSinNomina").value ;
        
        
        $("#personaNomina").val(seleccion);
    
    
        cambiarComboPersona();
    }
    
    function borraRegistroDatos(idRegistro,nombre){
        
        
        
        document.getElementById("idRegistroNominaBorrar").value = idRegistro;
        document.getElementById("nombreNominaBorrar").value = nombre;
        
        
        
    }
    
    function checkSubmit() {
        
        
       
        document.getElementById("botonElimintarRegistroNomina").value = "Enviando...";
        document.getElementById("botonElimintarRegistroNomina").disabled = true;
        document.getElementById("borrarRegistroNominaForm").submit();
              
        
              
        return true;
    }
    
    function checkSubmitEditar() {
        
        
        
        document.getElementById("botonEditarRegistroNomina").value = "Enviando...";
        document.getElementById("botonEditarRegistroNomina").disabled = true;            
     
        
        var valido=1;
         
        
        var v1 = document.getElementById("fechaNomina").value;
        if (v1 == '' ){
            valido=0;
            alert("Por favor llena la Fecha de la Nomina");
        }
        
        var v2 = document.getElementById("SemanaNomina").value;
        if (v2 == '' ){
            valido=0;
            alert("Por favor llena la Semana de la Nomina");
        }
        
        var v3 = document.getElementById("anioNomina").value;
        if (v3 == '' ){
            valido=0;
            alert("Por favor llena el Año de la Nomina");
        }
        
      
        
        
        
        var var1;
        var var2;
        var var3;
        
        
        
                                                
        
        for (var i = 1; i <= numeroFilas ; i++) { 
          
            var1=document.getElementById("conceptoNomina_"+i).value ;  
            
            if (var1 == ''){
                valido=0;
                alert("Por favor llena todos los Conceptos.");
                break;
            }
            
            
            var2=document.getElementById("cantidadNomina_"+i).value ;  
            
            if (var2 == ''){
                valido=0;
                alert("Por favor llena todas las cantidades.");
                break;
            }
            
            var3=document.getElementById("ImporteNomina_"+i).value ;  
            
            
            if (var3 == ''){
                valido=0;
                alert("Por favor llena el importe.");
                break;
            }
            
             
        }
        
        if (valido==1){
            document.getElementById("editaRegistroNominaForm").submit();
        }
        else{
            
            
            document.getElementById("botonEditarRegistroNomina").value = "Editar";
            document.getElementById("botonEditarRegistroNomina").disabled = false;            
           
        }
        
        
        
        
        
        
        
        
        
        
        return true;
    }
    
    
    
    
    function calcularTotales(e){
        
        
      
        
        
        if (e != null){
        
        
            var elemento=e.srcElement.id;
            var res = elemento.split("_");
            var valor_numerico=isNaN(   document.getElementById(elemento).value  );
         
            
           
        
            var idLugar=document.getElementById("idLugarPersonaSeleccionada").value;
            var concepto=document.getElementById("conceptoNomina_"+res[1]).value;
            var precio=0;
            
            for (var i=0;i<precios.length;i++){
                if (idLugar==precios[i][0]){
                    if(concepto==119){  //Horas Normales Catalogo 
                        precio=precios[i][1];
                    }

                    if(concepto==120){  //Horas Extra
                        precio=precios[i][2];
                    }

                    if(concepto==121){  //Horas Extra Triples
                        precio=precios[i][3];
                    }

                    if(concepto==122){  //Puntualidad y Asistencia
                        precio=1;
                    }

                    if(concepto==123){  //Otros
                        precio=1;
                    }
                    if(concepto==124){  //Descuento Infonavit
                        precio=1;
                    }

                }
            }
            
            
            

            

            if (elemento=="conceptoNomina_"+res[1] ||  elemento=="cantidadNomina_"+res[1]  ){

                if (!valor_numerico){

                    document.getElementById("ImporteNomina_"+res[1]).value =document.getElementById("cantidadNomina_"+res[1]).value * precio;//
                    document.getElementById(elemento).value

                }else{
                    document.getElementById(elemento).value = "0";
                }

            }

        }
        
        
        var total=0;
        var horas=0;
        for (var i=1;i<=numeroFilas;i++){
            total=Number(total)+Number(   document.getElementById("ImporteNomina_"+i).value    ) ;  
            horas=Number(horas)+Number(   document.getElementById("cantidadNomina_"+i).value    ) ;
        }
        
      
        document.getElementById("costoTotal").value = total;
         document.getElementById("horasTotal").value = horas;
        
    }
   
    
    
    function autogenerarHoras(numeroDeHorasTotal){
     
        var numero=numeroFilas;
        
      
        
        for (var i=0;i<numero;i++){
             
            eliminaFila(5);
         
        }
        
        
        var TurnoNormal=48;
        var HorasDobles=0;
        var HorasTriples=0;
        
        if(numeroDeHorasTotal>=48){
            
            
            HorasDobles=numeroDeHorasTotal-48;
            numeroDeHorasTotal=numeroDeHorasTotal-48;
            
            
            if (numeroDeHorasTotal>=9){
                
                
                HorasDobles=9;
                HorasTriples=numeroDeHorasTotal-9;
        
                
            }else{
                
                HorasTriples=0;
            
            
            }
            
        }
        else{
            
            TurnoNormal=numeroDeHorasTotal;
        
        }
        
        
        
        
       
        
        
        agregaFila(5);
        document.ready = document.getElementById("conceptoNomina_1").value = '119';
        document.getElementById("descrpcionNomina_1").value="Turno Normal";
        document.getElementById("cantidadNomina_1").value=TurnoNormal;
        document.getElementById("ImporteNomina_1").value=buscarPrecio(119)*document.getElementById("cantidadNomina_1").value;
        
      
        agregaFila(5);
        document.ready = document.getElementById("conceptoNomina_2").value = '120';
        document.getElementById("descrpcionNomina_2").value="Hora Doble";
        document.getElementById("cantidadNomina_2").value=HorasDobles;
        document.getElementById("ImporteNomina_2").value=buscarPrecio(120)*document.getElementById("cantidadNomina_2").value;
        
        
        agregaFila(5);
        document.ready = document.getElementById("conceptoNomina_3").value = '121';
        document.getElementById("descrpcionNomina_3").value="Hora Triple";
        document.getElementById("cantidadNomina_3").value=HorasTriples;
        document.getElementById("ImporteNomina_3").value=buscarPrecio(121)*document.getElementById("cantidadNomina_3").value;
        
        
        calcularTotales();
        
        
    }
    
    
    function buscarPrecio(concepto){
        var precio=0;
         var idLugar=document.getElementById("idLugarPersonaSeleccionada").value;
        for (var i=0;i<precios.length;i++){
            if (idLugar==precios[i][0]){
                if(concepto==119){  //Horas Normales Catalogo 
                    precio=precios[i][1];
                }

                if(concepto==120){  //Horas Extra
                    precio=precios[i][2];
                }

                if(concepto==121){  //Horas Extra Triples
                    precio=precios[i][3];
                }

                if(concepto==122){  //Puntualidad y Asistencia
                    precio=1;
                }

                if(concepto==123){  //Otros
                    precio=1;
                }
                if(concepto==124){  //Descuento Infonavit
                    precio=1;
                }

            }
        }
        return precio;
        
    }
   
    
    
    
    function cambiarComboConcepto( indice) {
        
        document.getElementById("descrpcionNomina_"+indice).value="-";
        document.getElementById("cantidadNomina_"+indice).value="0";
        document.getElementById("ImporteNomina_"+indice).value="0";
        
        calcularTotales();
        
    }
    
    
    
    function buscaEmpleado(){
        
        var select = document.getElementById("SeleccionarSinNomina");
        
        
        <% for (int j=0;j<empleado.length;j++){ %>
            select.remove(0);
         <% } %>
        
       /* 
        var min = 12,
            max = 100;


        for (var i = min; i<=max; i++){
            var opt = document.createElement('option');
            opt.value = i;
            opt.innerHTML = i;
            select.appendChild(opt);
        }
        
        */
    
    
        var lugarSeleccion=document.getElementById("lugarSeleccion").value;
        

        
        var buscarFiltro=document.getElementById("buscarFiltro").value;
         
        
        $.post('Servlet', {
                                controlador : "buscaEmpleado",
                                lugarSeleccion : lugarSeleccion,
                                buscarFiltro : buscarFiltro
                                
                            }, function(responseText) {
                               
                               
                           
                               var empleados=JSON.parse(responseText);
                               
                               for (var i=0;i<empleados.employees.length;i++){
                                   
                                    var opt = document.createElement('option');
                                    opt.value = empleados.employees[i][1];
                                    opt.innerHTML = empleados.employees[i][0];
                                    select.appendChild(opt);
                                }
                               
                               
                               
                               
                             
                                
                            }
                );
        
        
       
        
        
    }
    
    
    
    function  abreModalEdicion(idOperacion){
        
        
         $("idLugarPersonaSeleccionada").remove();
         $("#costoTotal").remove();
         
        
        var numero=numeroFilas;
        for (var i=0;i<numero;i++){
             
            eliminaFila(5);
         
        }
        
         $("#tabla5").remove();
        
        
        
         $.post('Servlet', {
                                controlador : "acualizaModalEdicionRegistroNomina",
                                idOperacion : idOperacion
                            }, function(responseText) {
                               
                               $('#textoEditaRegistroNomina').html(responseText);
                               
                                numeroFilas=Number(document.getElementById("nuevoNumeroDeFilas").value);
                              
                                
                            }
                );
        
        
       
        
        
       
        
    }
    
    function cambiarComboPersona() {
        
         var IDPersona = document.getElementById("personaNomina").value;
      
        
        
       
        //document.getElementById("valoresPersona").innerHTML = "You selected: " + IDPersona;
        
        
         $.post('Servlet', {
                                controlador : "informacionDeEmpleado",
                                idpersona : IDPersona
                            }, function(responseText) {
                               
                               $('#valoresPersona').html(responseText);
                            }
                );
        
    }
    

    
    Date.prototype.getWeekNumber = function () {
      var d = new Date(+this);  //Creamos un nuevo Date con la fecha de "this".
        d.setHours(0, 0, 0, 0);   //Nos aseguramos de limpiar la hora.
        d.setDate(d.getDate() + 4 - (d.getDay() || 7)); // Recorremos los días para asegurarnos de estar "dentro de la semana"
        //Finalmente, calculamos redondeando y ajustando por la naturaleza de los números en JS:
        return Math.ceil((((d - new Date(d.getFullYear(), 0, 1)) / 8.64e7) + 1) / 7);
    };
    
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
                            
                            
                            
                            
                            
                            
                            if (requisicionesForm[i][4].equals("conceptoNomina")){
                                filaValor="<div class=\'form-group\'>"+
                                                "<select id=\'"+requisicionesForm[i][4]+"_\"+numeroFilas+\""+"\' name=\'"+requisicionesForm[i][4]+"[]\' class=\'\' onchange=\'cambiarComboConcepto(\"+numeroFilas+\")\'    >"+
                                                    "<option value=\'\'></option>"+
                                                    conceptosLista+
                                                "</select>"+
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
        $("#submit_value").attr('onclick', '');
        
        //document.getElementById("submit_value").disabled = true;
        
        var valido=1;
         
        
        var v1 = document.getElementById("fechaNomina").value;
        if (v1 == '' ){
            valido=0;
            alert("Por favor llena la Fecha de la Nomina");
        }
        
        var v2 = document.getElementById("SemanaNomina").value;
        if (v2 == '' ){
            valido=0;
            alert("Por favor llena la Semana de la Nomina");
        }
        
        var v3 = document.getElementById("anioNomina").value;
        if (v3 == '' ){
            valido=0;
            alert("Por favor llena el Año de la Nomina");
        }
        
        var v4 = document.getElementById("personaNomina").value;
        if (v4==""){
             valido=0;
            alert("Por favor selecciona una persona");
        }
         
        
        
        
        
        var var1;
        var var2;
        var var3;
        
        
        
                                                
        
        for (var i = 1; i <= numeroFilas ; i++) { 
          
            var1=document.getElementById("conceptoNomina_"+i).value ;  
            
            if (var1 == ''){
                valido=0;
                alert("Por favor llena todos los Conceptos.");
                break;
            }
            
            
            var2=document.getElementById("cantidadNomina_"+i).value ;  
            
            if (var2 == ''){
                valido=0;
                alert("Por favor llena todas las cantidades.");
                break;
            }
            
            var3=document.getElementById("ImporteNomina_"+i).value ;  
            
            
            if (var3 == ''){
                valido=0;
                alert("Por favor llena el importe.");
                break;
            }
            
             
        }
        
        if (valido==1){
            document.getElementById("crearRegistroNomina").submit();
        }
        else{
            document.getElementById("submit_value").value = "Guardar";
            document.getElementById("submit_value").disabled = false;
            $("#submit_value").attr('onclick', 'validacion()');
        }
        
       
            
    }


    
    
    
    
</script>
                              


<jsp:include page="../pieDePagina.jsp" flush="true"/>                