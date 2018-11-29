



<%@page import="serviciosBD.usuario_servicio"%>
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
                <h3 class="bla blb">Supervicion de Tickets</h3>
                
                <% String host=application.getInitParameter("host");  %>
                <% String idUsuario=(String)session.getAttribute("idUsuario");  %>
                <% Date fechaActual = new Date(); %>
                
              </div>
            
            
           
            <div class="row">
                <div class="col-md-12">
                    <hr width="100%" />
                    <table class="ck table table-striped" class="ck" >
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Usuario</th>
                                <th>Tickets Abiertos</th>
                                <th>Tickers Cerrados</th>
                                <th></th>
                                
                            </tr>
                        </thead>
                        <tbody>


                            <%
                                usuario_servicio usuario = new usuario_servicio();
                                String usuarios[][]=usuario.getUsuariosPersonaTickets();
                            %>

                            <%    for (int i=0;i<usuarios.length;i++){   %>
                                    <tr>

                                        <td><% out.println( usuarios[i][1]  );  %></td>
                                        <td><% out.println( usuarios[i][2]+" "+usuarios[i][3]+" "+usuarios[i][4]  );  %></td>
                                        <td><% out.println( usuarios[i][5]  );  %></td>
                                        <td><% out.println( usuarios[i][6]  );  %></td>
                                        

                                        <td><a href="<% out.println(host); %>Servlet?controlador=tickets&idUsuario=<% out.println(usuarios[i][0]); %>" class="btn btn-md bla blb">Revisar <i class="fa fa-search" ></i></a></td>
                                    </tr>   
                            <%    }     %>

                        </tbody>
                    </table>
                </div>
            </div>
                    
            
           

   

            <hr class="aav">

                
                
            </div>

            <div class="dh bmk">
                <div class="et bmj">

                </div>
            </div>
        </div>

        
                            
<script>

    function actualizarBotonCabecera(){
        window.location='Servlet?controlador=tickets';  
    } 
   
   $(document).ready(function(){
       
        
   });
   

    
    
    


</script>                         
                            


        <jsp:include page="../pieDePagina.jsp" flush="true"/>