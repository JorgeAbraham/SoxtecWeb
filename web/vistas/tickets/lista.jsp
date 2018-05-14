



<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="serviciosBD.ticket_servicio"%>
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
                <h3 class="bla blb">Tickets</h3>
                
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                
              </div>
            
            
            <ul class="nav nav-tabs">
                <li class="active"><a class="btn btn-primary btn-md bla blb" data-toggle="tab" href="#menu0">Nuevo <i class="fa fa-sticky-note-o" style="font-size:15px"></i></a></li>&nbsp;
                <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu1">Pendientes <i class="fa fa-question" style="font-size:15px"></i></a></li>&nbsp;
                <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu2">Resueltos <i class="fa fa-check" style="font-size:15px"></i></a></li>&nbsp;
                <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu3">Involucrado <i class="fa fa-users" style="font-size:15px"></i></a></li>&nbsp;
                <li><a class="btn btn-md bla blb" data-toggle="tab" href="#menu4">Historial <i class="fa fa-history" style="font-size:15px"></i></a></li>&nbsp;
            </ul>
            
                
            <div class="tab-content">
                <div id="menu0" class="tab-pane fade in active">
                    <form id="" action = "Servlet?controlador=nuevoTicket" method = "post" >
                        
                        <input type="hidden" id="idUsuario" name="idUsuario" value="<% out.print(idUsuario); %>">
                        
                        
                        <div class="row">
                        
                            <hr width="100%" />
                            <div class="col-md-12">
                                <span class="col-md-12">Asignado a</span>
                                <div class="form-group col-md-12">
                                    <select class="form-control" name="ticketAsignado"  id="ticketAsignado" >

                                        <%
                                            persona_servicio empleados = new persona_servicio();
                                            String empleado[][]=empleados.LISTAempleadosEstadoActivoYUsuarioAdministradoresString(empleados.ALTA);
                                            %>
                                                <option value="null"></option>
                                            <%
                                            for (int i=0;i<empleado.length;i++){  %>
                                                <option value="<%out.println(empleado[i][1]);%>"><%out.println(empleado[i][0]);%></option>
                                        <%  } %>

                                    </select>
                                </div>
                                <span class="col-md-12">C.C.</span>
                                <div class="form-group col-md-12">
                                    <select class="form-control" name="ticketConCopia"  id="ticketConCopia"   >


                                        <option value="null"></option>
                                        <%
                                        for (int i=0;i<empleado.length;i++){  %>
                                            <option value="<%out.println(empleado[i][1]);%>"><%out.println(empleado[i][0]);%></option>
                                        <%  } %>



                                    </select>
                                </div>
                            </div>
                            <hr width="100%" />
                            <div class="col-md-12">
                                <span class="col-md-12">Titulo</span>
                                <input type="text" name="ticketTitulo" id="ticketTitulo" class="col-md-12" >
                            </div>
                            <div class="col-md-12">
                                <span class="col-md-12">Descripción</span>
                                <textarea name="ticketDescripcion" id="ticketDescripcion" rows="4" cols="50"  class="col-md-12"  ></textarea>
                            </div>
                            <div class="col-md-6">
                                <span class="col-md-12">Prioridad</span>
                                <div class="form-group col-md-12">
                                    <select class="form-control"  name="ticketPrioridad" id="ticketPrioridad" >

                                        <%
                                            ticket_servicio ticket;
                                            ticket = new ticket_servicio();
                                            String tickets[][]=ticket.getPrioridadTicket();
                                            %>
                                                <option value="null"></option>
                                            <%
                                            for (int i=0;i<tickets.length;i++){  %>
                                                <option value="<%out.print(tickets[i][0]);%>"><%out.print(tickets[i][1]);%></option>
                                        <%  } %>


                                    </select>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <span class="col-md-12">Fecha de vencimiento</span>
                                <input type="date" class="col-md-12" name="fechaVencimientoTicket"  id="fechaVencimientoTicket" value="<%  out.print(  new SimpleDateFormat("yyyy-MM-dd").format(fechaActual)  );  %>"  >
                            </div>
                            <div class="col-md-12">

                            </div>
                            
                            <hr width="100%" />
                            
                            
                            
                            
                            <div class="col-md-12">
                                <input type = "submit" class="btn btn-md bla blb" value = "Crear Abierto" />
                            </div>

                           
                        
                        
                        </div>
                            
                    </form>
                </div>
                
                
                
                
                
                
                <div id="menu1" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-12">
                            <hr width="100%" />
                            <table class="ck table table-striped" class="ck" >
                                <thead>
                                    <tr>
                                        <th >Numero de Ticket</th>
                                        <th>Titulo</th>
                                        <th>Creación</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                        <th>Prioridad</th>
                                        <th>Creador</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    
                                    <%
                                        empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        empleados.get();
                                        
                                        ArrayList<String> estados=new ArrayList();
                                        estados.add("1"); //Abierto
                                        estados.add("2"); //Pendiente
                                        
                                        ticket = new ticket_servicio();
                                        tickets=ticket.getListaTicketPorPersona(  empleados.getIdPersona()+"",estados );
                                    
                                        

                                    %>
                                        
                                    <%    for (int i=0;i<tickets.length;i++){   %>
                                            <tr>
                                                
                                                <td><% out.println( tickets[i][0]  );  %></td>
                                                <td><% out.println( tickets[i][1]  );  %></td>
                                                <td><% out.println( tickets[i][3]  );  %></td>
                                                <td><% out.println( tickets[i][4]  );  %></td>
                                                <td><% out.println( tickets[i][10]  );  %></td>
                                                <td><% out.println( tickets[i][11]  );  %></td>
                                                
                                                <td><% out.println( tickets[i][12] +" "+tickets[i][13]+" "+tickets[i][14] );  %></td>
                                                
                                                <td><a  href="#docsModal" class="btn btn-md bla blb" data-toggle="modal" id="" onclick="verTicket(<% out.print(tickets[i][0]); %>, <% out.print(tickets[i][6]); %>,'<% out.print(tickets[i][1]); %>','<% out.print(   tickets[i][2].replaceAll("[\n\r]", "         ")  ); %>','<% out.print(tickets[i][12] +" "+tickets[i][13]+" "+tickets[i][14]); %>',<% out.print(tickets[i][9]); %>  )"  >VER <i class="fa fa-eye" ></i></a></td>
                                            </tr>   
                                    <%    }     %>
                        
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                
                
                
                
                
                
                <div id="menu2" class="tab-pane fade">
                    <div class="row">
                        <div class="col-md-12">
                            <hr width="100%" />
                            <table class="ck table table-striped" class="ck" >
                                <thead>
                                    <tr>
                                        <th >Numero de Ticket</th>
                                        <th>Titulo</th>
                                        <th>Creación</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                        <th>Prioridad</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    
                                    <%
                                        empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        empleados.get();
                                        
                                         estados=new ArrayList();
                                        estados.add("3"); //Cerrado
                                        
                                        
                                        ticket = new ticket_servicio();
                                        tickets=ticket.getListaTicketPorPersona(  empleados.getIdPersona()+"",estados );
                                    
                                    %>
                                        
                                    <%    for (int i=0;i<tickets.length;i++){   %>
                                            <tr>
                                                
                                                <td><% out.println( tickets[i][0]  );  %></td>
                                                <td><% out.println( tickets[i][1]  );  %></td>
                                                <td><% out.println( tickets[i][3]  );  %></td>
                                                <td><% out.println( tickets[i][4]  );  %></td>
                                                <td><% out.println( tickets[i][10]  );  %></td>
                                                <td><% out.println( tickets[i][11]  );  %></td>
                                                
                                                <td><a  href="#docsModal" class="btn btn-md bla blb" data-toggle="modal" id="" onclick="verTicket(<% out.print(tickets[i][0]); %>, <% out.print(tickets[i][6]); %>,'<% out.print(tickets[i][1]); %>','<% out.print(tickets[i][2].replaceAll("[\n\r]", "         ")); %>','<% out.print(tickets[i][12] +" "+tickets[i][13]+" "+tickets[i][14]); %>',<% out.print(tickets[i][9]); %>  )"  >VER <i class="fa fa-eye" ></i></a></td>
                                            </tr>   
                                    <%    }     %>
                        
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                                    
                <div id="menu3" class="tab-pane fade">      
                    
                    <div class="row">
                        <div class="col-md-12">
                            <hr width="100%" />
                            <table class="ck table table-striped" class="ck" >
                                <thead>
                                    <tr>
                                        <th >Numero de Ticket</th>
                                        <th>Titulo</th>
                                        <th>Creación</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                        <th>Prioridad</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    
                                    <%
                                        empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        empleados.get();
                                        
                                         estados=new ArrayList();
                                        estados.add("1"); //Abierto
                                        estados.add("2"); //Pendiente
                                        
                                        
                                        ticket = new ticket_servicio();
                                        tickets=ticket.getListaTicketPorPersonaTodos(empleados.getIdPersona()+"",estados );
                                    
                                    %>
                                        
                                    <%    for (int i=0;i<tickets.length;i++){   %>
                                            <tr>
                                                
                                                <td><% out.println( tickets[i][0]  );  %></td>
                                                <td><% out.println( tickets[i][1]  );  %></td>
                                                <td><% out.println( tickets[i][3]  );  %></td>
                                                <td><% out.println( tickets[i][4]  );  %></td>
                                                <td><% out.println( tickets[i][10]  );  %></td>
                                                <td><% out.println( tickets[i][11]  );  %></td>
                                                
                                                <td><a  href="#docsModal" class="btn btn-md bla blb" data-toggle="modal" id="" onclick="verTicket(<% out.print(tickets[i][0]); %>, <% out.print(tickets[i][6]); %>,'<% out.print(tickets[i][1]); %>','<% out.print(tickets[i][2].replaceAll("[\n\r]", "         ")); %>','<% out.print(empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()); %>',<% out.print(tickets[i][9]); %>  )"  >VER <i class="fa fa-eye" ></i></a></td>
                                            </tr>   
                                    <%    }     %>
                        
                                </tbody>
                            </table>
                        </div>
                    </div>
                    
                    
                    
                    
                    
                </div> 
                                    
                                    
                <div id="menu4" class="tab-pane fade">      
                    
                    <div class="row">
                        <div class="col-md-12">
                            <hr width="100%" />
                            <table class="ck table table-striped" class="ck" >
                                <thead>
                                    <tr>
                                        <th >Numero de Ticket</th>
                                        <th>Titulo</th>
                                        <th>Creación</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                        <th>Prioridad</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    
                                    
                                    <%
                                        empleados = new persona_servicio(Integer.parseInt(idUsuario));
                                        empleados.get();
                                        
                                         estados=new ArrayList();
                                        estados.add("3"); //Cerrado
                                        
                                        
                                        ticket = new ticket_servicio();
                                        tickets=ticket.getListaTicketPorPersonaTodos(empleados.getIdPersona()+"",estados );
                                    
                                    %>
                                        
                                    <%    for (int i=0;i<tickets.length;i++){   %>
                                            <tr>
                                                
                                                <td><% out.println( tickets[i][0]  );  %></td>
                                                <td><% out.println( tickets[i][1]  );  %></td>
                                                <td><% out.println( tickets[i][3]  );  %></td>
                                                <td><% out.println( tickets[i][4]  );  %></td>
                                                <td><% out.println( tickets[i][10]  );  %></td>
                                                <td><% out.println( tickets[i][11]  );  %></td>
                                                
                                                <td><a  href="#docsModal" class="btn btn-md bla blb" data-toggle="modal" id="" onclick="verTicket(<% out.print(tickets[i][0]); %>, <% out.print(tickets[i][6]); %>,'<% out.print(tickets[i][1]); %>','<% out.print(   tickets[i][2].replaceAll("[\n\r]", "         ")     ); %>','<% out.print(empleados.getApellidoPaterno()+" "+empleados.getApellidoMaterno()+" "+empleados.getNombre()); %>',<% out.print(tickets[i][9]); %>  )"  >VER <i class="fa fa-eye" ></i></a></td>
                                            </tr>   
                                    <%    }     %>
                        
                                </tbody>
                            </table>
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

<div id="docsModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            
            <div class="modal-header">
                <div class="col-md-12">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                </div>
            </div>
            
            
            <div class="modal-body">
                <div class="col-md-12">
                    <h4 id="myModalLabel">Ticket <span id="numeroTicketVer"></span></h4>
                    <input type="hidden" id="numeroTicket2" name="numeroTicket2" > 
                </div>
                 
                
                <div  class="col-md-12" style="background-color: #434857">
                    <span style="color: #FFFFFF">Propietario</span>
                    <div  class="form-group col-md-12" style="background-color: #434857"  >
                        <select id="propietarioTicketCombo"  name="propietarioTicketCombo" class="form-control" onchange="modificarPropietario()">

                            <%
                                empleados = new persona_servicio();
                                empleado=empleados.LISTAempleadosEstadoActivoYUsuarioAdministradoresString(empleados.ALTA);
                                %>
                                    <option value="null"></option>
                                <%
                                for (int i=0;i<empleado.length;i++){  %>
                                    <option value="<%out.print(empleado[i][1]);%>"><%out.println(empleado[i][0]);%></option>
                            <%  } %>


                        </select>
                    <br>
                    </div>
                </div>
                
                
                <div id="estadoColor0" class="col-md-12" style="background-color: #5cb85c">
                    <span id="estadoColor1" style="color: #FFFFFF" >Estado</span>
                </div>
                <div id="estadoColor2" class="form-group col-md-12" style="background-color: #5cb85c"  onchange="modificarEstado()" >
                    <select id="estadoTicketCombo" class="form-control">

                        <%
                            ticket = new ticket_servicio();
                            tickets=ticket.getEstadoTicket();
                        %>
                        <%  for (int i=0;i<tickets.length;i++){  %>
                            <option value="<% out.print(tickets[i][0]);  %>"><% out.print(tickets[i][1]);  %></option>
                        <%  }   %>

                    </select>
                    <br>
                </div>


                <hr width="100%" />
                <div class="col-md-12 text-right">
                    <i><span id="autorTicketVer"></span></i>
                </div>
                <div class="col-md-12">
                    <b><span id="tituloTicketVer"  >Titulo</span></b>
                </div>
                <div class="col-md-12">

                    <textarea id="descripcionTicketVer" rows="4" cols="50"  class="col-md-12" disabled ></textarea>
                </div>
                
                <hr width="100%" />
               
                <div class="col-md-12">
                    <div id="respuestasDelTicket"></div>
                </div>

            </div>
            
                            
                            
            <div class="om">
                <a  href="#respuestaModal" class="ce kh" data-toggle="modal" id="" onclick=""  >Responder</a>
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</div>
            
                        
                        
                        
<div id="respuestaModal" class="cb fade"  tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog modal-lg" >
        <div class="modal-content" style="background-color: coral">
            
            <div class="modal-header  ">
                <div class="col-md-12">
                    
                    <h4 id="myModalLabel">Responder</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                </div>
            </div>
            
            <form id="" action = "Servlet?controlador=insertarRespuestaTicket" method = "post" >
                <div class="modal-body">

                    <%
                        empleados = new persona_servicio(Integer.parseInt(idUsuario));
                        empleados.get();
                        ticket = new ticket_servicio();
                        
                    %>
                    <input type="hidden" id="numeroTicket3" name="numeroTicket3" > 
                    <input type="hidden" id="idPersonaRespuesta" name="idPersonaRespuesta" value="<%  out.print(empleados.getIdPersona()); %>" > 
                    <textarea name="textoRespuesta" id="textoRespuesta" rows="4" cols="50"  class="col-md-12"  ></textarea>




                </div>
                    
                    
                   

            
                <div class="om">
                    <input type="submit" class="ce kh"  value = "Enviar Respuesta" /> 
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                </div>
            </form>
        </div>
    </div>
</div>
                        
                            
<script>

    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=tickets';  
    } 
   
   $(document).ready(function(){
           
   });
   

    function verTicket(numeroTicket,estado,titulo,descripcion,nombre,propietario){
        
        
        document.getElementById('numeroTicketVer').innerHTML = numeroTicket;
        document.getElementById('numeroTicket2').value = numeroTicket;
        document.getElementById('numeroTicket3').value = numeroTicket;
        
        
        
        
        $.ajax  ({
                   type:'GET',
                   url:'Servlet?controlador=getRespuestasTicket&numeroTicket='+numeroTicket,
                   headers : {
                       Accept: "application/json; charset=utf-8",
                       "Content-Type" : "application/json; charset=utf-8"

                   },
                   success: function (data, textStatus, jqXHR) {
                        var count = Object.keys(data).length;
                        
                        var valores="";
                        
                        var i;
                        var j;
                        for (i = 0; i < count; i++) { 
                            
                            valores=valores+"<hr width=\"100%\" />";
                            
                                
                            valores=valores+"<div class=\"text-right\">";
                                valores=valores+"<i>";
                                    valores=valores+data[i][5]+" ";
                                    valores=valores+data[i][6]+" ";
                                    valores=valores+data[i][7];
                                valores=valores+"</i>";
                            valores=valores+"</div>";
                            valores=valores+data[i][1]; 
                        }
                        document.getElementById('respuestasDelTicket').innerHTML = valores
                      
                   }
               });
        
        
        
        
        
        $("#propietarioTicketCombo").val(propietario);
        
        
        if (estado==1){
            document.getElementById('estadoColor0').style = "background-color: #5cb85c";
            document.getElementById('estadoColor1').style = "background-color: #5cb85c";
            document.getElementById('estadoColor2').style = "background-color: #5cb85c";
            $("#estadoTicketCombo").val('1');
            
            
        }
        if (estado==2){
            document.getElementById('estadoColor0').style = "background-color: #ffff00";
            document.getElementById('estadoColor1').style = "background-color: #ffff00";
            document.getElementById('estadoColor2').style = "background-color: #ffff00";
            $("#estadoTicketCombo").val('2');
        }
        if (estado==3){
            document.getElementById('estadoColor0').style = "background-color: #F80000";
            document.getElementById('estadoColor1').style = "background-color: #F80000";
            document.getElementById('estadoColor2').style = "background-color: #F80000";
            $("#estadoTicketCombo").val('3');
        }
        
        
        document.getElementById('tituloTicketVer').innerHTML = titulo;
        document.getElementById('autorTicketVer').innerHTML = nombre;
        document.getElementById('descripcionTicketVer').value = descripcion;
        
     
    }
    
    
    
    function modificarPropietario(){
        
        var propietario = document.getElementById('propietarioTicketCombo').value;
        var numeroTicket2 = document.getElementById('numeroTicket2').value;
        
        var controlador = "cambiarPropietarioTicket";
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        $.post('Servlet', {
            controlador : controlador,
            idPropietarioTicket: propietario,
            numeroTicket2: numeroTicket2
           
        });
        
    }
      
    
    function modificarEstado(){
        
        var estado = document.getElementById('estadoTicketCombo').value;
        var numeroTicket2 = document.getElementById('numeroTicket2').value;
        
        var controlador = "cambiarEstadoTicket";
        // Si en vez de por post lo queremos hacer por get, cambiamos el $.post por $.get
        $.post('Servlet', {
            controlador : controlador,
            idEstadoTicket: estado,
            numeroTicket2: numeroTicket2
           
        });
        
        
        
        
        if (estado==1){
            document.getElementById('estadoColor0').style = "background-color: #5cb85c";
            document.getElementById('estadoColor1').style = "background-color: #5cb85c";
            document.getElementById('estadoColor2').style = "background-color: #5cb85c";
        }
        if (estado==2){
            document.getElementById('estadoColor0').style = "background-color: #ffff00";
            document.getElementById('estadoColor1').style = "background-color: #ffff00";
            document.getElementById('estadoColor2').style = "background-color: #ffff00";
        }
        if (estado==3){
            document.getElementById('estadoColor0').style = "background-color: #F80000";
            document.getElementById('estadoColor1').style = "background-color: #F80000";
            document.getElementById('estadoColor2').style = "background-color: #F80000";
        }
        
        
    }
      
    
    


</script>                         
                            


        <jsp:include page="../pieDePagina.jsp" flush="true"/>