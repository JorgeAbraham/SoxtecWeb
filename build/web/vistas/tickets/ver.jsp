<%@page import="serviciosBD.persona_servicio"%>
<%@page import="serviciosBD.ticket_servicio"%>
<%@page import="java.util.Date"%>
<jsp:include page="../cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">

        <jsp:include page="../menu.jsp" flush="true"/>


        <div class="et bmj">

            <jsp:include page="../menuSuperior.jsp" flush="true"/>



            <div class="bkz aav aaj">
                <h3 class="bla blb">Reportes</h3>
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                <% String ticketHash=(String)request.getParameter("ticketID");   %>
                
            </div>    
                
                
            <i class="fa fa-sticky-note-o" style="font-size:48px"></i>
            
            
            <%
                ticket_servicio T=new ticket_servicio();
                String respuestas[][]=T.getTicketPorHash(ticketHash);
                for (int i=0;i<respuestas.length;i++){ %>
                    <div class="col-md-12 text-right">
                        <h4 id="myModalLabel">Ticket <% out.print(respuestas[0][0]);%><span id="numeroTicketVer"></span></h4>
                        <input type="hidden" id="numeroTicket2" name="numeroTicket2" > 
                    </div>
                 
                    <div  class="col-md-12" style="background-color: #434857">
                        <span style="color: #FFFFFF">Propietario</span>
                        <div  class="form-group col-md-12" style="background-color: #434857"  >
                            <select id="propietarioTicketCombo"  name="propietarioTicketCombo" class="form-control" onchange="modificarPropietario()">

                                 <%
                                    persona_servicio empleados = new persona_servicio();

                                    String empleado[][]=empleados.LISTAempleadosEstadoActivoYUsuarioAdministradoresString(empleados.ALTA);
                                    %>
                                        <option value="null"></option>
                                    <%
                                    for (int j=0;j<empleado.length;j++){  
                                        if (respuestas[i][9].equals(empleado[j][1])){ %>
                                            <option selected value="<%out.print(empleado[j][1]);%>"><%out.println(empleado[j][0]);%></option>
                                        <% }else{  %>
                                            <option value="<%out.print(empleado[j][1]);%>"><%out.println(empleado[j][0]);%></option>
                                    <%  }
                                    }


                                 %>


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
                                ticket_servicio ticket = new ticket_servicio();
                                String tickets[][]=ticket.getEstadoTicket();
                            %>
                            <%  for (int j=0;j<tickets.length;j++){  %>
                                <%  if (tickets[j][0].equals(respuestas[i][6])) {%>
                                    <option selected value="<% out.print(tickets[j][0]);  %>"><% out.print(tickets[j][1]);  %></option>  
                                <%  } else {%>
                                    <option value="<% out.print(tickets[j][0]);  %>"><% out.print(tickets[j][1]);  %></option>
                                <%  } %>
                                    
                            <%  }   %>
                            </select>
                        <br>
                    </div>


                <hr width="100%" />
                <div class="col-md-12 text-right">
                    
                    
                   
                    <% 
                        persona_servicio empl = new persona_servicio(Integer.parseInt(respuestas[i][8]));
                        empl.get();
                        
                    %>
                    
                    
                    <i><span id="autorTicketVer"><% out.print(empl.getApellidoPaterno()+" "+empl.getApellidoMaterno()+" "+empl.getNombre());  %></span></i>
                </div>
                <div class="col-md-12">
                    <b><span id="tituloTicketVer"  ><% out.print(respuestas[i][1]);  %></span></b>
                </div>
                <div class="col-md-12">

                    <textarea id="descripcionTicketVer" rows="4" cols="50"  class="col-md-12" disabled ><% out.print(respuestas[i][2]);  %></textarea>
                </div>
                
                <hr width="100%" />
               
                <div class="col-md-12">
                     <hr width="100%" />
                        
                            
                                <%
                                ticket_servicio ticketRespuestas = new ticket_servicio();
                                String respuestasTicket[][]=ticketRespuestas.getListaRespuestasTicket(respuestas[0][0]);
                                
                                for (int j=0;j<respuestasTicket.length;j++){ %>
                                    <div class="text-right"><i><% out.print(respuestasTicket[j][5]+" "+respuestasTicket[j][6]+" "+respuestasTicket[j][7]);  %></i></div>
                                    <% out.print(respuestasTicket[j][1]); %>
                                
                                
                                <% } %>
                                
                                
                               
                </div>

            </div>
                
            <%  }  %>
            
            
            
            <hr>
            
           
        </div>
    </div>                         
</div>               
                                    
                                    
                                    
    
                        
                        
                        
                        
                

<script>
    
    function actualizarBotonCabecera(){
         window.location='Servlet?controlador=tickets';  
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
            
   