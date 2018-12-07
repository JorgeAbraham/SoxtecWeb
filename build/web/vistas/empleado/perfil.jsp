


<%@page import="serviciosBD.operaciones_servicio"%>
<%@page import="serviciosBD.catalogo_servicio"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="serviciosBD.lugar_servicio"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="utilidadesbasicas.archivoSerializableParaBD"%>
<%@page import="org.apache.catalina.util.Base64"%>
<%@page import="serviciosBD.usuario_servicio"%>
<%@page import="serviciosBD.documentos_servicio"%>
<%@page import="serviciosBD.persona_servicio"%>
<%@page import="utilidadesWeb.utilidadWeb"%>


<jsp:include page="../cabecera.jsp" flush="true"/>
     
<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>

        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>

            <%  
                String host=application.getInitParameter("host"); 
                String id = request.getParameter("empleadoId");  
                persona_servicio usuario=new persona_servicio();
                usuario.setIdPersona(Integer.parseInt(id));
                usuario.get();
               
                Date fechaActual = new Date(); 
                
                documentos_servicio documento;
                String documentos[][];
            %> 
            
            
            <div class="bkz aav aaj">
                <h3 class="bla blb">Perfil</h3>
            </div>    
            
            <div class="row">
                
                <div class="col-md-3 text-left">
                    
                    
                    
                    <% 
                        documento = new documentos_servicio();
                        documentos=documento.getDocumentosPorTipoEIdDeEmpleado("4", id);
                        String valorEstado=""; 
                        for (int i=0;i<documentos.length;i++){  %>
                            <tr>

                                <%  
                                    if (documentos[i][6].equals("1")){   //Texto 
                                        valorEstado=documentos[i][2];
                                    } else { 
                                        if (documentos[i][6].equals("3")){   //Numero 
                                            valorEstado=documentos[i][3];
                                        } else { 
                                            if (documentos[i][6].equals("4")){   //fecha 
                                                valorEstado=documentos[i][4];
                                            } else { 

                                            } 
                                        } 
                                    } 

                                    if (   valorEstado==null ||  valorEstado.equals("") || valorEstado.equals("sinDefinir") || valorEstado.equals("ingresado")   ){ valorEstado=""; %>
                                        <a href="#editEstado"  class="btn btn-info" onclick="seleccionaEstado(<%   out.print(id);  %> , <%  out.print(documentos[i][0]);  %>  )"   data-toggle="modal">Sin definir <i class="fa fa-question" ></i></a>
                                    <% }else{ %>
                                    
                                        <% if (valorEstado.equals("alta")){ %>
                                            <a href="#editEstado"  class="btn btn-success" onclick="seleccionaEstado(<%   out.print(id);  %> , <%  out.print(documentos[i][0]);  %>  )"   data-toggle="modal">Activo <i class="fa fa-arrow-circle-o-up" ></i></a>
                                        <% } %>
                                        
                                        <% if (valorEstado.equals("baja")){ %>
                                            <a href="#editEstado"  class="btn btn-danger" onclick="seleccionaEstado(<%   out.print(id);  %> , <%  out.print(documentos[i][0]);  %>  )"   data-toggle="modal">Baja <i class="fa fa-arrow-circle-down" ></i></a>
                                        <% } %>
                                            
                                        <% if (valorEstado.equals("solictudBaja")){ %>
                                            <a href="#editEstado"  class="btn btn-warning" onclick="seleccionaEstado(<%   out.print(id);  %> , <%  out.print(documentos[i][0]);  %>  )"   data-toggle="modal">Solicitud de Baja <i class="fa fa-arrow-circle-o-up" ></i></a>
                                        <% } %>
                                   
                                        <% if (valorEstado.equals("paroTecnico")){ %>
                                            <a class="btn btn-md bla blb"  data-toggle="modal">En paro técnico <i class="fa fa-pause-circle" ></i></a>
                                        <% } %>    
                                            
                                    <% } %>
                                
                           </tr>
                        <%}%>
                        
                    
                       
                  
                    
                    
                    
                </div> 
                <hr>
                <div class="col-md-9 text-right">
                    
                    <h3><i class="fa fa-user-circle" style="font-size:36px"></i><%   out.println(usuario.getApellidoPaterno()+" "+usuario.getApellidoMaterno()+" "+usuario.getNombre());    %> </h3>
                    <% 
                        
                        documento = new documentos_servicio();
                        documentos=documento.getDocumentosPorTipoEIdDeEmpleado("1", id);
            
                        for (int i=0;i<documentos.length;i++){  
                            if (documentos[i][1].equals("Fecha de Ingreso")){
                                
                                if (documentos[i][4]!=null){  
                                        try {
                                            Calendar inicio = new GregorianCalendar();
                                            Calendar fin = new GregorianCalendar();
                                            inicio.setTime(new SimpleDateFormat("dd/MM/yyyy").parse(documentos[i][4]));
                                            fin.setTime(new Date());
                                            int difA = fin.get(Calendar.YEAR) - inicio.get(Calendar.YEAR);
                                            int difM = difA * 12 + fin.get(Calendar.MONTH) - inicio.get(Calendar.MONTH);  
                                            if(difA>0){  %>
                                                <h5>Antigüedad  <% out.print(difA);  %> AÑOS</h5>
                                <%          }
                                            else{  %>
                                                <h5>Antigüedad  <% out.print(difM);  %> MESES</h5>
                                <%          }   
                                        } catch(ParseException ex) {

                                        }
                                %>
                                        
                                <%  } 
                                
                                
                                
                            }
                        }
                        %>
                        
                        
                        
                        <% if (valorEstado.equals("alta")){  %>
                            <a href="#peticionParoTecnico"  class="btn btn-md bla blb" onclick="peticionParoTecnico( <%   out.print(id);  %> , 30  )"   data-toggle="modal">Paro Técnico <i class="fa fa-pause-circle" ></i></a>
                        <%}%>
                        <%if (valorEstado.equals("paroTecnico")){  %>
                            <a href="#peticionActivo"  class="btn btn-success" onclick="peticionActivo( <%   out.print(id);  %> , 30  )"   data-toggle="modal">Restituir como Activo <i class="fa fa-arrow-circle-o-up" ></i></a>
                        <%}%>
                        <a href="#peticionBaja"  class="btn btn-warning" onclick="peticionDeBaja( <%   out.print(id);  %> , 30  )"   data-toggle="modal">Solicitud de Baja <i class="fa fa-arrow-circle-down" ></i></a>
                        
                </div>  
                
            <hr style="width:100%;">
                <div class="container">
                    <div class="row justify-content-around">
                           

                            <div class="col-6 ">

                                <%
                                    lugar_servicio L=new lugar_servicio();

                                    String lugar[][]=L.listaLugaresPorIDPersona(id);
                                %>

                                <a href="#editLugar"  class="btn btn-info" onclick="seleccionaLugar( <%   out.print(id);  %>  )"   data-toggle="modal">Lugar <% out.print(lugar[0][1]);  %><i class="fa fa-industry" ></i></a>

                            </div>
                            <div class="col-6 ">

                                <%
                                    
                                    documento = new documentos_servicio();
                                    documentos=documento.getDocumentosPorTipoEIdDeEmpleado("12", id);
                                    
                                    
                                    
                                    String catalogo[][]=null;
                                    if(documentos[0][2]!=null){

                                        catalogo_servicio C =new catalogo_servicio();
                                        catalogo=C.catalogoPorId(documentos[0][2]);
                                %>
                                        <a href="#editLugar"  class="btn btn-info" onclick="seleccionaArea( <%   out.print(documentos[0][0]);  %>  )"   data-toggle="modal">Area <% out.print(catalogo[0][0]);  %><i class="fa fa-building" ></i></a>
                                <%  }else{%>
                                        <a href="#editLugar"  class="btn btn-danger" onclick="seleccionaArea( <%   out.print(documentos[0][0]);  %>  )"   data-toggle="modal">Area No Asigada<i class="fa fa-building" ></i></a>
                                <%  }%>
                                        
                            </div>

                        </div>
                    </div>
                            
                    
                            
                            
                    
                    
                
                
                <hr>
                                
                <div class="col-md-12 text-right">
                    
                    
                    <div class="progress">
                        <div id="infPer" class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:0%">
                            Información Personal
                        </div>
                    </div>
                </div> 
                <br>
                <div class="col-md-12 text-right">
                    <div class="progress">
                        <div id="infDoc" class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width:0%">
                            Documentos
                        </div>
                    </div>
                </div> 
                
                <br>
                
                <div class="progress progress-striped active">
                    <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
                    </div>
                </div>
                
                <br>
                
                <div class="col-md-12">
                    
                    <ul class="nav nav-tabs">
                        <li class="active"><a class="btn btn-md bla blb" data-toggle="tab" href="#menu0">Perfil <i class="fa fa-user" ></i></a></li>
                        <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu1">Documentos <i class="fa fa-file-o" ></i></a></li>
                        <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu2">Incapacidad <i class="fa fa-stethoscope" ></i></a></li>
                        <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu3">Incidencias <i class="fa fa-exclamation" ></i></a></li>
                        <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu4">Equipo de Seguridad <i class="fa fa-user" ></i></a></li>
                        <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu5">Vacaciones <i class="fa fa-plane" ></i></a></li>
                    </ul>
                    
                    <div class="tab-content">
                        
                        
                        
                        
                        <div id="menu0" class="tab-pane fade in active">
                            
                            
                           <div class="row">
                                <div class="col-md-4">
                                   


                                    <% 
                                        documento = new documentos_servicio();
                                        documentos=documento.getDocumentosPorTipoEIdDeEmpleado("3", id);
                                        for (int i=0;i<documentos.length;i++){

                                    %>
                                            <a  href="#fileModal" data-toggle="modal" id="<%  out.print(documentos[i][1]);  %>" onclick="seleccionaArchivo(event, <%  out.print(id);  %> , <%  out.print(documentos[i][0]);  %>,<%  out.print(documentos[i][5]);  %> )"  >
                                                <%  if (documentos[i][5]!=null){   

                                                archivoSerializableParaBD archivo = utilidadesbasicas.utilidadVinculoBD.operacionSQSelectBlob("archivo", "idArchivo", Integer.parseInt(documentos[i][5]), "archivo","nombreArchivo");
                                                        Base64 codec = new Base64();
                                                        // Outputs "SGVsbG8="
                                                %>

                                                    <img width="190" height="325" src="data:image/png;base64, <%  if (archivo.getContenido()!=null){   out.print(     codec.encode(  archivo.getContenido()    )    );  }   %>" alt="Red dot" />
                                                <%  }else{  %>
                                                    <img src="imagenes\no-photo1.png" width="250" height="325" >
                                                <% } %>
                                            </a>
                                    <%  } %>


                                </div>
                                    
                                    
                                <div class="col-md-8">



                                    <table class="ck" data-sort="table">
                                        <thead>
                                            <tr>
                                                <th class="header text-center">Documento</th>
                                                <th class="header text-center">Valor</th>
                                                <th class="header text-center">Opcion</th>

                                            </tr>
                                        </thead>
                                        <tbody class="text-center">


                                            <% 
                                            documento = new documentos_servicio();
                                            documentos=documento.getDocumentosPorTipoEIdDeEmpleado("1", id);
                                            
                                            int totalInformacionPersonal=documentos.length;
                                            int contadorInformacionPersonal=0;
                                            
                                            
                                            for (int i=0;i<documentos.length;i++){  %>
                                                <tr>

                                                    <% out.println("<td class=\"bv aaj\">"+documentos[i][1]+"</td>"); %>

                                                    <%  String valor=""; 
                                                        if (documentos[i][6].equals("1")){   //Texto 

                                                            valor=documentos[i][2];
                                                            
                                                        } else { 
                                                            if (documentos[i][6].equals("3")){   //Numero 
                                                                valor=documentos[i][3];
                                                              
                                                            } else { 
                                                                if (documentos[i][6].equals("4")){   //fecha 
                                                                    valor=documentos[i][4];
                                                                    
                                                                } else { 

                                                                } 
                                                            } 
                                                        } 

                                                        if (   valor==null ||  valor.equals("")   ){ %>
                                                            <td class="bv aaj"></td>
                                                        <% }else{ 
                                                            contadorInformacionPersonal++; %>
                                                            <td class="bv aaj"><%  out.println(valor); %></td>
                                                        <% } %>
                                                    <td class="bv aaj">
                                                        <a  href="#editModal" class="btn btn-md bla blb" data-toggle="modal" id="<%  out.print(documentos[i][1]);  %>" onclick="editaArchivo(event, <%  out.print(id);  %> , <%  out.print(documentos[i][0]);  %> , <%  out.print(documentos[i][6]);  %>,   '<%  out.print(documentos[i][2]);  %>'   ,   '<%  out.print(documentos[i][3]);  %>'  ,  '<%  out.print(documentos[i][4]);  %>'  )"  >Guardar <i class="fa fa-edit" ></i></a>
                                                    </td>
                                               </tr>
                                            <%}%>



                                        </tbody>
                                    </table>
                                </div>
                            </div>
   
                        </div>
                                            
                                            
                                            
                        <div id="menu1" class="tab-pane fade">
                            
                            
                            <div class="col-md-12">
                      
                

                                <div class="by aaj">
                                    

                                    <% 
                                        documento = new documentos_servicio();
                                        documentos=documento.getDocumentosPorTipoEIdDeEmpleado("2", id);
                                        
                                        int totalDocumentosPersonal=documentos.length;
                                        int contadorDocumentosPersonal=0;
                                        
                                        
                                            
                                        for (int i=0;i<documentos.length;i++){%>

                                            <% if (documentos[i][1]!=null){ %>

                                                <div class="mo od tc ra">

                                                    <% if (documentos[i][8]!=null){   %>

                                                        <% 
                                                        contadorDocumentosPersonal++;
                                                        
                                                        %>
                                                    
                                                        <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>"    >
                                                            <span><% out.println(""+documentos[i][1]); %> <i class="fa fa-cloud-download" ></i></span>
                                                        </a>  

                                                    <% } else{ %>

                                                        <span><% out.println(""+documentos[i][1]); %> </span>

                                                    <% } %>

                                                    <a  href="#fileModal" class="btn btn-md bla" data-toggle="modal" id="<%  out.print(documentos[i][1]);  %>" onclick="seleccionaArchivo(event, <%  out.print(id);  %> , <%  out.print(documentos[i][0]);  %>,<%  out.print(documentos[i][8]);  %> )"  >Subir <i class=" fa fa-cloud-upload" ></i></a>
                                                </div>

                                            <% } %>




                                    <%}%>


                                </div>



                            </div>
                            
                            
                            
                            
                        </div>
                                            
                                            
                                            
                                            
                        <div id="menu2" class="tab-pane fade">
                          
                            <br>
                                
                            <div class="row">
                                
                               
                                <div class="col-md-12 text-right">
                                    <a href="#agregaIncapacidad"  class="btn btn-md bla blb" onclick="agregaIncapacidad(<%  out.print(id);  %>  )"   data-toggle="modal">Agregar Incapacidad <i class="fa fa-plus" ></i></a>
                                </div>
                                
                                
                                
                                <div class="col-md-12">

                                    <br>

                                    <table class="ck" data-sort="table">
                                        <thead>
                                            <tr>
                                                <th class="header text-center">Motivo</th>
                                                <th class="header text-center">Fecha</th>
                                                <th class="header text-center">Comprobante</th>

                                            </tr>
                                        </thead>
                                        <tbody class="text-center">


                                            <% 
                                            documento = new documentos_servicio();
                                            documentos=documento.getDocumentosTodosLosRegistrosPorTipoEIdDeEmpleado("5", id);
                                            
                                            String indice="";
                                            
                                            
                                            for (int i=0;i<documentos.length;i++) {  %>
                                                

                                                   
                                                    <% if (   documentos[i][7]!=null &&  !indice.equals(documentos[i][7])  ) { %>
                                                        
                                                        <% indice=documentos[i][7]; %>
                                                        
                                                        
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                           <% }  %>
                                                            
                                                           
                                                    <% } else { %>
                                                    
                                                            
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                                
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                            <% }  %>
                                                            
                                                    
                                                    
                                                    <% } %>
                                                    
                                                        

                                                        
                                                
                                            <%  }   %>



                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            
                            
                            
                        </div>
                                            
                                            
                        <div id="menu3" class="tab-pane fade">
                          
                            <br>
                                
                            <div class="row">
                                
                               
                                <div class="col-md-12 text-right">
                                    <a href="#agregaIncidencia"  class="btn btn-md bla blb" onclick="agregaIncapacidad2(<%  out.print(id);  %>  )"   data-toggle="modal">Agregar Incidencia <i class="fa fa-plus" ></i></a>
                                </div>
                                
                                
                                
                                <div class="col-md-12">

                                    <br>

                                    <table class="ck" data-sort="table">
                                        <thead>
                                            <tr>
                                                <th class="header text-center">Descripción</th>
                                                <th class="header text-center">Motivo</th>
                                                <th class="header text-center">Fecha</th>

                                            </tr>
                                        </thead>
                                        <tbody class="text-center">


                                            <% 
                                            documento = new documentos_servicio();
                                            documentos=documento.getDocumentosTodosLosRegistrosPorTipoEIdDeEmpleado("8", id);
                                            
                                            indice="";
                                            
                                            
                                            for (int i=0;i<documentos.length;i++) {  %>
                                                

                                                   
                                                    <% if (   documentos[i][7]!=null &&  !indice.equals(documentos[i][7])  ) { %>
                                                        
                                                        <% indice=documentos[i][7]; %>
                                                        
                                                        
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                           <% }  %>
                                                            
                                                           
                                                    <% } else { %>
                                                    
                                                            
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                                
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                            <% }  %>
                                                            
                                                    
                                                    
                                                    <% } %>
                                                    
                                                        

                                                        
                                                
                                            <%  }   %>



                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            
                            
                            
                        </div>
                                            
                                            
                                            
                                            
                        <div id="menu4" class="tab-pane fade">
                          
                            <br>
                                
                            <div class="row">
                                
                               
                                <div class="col-md-12 text-right">
                                    <a href="#agregaEquipoDeSeguridad"  class="btn btn-md bla blb" onclick="agregaEquipoDeSegiridad(<%  out.print(id);  %>  )"   data-toggle="modal">Agregar Entrega de Equipo <i class="fa fa-plus" ></i></a>
                                </div>
                                
                                
                                
                                <div class="col-md-12">

                                    <br>

                                    <table class="ck" data-sort="table">
                                        <thead>
                                            <tr>
                                                <th class="header text-center">Fecha</th>
                                                <th class="header text-center">Equipo</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">


                                            <% 
                                            documento = new documentos_servicio();
                                            documentos=documento.getDocumentosTodosLosRegistrosPorTipoEIdDeEmpleado("7", id);
                                            
                                            indice="";
                                            
                                            
                                            for (int i=0;i<documentos.length;i++) {  %>
                                                

                                                   
                                                    <% if (   documentos[i][7]!=null &&  !indice.equals(documentos[i][7])  ) { %>
                                                        
                                                        <% indice=documentos[i][7]; %>
                                                        
                                                        
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                           <% }  %>
                                                            
                                                           
                                                    <% } else { %>
                                                    
                                                            
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                                
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                            <% }  %>
                                                            
                                                    
                                                    
                                                    <% } %>
                                                    
                                                        

                                                        
                                                
                                            <%  }   %>



                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            
                            
                            
                        </div>                    
                        
                                            
                                            
                                            
                        <div id="menu5" class="tab-pane fade">
                          
                            <br>
                                
                            <div class="row">
                                
                               
                                <div class="col-md-12 text-right">
                                    <a href="#agregaVacaciones"  class="btn btn-md bla blb" onclick="agregaPeriodoVacacional(<%  out.print(id);  %>  )"   data-toggle="modal">Agregar Periodo Vacacional <i class="fa fa-plus" ></i></a>
                                </div>
                                
                                
                                
                                <div class="col-md-12">

                                    <br>

                                    <table class="ck" data-sort="table">
                                        <thead>
                                            <tr>
                                                <th class="header text-center">Estado</th>
                                                <th class="header text-center">Descripcón</th>
                                                <th class="header text-center">Fecha Inicial</th>
                                                <th class="header text-center">Fecha Final</th>
                                                
                                            </tr>
                                        </thead>
                                        <tbody class="text-center">


                                            <% 
                                            documento = new documentos_servicio();
                                            documentos=documento.getDocumentosTodosLosRegistrosPorTipoEIdDeEmpleado("9", id);
                                            
                                            indice="";
                                            
                                            
                                            for (int i=0;i<documentos.length;i++) {  %>
                                                

                                                   
                                                    <% if (   documentos[i][7]!=null &&  !indice.equals(documentos[i][7])  ) { %>
                                                        
                                                        <% indice=documentos[i][7]; %>
                                                        
                                                        
                                                        </tr>
                                                        
                                                        
                                                        <tr>
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                           <% }  %>
                                                            
                                                           
                                                    <% } else { %>
                                                    
                                                            
                                                            <% if(documentos[i][3]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][3]+"</td>"); %>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][4]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][4]+"</td>"); %>
                                                            <% } %>
                                                                
                                                            <% if(documentos[i][5]!=null){ %>
                                                                <td class="bv aaj"> 
                                                                    <a  href="<% out.println(host); %>Servlet?controlador=descargaDocumentoEmpleado&requisitoId=<% out.println(documentos[i][5]); %>&tipo=<% out.println(documentos[i][6]); %>" class="btn btn-md bla blb"   >
                                                                        <span>Descarga</span>
                                                                    </a>  
                                                                </td>
                                                            <% } %>
                                                            
                                                            <% if(documentos[i][2]!=null){ %>
                                                                <% out.println("<td class=\"bv aaj\">"+documentos[i][2]+"</td>"); %>
                                                            <% }  %>
                                                            
                                                    
                                                    
                                                    <% } %>
                                                    
                                                        

                                                        
                                                
                                            <%  }   %>



                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                                            
                                            
                                            
                                            
                                            
                    </div>
                          
                </div>
                    
                            
                      
            
                </div>
            </div>
            
            

   

            <hr class="aav">
           
            </div>

            <div class="dh bmk">
                <div class="et bmj">

                </div>
            </div>
        </div>

             
                                            
                                            
                                            
                                            

<div id="agregaVacaciones" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Periodo Vacacional</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=agregaVacaciones" method = "post" >
                <div class="modal-body">
                        
                    
                    
                        <span class="col-md-12">Fecha Inicio</span>
                        <div class="col-md-12">
                            <input type="date" name="fechaInicioVacaciones" class="col-md-12" value="<%  out.print(new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)); %>"  >
                        </div>
                        
                        <span class="col-md-12">Fecha Fin</span>
                        <div class="col-md-12">
                            <input type="date" name="fechaFinVacaciones" class="col-md-12" value="<%  out.print(new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)); %>" >
                        </div>
                        
                        <span class="col-md-12">Descripción</span>
                        <div class="col-md-12">
                            <textarea name="descripcionVacaciones" rows="4" cols="50"  class="col-md-12"  ></textarea>
                        </div>
                        
                        
                        
                        <input type="hidden" id="idPersonaEditarVacaciones" name="idPersonaEditarVacaciones" value="" />
                        <input type="hidden" id="idVariableAlmacenamientoVacaciones" name="idVariableAlmacenamientoVacaciones" value="9" />

                         
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Agregar" />
                </div>
            </form>
        </div>
    </div>
</div>
                                                 
                                            
                                            


<div id="agregaEquipoDeSeguridad" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Equipo de Seguridad</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=agregaEquipoSeguridad" method = "post" >
                <div class="modal-body">
                        
                    
                    
                        <span class="col-md-12">Fecha</span>
                        <div class="col-md-12">
                            <input type="date" name="fechaEntrega" class="col-md-12"  value="<%  out.print(new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)); %>" >
                        </div>
                        
                        <span class="col-md-12">Equipo de Segurdad</span>
                        <div class="form-group col-md-12">
                            <select name="equipoEntregado" class="form-control">
                                <option value="Chaleco">Chaleco</option>
                                <option value="Faja">Faja</option>
                                <option value="Zapatos">Zapatos</option>
                                
                            </select>
                        </div>
                        
                        <input type="hidden" id="idPersonaEditarEquipoSeguridad" name="idPersonaEditarEquipoSeguridad" value="" />
                        <input type="hidden" id="idVariableAlmacenamientoEquipoSeguridad" name="idVariableAlmacenamientoEquipoSeguridad" value="7" />

                         
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Agregar" />
                </div>
            </form>
        </div>
    </div>
</div>
                                            
                                            
           
                                            
                                            
                                            

<div id="agregaIncidencia" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Incidencia</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=agregaIncidencia2" method = "post" >
                <div class="modal-body">
                        
                    
                    
                        <span class="col-md-12">Fecha</span>
                        <div class="col-md-12">
                            <input type="date" name="fechaIncidencia" class="col-md-12"  value="<%  out.print(new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)); %>"  >
                        </div>
                        
                        <span class="col-md-12">Motivo</span>
                        <div class="form-group col-md-12">
                            <select name="motivoIncidencia" class="form-control">
                                <option value="Permiso">Permiso</option>
                                <option value="Retardo">Retardo</option>
                                <option value="Falta">Falta</option>
                                <option value="No apoyo en Tiempo Extra">No apoyo en Tiempo Extra</option>
                                <option value="Incapacidad">Incapacidad</option>
                                <option value="Indiciplina">Indiciplina</option>
                                <option value="Paro Técnico">Paro Técnico</option>
                                <option value="Suspención">Suspención</option>
                                <option value="Reingreso">Reingreso</option>
                            </select>
                        </div>
                    
                        <span class="col-md-12">Descripción</span>
                        <div class="col-md-12">
                            <textarea name="descripcionIncidencia" rows="4" cols="50"  class="col-md-12"  ></textarea>
                        </div>
                        
                        
                        <input type="hidden" id="idPersonaEditarIncidencias2" name="idPersonaEditarIncidencias2" value="" />
                        <input type="hidden" id="idVariableAlmacenamientoIncidencias2" name="idVariableAlmacenamientoIncidencias2" value="8" />

                         
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Agregar" />
                </div>
            </form>
        </div>
    </div>
</div>
                                            
                                            
                                            
          

<div id="agregaIncapacidad" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Incapacidad</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=agregaIncidencia" method = "post"  enctype = "multipart/form-data">
                <div class="modal-body">
                        
                        <span>Fecha</span>
                        <input type="date" name="fechaIncapacidad" class="col-md-12" value="<%  out.print(new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)); %>"   >
                        <span>Motivo</span>
                        <textarea name="motivoIncapacidad" rows="4" cols="50"  class="col-md-12"  ></textarea>
                        <span>Comprobante</span>
                        <input type="file" name="comprobanteIncapacidad"  class="col-md-12"  >
                        
                    
                        <input type="hidden" id="idPersonaEditarIncidencias" name="idPersonaEditarIncidencias" value="" />
                        <input type="hidden" id="idVariableAlmacenamientoIncidencias" name="idVariableAlmacenamientoIncidencias" value="6" />

                         
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Agregar" />
                </div>
            </form>
        </div>
    </div>
</div>



                            
<div id="fileModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span id="nombreArchivo"></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=subirArchivoEmpleado" method = "post"  enctype = "multipart/form-data">
                <div class="modal-body">
                    
                        <input type = "file" name = "file" size = "50" />
                        
                        <input type="hidden" id="idVariableAlmacenamiento" name="idVariableAlmacenamiento" value="" />
                         <input type="hidden" id="idPersona" name="idPersona" value="" />
                         <input type="hidden" id="idRequisito" name="idRequisito" value="" />
                      
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Subir Archivo" />
                </div>
            </form>
        </div>
    </div>
</div>
                            

                        
                            
                            
<div id="editModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span id="nombreArchivoEditar"></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=editarDocumentoEmpleado" method = "post" >
                <div class="modal-body">
                    
                        <input type="text" id="valorEditar" name="valorEditar" value="" />
                      
                        
                         <input type="hidden" id="idVariableAlmacenamientoEditar" name="idVariableAlmacenamientoEditar" value="" />
                         <input type="hidden" id="idPersonaEditar" name="idPersonaEditar" value="" />
                         <input type="hidden" id="idTipoEditar" name="idTipoEditar" value="" />
                         
                         <input type="hidden" id="idTextoEditar" name="idTextoEditar" value="" />
                         <input type="hidden" id="idNumeroEditar" name="idNumeroEditar" value="" />
                         <input type="hidden" id="idFechaEditar" name="idFechaEditar" value="" />
                         
                         
                        <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" class="ce kh" value = "Guardar" />
                </div>
            </form>
        </div>
    </div>
</div>
                            
                        
                          
                            
<div id="editEstado" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Modifica Estado</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="" action = "Servlet?controlador=editaEstadoEmpleado" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        <select name="valorEditar" class="form-control">
                            <option value="sinDefinir">Sin definir</option>
                            <option value="alta">Alta</option>
                            <option value="baja">Baja</option>
                        </select>
                    </div>

                    <input type="hidden" id="idPersonaEditarEstado" name="idPersonaEditarEstado" value="" />
                    <input type="hidden" id="idVariableAlmacenamientoEstado" name="idVariableAlmacenamientoEstado" value="" />


                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmit" class="ce kh" value = "Cambiar" />
                </div>
            </form>
        </div>
    </div>
</div>
       
                        
                        
                     
                            
<div id="editLugar" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Modifica Lugar</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="editaLugarEmpleado" action = "Servlet?controlador=editaLugarEmpleado" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Lugar</span>
                        <select id="Lugar"  name="Lugar" class="form-control" onchange="modificarPropietario()">

                            <%
                                L = new lugar_servicio();
                                String lugares[][]=L.listaLugares();


                                %>
                                   
                                <%
                                for (int i=0;i<lugares.length;i++){  
                                    if (lugar[0][0].equals(lugares[i][0])){  %>
                                        <option value="<% out.print(lugares[i][0]); %>" selected> <% out.print(lugares[i][1]); %> </option>
                                <%  } else{  %>
                                        <option value="<% out.print(lugares[i][0]); %>"> <% out.print(lugares[i][1] ); %> </option>
                                <%  }  %>
                                
                            <%  } %>


                        </select>
                        
                    </div>

                    <input type="hidden" id="idPersonaEditarLugar" name="idPersonaEditarLugar" value="" />
                   

                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmitLugar" class="ce kh" value = "Cambiar" />
                </div>
            </form>
        </div>
    </div>
</div>
               
                            
                 
                            
<div id="editArea" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span>Modifica Area</span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="editaLugarEmpleado" action = "Servlet?controlador=editaLugarEmpleado" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Lugar</span>
                        <select id="Lugar"  name="Lugar" class="form-control" onchange="modificarPropietario()">

                            <%

                                catalogo_servicio C = new catalogo_servicio();
                                String areas[][]=C.listaPorTipoCatalogo(15);

                                %>
                                   
                                <%
                                for (int i=0;i<areas.length;i++){  
                                    if (lugar[0][0].equals(areas[i][0])){  %>
                                        <option value="<% out.print(areas[i][0]); %>" selected> <% out.print(areas[i][1]); %> </option>
                                <%  } else{  %>
                                        <option value="<% out.print(areas[i][0]); %>"> <% out.print(areas[i][1] ); %> </option>
                                <%  }  %>
                                
                            <%  } %>


                        </select>
                        
                    </div>

                    <input type="hidden" id="idPersonaEditarLugar" name="idPersonaEditarLugar" value="" />
                   

                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmitLugar" class="ce kh" value = "Cambiar" />
                </div>
            </form>
        </div>
    </div>
</div>
               
                            

                                 
<div id="peticionBaja" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="empleadoSolicitudBaja" action = "Servlet?controlador=empleadoSolicitudBaja" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Solicitar la Baja</span>
                        <hr>
                        <h3> <%   out.println(usuario.getApellidoPaterno()+" "+usuario.getApellidoMaterno()+" "+usuario.getNombre());    %> </h3>
                        
                    </div>

                    <input type="hidden" id="idPersonaPeticionBaja" name="idPersonaPeticionBaja" value="" />
                    <input type="hidden" id="idVariablePeticionBaja" name="idVariablePeticionBaja" value="" />
                    <input type="hidden" id="valorEditarBaja" name="valorEditarBaja" value="solictudBaja" />
                   
                 

                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmitSolicitudBaja" class="ce kh btn-warning" value = "Solicitar" />
                </div>
            </form>
        </div>
    </div>
</div>          
                        
                        
                        
                                
<div id="peticionParoTecnico" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="empleadoParoTecnico" action = "Servlet?controlador=empleadoParoTecnico" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Personal en paro técnico</span>
                        <hr>
                        <h3> <%   out.println(usuario.getApellidoPaterno()+" "+usuario.getApellidoMaterno()+" "+usuario.getNombre());    %> </h3>
                        
                    </div>

                    <input type="hidden" id="idPersonaParoTecnico" name="idPersonaParoTecnico" value="" />
                    <input type="hidden" id="idVariableParoTecnico" name="idVariableParoTecnico" value="" />
                    <input type="hidden" id="valorEditarParoTecnico" name="valorEditarParoTecnico" value="paroTecnico" />
                   
                 

                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmitSolicitudParoTecnico" class="ce kh btn btn-md bla blb" value = "Pasar a paro Técnico" />
                </div>
            </form>
        </div>
    </div>
</div>       
 
                        
<div id="peticionActivo" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel"><span></span></h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            
            <form id="empleadoParoTecnico" action = "Servlet?controlador=empleadoParoTecnico" method = "post"  onsubmit="return checkSubmit();" >
                <div class="modal-body">
                    
                    <div class="form-group col-md-12">
                        
                        <span class="col-md-12">Personal restituido como activo</span>
                        <hr>
                        <h3> <%   out.println(usuario.getApellidoPaterno()+" "+usuario.getApellidoMaterno()+" "+usuario.getNombre());    %> </h3>
                        
                    </div>

                    <input type="hidden" id="idPersonaActivo" name="idPersonaActivo" value="" />
                    <input type="hidden" id="idVariableActivo" name="idVariableActivo" value="" />
                    <input type="hidden" id="valorEditarActivo" name="valorEditarActivo" value="alta" />
                   
                 

                    <br />

                </div>
                <div class="om">
                    <button type="button" class="ce kh" data-dismiss="modal">Cancelar</button>
                    <input type = "submit" id="btsubmitSolicitudParoTecnico" class="ce kh btn-success" value = "Pasar a Activo" />
                </div>
            </form>
        </div>
    </div>
</div>       
                            
                            
<script>

    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=empleadosPerfil&empleadoId=<%out.print(id);%>';  
    }


    function checkSubmit() {
        
        
        document.getElementById("btsubmit").value = "Enviando...";
        document.getElementById("btsubmit").disabled = true;
        
        document.getElementById("btsubmitLugar").value = "Enviando...";
        document.getElementById("btsubmitLugar").disabled = true;
        
        document.getElementById("btsubmitSolicitudBaja").value = "Enviando...";
        document.getElementById("btsubmitSolicitudBaja").disabled = true;
        
        
        
        return true;
    }

    $(document).ready(function(){
    
        <%
            int doc=(contadorDocumentosPersonal*100)/totalDocumentosPersonal;
            int inf=(contadorInformacionPersonal*100)/totalInformacionPersonal;
            
        %>
       
        $('#infPer').css('width', <%out.println(inf);%>+'%').attr('aria-valuenow', <%out.println(inf);%>);    
        $('#infDoc').css('width', <%out.println(doc);%>+'%').attr('aria-valuenow', <%out.println(doc);%>);    
        
        
        document.getElementById("infPer").innerHTML = "<span>Información_"+<% out.print("\""+inf+"\""); %>+"% </span>";
        document.getElementById("infDoc").innerHTML = "<span>Documentos_"+<% out.print("\""+doc+"\""); %>+"% </span>";
        
    
    }); 


    function agregaPeriodoVacacional(idPersona){
        $('#idPersonaEditarVacaciones').val(  idPersona  );
    }

    function agregaEquipoDeSegiridad(idPersona){
        $('#idPersonaEditarEquipoSeguridad').val(  idPersona  );
    }

    
    function agregaIncapacidad2(idPersona){
        $('#idPersonaEditarIncidencias2').val(  idPersona  );
    }


    function agregaIncapacidad(idPersona){
        $('#idPersonaEditarIncidencias').val(  idPersona  );
    }


    function seleccionaEstado(idPersona,idVariableAlmacenamiento){
        
        $('#idPersonaEditarEstado').val(  idPersona  );
        $('#idVariableAlmacenamientoEstado').val(  idVariableAlmacenamiento  ); 
        
    }
    
    function peticionDeBaja(idPersona,idVariableAlmacenamiento){
        
        $('#idPersonaPeticionBaja').val(  idPersona  );
        $('#idVariablePeticionBaja').val(  idVariableAlmacenamiento  ); 
        
    }
    
    function peticionParoTecnico(idPersona,idVariableAlmacenamiento){
              
        $('#idPersonaParoTecnico').val(  idPersona  );
        $('#idVariableParoTecnico').val(  idVariableAlmacenamiento  ); 
        
    }


    function peticionActivo(idPersona,idVariableAlmacenamiento){
              
        $('#idPersonaActivo').val(  idPersona  );
        $('#idVariableActivo').val(  idVariableAlmacenamiento  ); 
        
    }

    function seleccionaLugar(idPersona){
        $('#idPersonaEditarLugar').val(  idPersona  );
    }


    function seleccionaArea(idPersona){
        $('#idPersonaEditarArea').val(  idPersona  );
    }



    function seleccionaArchivo(e,idPersona,idVariableAlmacenamiento,idRequisito){
        $('#nombreArchivo').text(  e.srcElement.id  );
        $('#idVariableAlmacenamiento').val(  idVariableAlmacenamiento  );
        $('#idPersona').val(  idPersona  );
        $('#idRequisito').val(  idRequisito  ); 
    }
    
   
    
    function editaArchivo(e,idPersona,idVariableAlmacenamiento,idTipo,idTextoEditar,idNumeroEditar,idFechaEditar){
        $('#nombreArchivoEditar').text(  e.srcElement.id  );
        $('#idVariableAlmacenamientoEditar').val(  idVariableAlmacenamiento  );
        $('#idPersonaEditar').val(  idPersona  );
        $('#idTipoEditar').val(  idTipo  );
        
        var valorEditar="";
        if (idTipo==1 ){
            if (idTextoEditar != null){
                valorEditar=idTextoEditar;
                $("#valorEditar").attr("type","text");
            }
        }
        if (idTipo==3){
            if (idNumeroEditar != null){
                valorEditar=idNumeroEditar;
                $("#valorEditar").attr("type","text");
            }
        }
        if (idTipo==4){
            if (idFechaEditar != null){
               valorEditar=idFechaEditar;
               $("#valorEditar").attr("type","date");
            }
            
            
        }
        
        $('#idTextoEditar').val(  idTextoEditar  );
        $('#idNumeroEditar').val(  idNumeroEditar  );
        $('#idFechaEditar').val(  idFechaEditar  );
        $('#valorEditar').val(  valorEditar  );
    }


</script>                         


<jsp:include page="../pieDePagina.jsp" flush="true"/>