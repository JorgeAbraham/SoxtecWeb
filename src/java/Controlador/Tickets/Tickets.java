/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */



package Controlador.Tickets;

import Controlador.Controlador;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import serviciosBD.persona_servicio;
import serviciosBD.ticket_servicio;
import serviciosBD.usuario_servicio;
import utilidadEmail.CorreoElectronico;

/**
 *
 * @author usuario
 */
public class Tickets extends Controlador {
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
    
    
    public void lista() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/lista.jsp");

    }
    
    
    public void ticketToken(){
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/ver.jsp");
         
         
        
    }
    
    
    public void supervisionTicket(){
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/listaSupervision.jsp");
        
    }
    
    
    public void cambiarPropietarioTicket(){
        String idPropietarioTicket=request.getParameter("idPropietarioTicket");
        String numeroTicket=request.getParameter("numeroTicket2");
        
        ticket_servicio T=new ticket_servicio();
        String idTicket = T.actualizaPropietarioTicket(numeroTicket, idPropietarioTicket);
        
        
        
        String ticket[][]=T.getTicket(idTicket);
        
        
        String Base=Servlet.getServletContext().getInitParameter("host");
        String MailAuth=Servlet.getServletContext().getInitParameter("MailAuth");
        String MailStartTLS=Servlet.getServletContext().getInitParameter("MailStartTLS");
        String MailHost=Servlet.getServletContext().getInitParameter("MailHost");
        String MailPort=Servlet.getServletContext().getInitParameter("MailPort");
        String MailSoxtec=Servlet.getServletContext().getInitParameter("MailSoxtec");
        String MailPassword=Servlet.getServletContext().getInitParameter("MailPassword");
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", MailAuth);
        props.put("mail.smtp.starttls.enable", MailStartTLS);
        props.put("mail.smtp.host", MailHost);
        props.put("mail.smtp.port", MailPort);
        utilidadEmail.CorreoElectronico CE=new CorreoElectronico( props,
                                                        MailSoxtec, 
                                                        MailPassword
                                                    );
        
        usuario_servicio asignado=new usuario_servicio();
        String asignados[][] = asignado.usuarioPorID(idPropietarioTicket);
        
        for (int i=0;i<asignados.length;i++){
            
            CE.enviaStartTLS(
                                asignados[i][4],
                                "Se te ha ASIGNADO SOX-TIC-"+ticket[0][5]+" "+ticket[0][1], 
                                "Se te ha asignado un ticket: Contenido \n"+ticket[0][1]+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+ticket[0][5]
                            );
            
        }
        
        
    }
    
    
    public void insertarRespuestaTicket(){
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
            
        UUID uuid = UUID.randomUUID();
            
        String numeroTicket=request.getParameter("numeroTicket3");
        String idPersonaRespuesta=request.getParameter("idPersonaRespuesta");
        String textoRespuesta=request.getParameter("textoRespuesta");
     
        
        ticket_servicio T=new ticket_servicio();
        
        String orden[][]=T.getUltimoOrdenRespuestasTicket(numeroTicket);
        int ordenInt=0;
   
        if (  orden.length==0 ){
            ordenInt=1;
        }
        else{
            ordenInt=Integer.parseInt(orden[0][2])+1;
        }
        
        
        String ticket[][]=T.getTicket(numeroTicket);
        
        String idRespuestaTicket = T.insertaRespuestaTicket(
                              numeroTicket, 
                              idPersonaRespuesta, 
                              textoRespuesta,
                              ordenInt+""
                          );
        
          
        String Base=Servlet.getServletContext().getInitParameter("host");
        String MailAuth=Servlet.getServletContext().getInitParameter("MailAuth");
        String MailStartTLS=Servlet.getServletContext().getInitParameter("MailStartTLS");
        String MailHost=Servlet.getServletContext().getInitParameter("MailHost");
        String MailPort=Servlet.getServletContext().getInitParameter("MailPort");
        String MailSoxtec=Servlet.getServletContext().getInitParameter("MailSoxtec");
        String MailPassword=Servlet.getServletContext().getInitParameter("MailPassword");
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", MailAuth);
        props.put("mail.smtp.starttls.enable", MailStartTLS);
        props.put("mail.smtp.host", MailHost);
        props.put("mail.smtp.port", MailPort);
        utilidadEmail.CorreoElectronico CE=new CorreoElectronico( props,
                                                        MailSoxtec, 
                                                        MailPassword
                                                    );
        
        usuario_servicio asignado=new usuario_servicio();
        String asignados[][] = asignado.usuarioPorID(ticket[0][8]);
        
        for (int i=0;i<asignados.length;i++){
            
            CE.enviaStartTLS(
                                asignados[i][4],
                                "Se ha respondido un ticket que creaste SOX-TIC-"+ticket[0][5]+" "+ticket[0][1], 
                                "Se ha respondido un ticket que creaste: Contenido de la Respuesta:\n"+textoRespuesta+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+ticket[0][5]
                            );
            
        }
       
          
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/lista.jsp"); 
          
          
    }
    
    
    
    public void nuevoTicket(){
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
            
        UUID uuid = UUID.randomUUID();
            
        
        
        String ticketAsignado=request.getParameter("ticketAsignado");
        String ticketConCopia=request.getParameter("ticketConCopia");
        String ticketTitulo=request.getParameter("ticketTitulo");
        String ticketDescripcion=request.getParameter("ticketDescripcion");
        String fechaVencimientoTicket=request.getParameter("fechaVencimientoTicket");
        String ticketPrioridad=request.getParameter("ticketPrioridad");
        
        String idUsuario=request.getParameter("idUsuario");
        
 
        
        persona_servicio P=new persona_servicio(Integer.parseInt(idUsuario));
        P.get();
        
          
        ticket_servicio T=new ticket_servicio();
        String idTicket = T.insertaTicket(
                              ticketTitulo, 
                              ticketDescripcion, 
                              formateador.format(date), 
                              fechaVencimientoTicket, 
                              uuid.toString(),
                              "1",  // Abierto
                              ticketPrioridad, 
                              P.getIdPersona()+"", 
                              ticketAsignado
                          );
        
        
        
        
        
        T.insertaTicketHistorial(idTicket, P.getIdPersona()+"");
        T.insertaTicketHistorial(idTicket, ticketConCopia);
        T.insertaTicketConCopia(idTicket,  ticketConCopia);
        
        
        String Base=Servlet.getServletContext().getInitParameter("host");
        String MailAuth=Servlet.getServletContext().getInitParameter("MailAuth");
        String MailStartTLS=Servlet.getServletContext().getInitParameter("MailStartTLS");
        String MailHost=Servlet.getServletContext().getInitParameter("MailHost");
        String MailPort=Servlet.getServletContext().getInitParameter("MailPort");
        String MailSoxtec=Servlet.getServletContext().getInitParameter("MailSoxtec");
        String MailPassword=Servlet.getServletContext().getInitParameter("MailPassword");
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", MailAuth);
        props.put("mail.smtp.starttls.enable", MailStartTLS);
        props.put("mail.smtp.host", MailHost);
        props.put("mail.smtp.port", MailPort);
        utilidadEmail.CorreoElectronico CE=new CorreoElectronico( props,
                                                        MailSoxtec, 
                                                        MailPassword
                                                    );
        
        usuario_servicio asignado=new usuario_servicio();
        String asignados[][] = asignado.usuarioPorID(ticketAsignado);
        
        for (int i=0;i<asignados.length;i++){
            
            CE.enviaStartTLS(
                                asignados[i][4],
                                "Un nuevo ticket se te ha ASIGNADO SOX-TIC-"+uuid.toString()+" "+ticketTitulo, 
                                "Se te ha asignado un ticket: Contenido \n"+ticketDescripcion+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+uuid.toString()
                            );
            
        }
        
        
        
        usuario_servicio ticketCC=new usuario_servicio();
        String usuarioTicketCC[][] = ticketCC.usuarioPorID(ticketConCopia);
        
        for (int i=0;i<usuarioTicketCC.length;i++){
            
            CE.enviaStartTLS(
                                usuarioTicketCC[i][4],
                                "Se te ha COPIADO en un ticket SOX-TIC-"+uuid.toString()+" "+ticketTitulo, 
                                "Se te ha COPIADO un ticket: Contenido \n"+ticketDescripcion+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+uuid.toString()
                            );
            
        }
        
        
        
        usuario_servicio usuarioTicket=new usuario_servicio();
        String usuariosTicket[][] = usuarioTicket.usuarioPorIdUsuario(idUsuario);
        
        for (int i=0;i<usuarioTicketCC.length;i++){
            CE.enviaStartTLS(
                                usuariosTicket[i][4],
                                "Has creado un ticket SOX-TIC-"+uuid.toString()+" "+ticketTitulo, 
                                "Has creado un ticket: Contenido \n"+ticketDescripcion+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+uuid.toString()
                            );
        }
       
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/lista.jsp"); 
          
          
    }
    
    public void cambiarEstadoTicket(){
        
       
        
        String idEstadoTicket=request.getParameter("idEstadoTicket");
        String numeroTicket=request.getParameter("numeroTicket2");
        
        
        ticket_servicio T=new ticket_servicio();
        String idTicket = T.actualizaEstadoTicket(numeroTicket, idEstadoTicket);
        
        
        String Base=Servlet.getServletContext().getInitParameter("host");
        String MailAuth=Servlet.getServletContext().getInitParameter("MailAuth");
        String MailStartTLS=Servlet.getServletContext().getInitParameter("MailStartTLS");
        String MailHost=Servlet.getServletContext().getInitParameter("MailHost");
        String MailPort=Servlet.getServletContext().getInitParameter("MailPort");
        String MailSoxtec=Servlet.getServletContext().getInitParameter("MailSoxtec");
        String MailPassword=Servlet.getServletContext().getInitParameter("MailPassword");
        
        String ticket[][]=T.getTicket(idTicket);
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", MailAuth);
        props.put("mail.smtp.starttls.enable", MailStartTLS);
        props.put("mail.smtp.host", MailHost);
        props.put("mail.smtp.port", MailPort);
        utilidadEmail.CorreoElectronico CE=new CorreoElectronico( props,
                                                        MailSoxtec, 
                                                        MailPassword
                                                    );
        
        usuario_servicio asignado=new usuario_servicio();
        String asignados[][] = asignado.usuarioPorID(ticket[0][8]);
        
        
        String estado[][]=T.getEstadoById(idEstadoTicket);
        
        
        for (int i=0;i<asignados.length;i++){
            
            CE.enviaStartTLS(
                                asignados[i][4],
                                "Se te ha CAMBIADO EL ESTADO DEL TICKET SOX-TIC-"+ticket[0][5]+" "+ticket[0][1]+" ["+estado[0][0]+"]", 
                                "Contenido \n"+ticket[0][1]+" \n\n"+Base+"Servlet?controlador=ticketToken&ticketID="+ticket[0][5]
                            );
            
        }
        
        
        
        
    }
    
    public void getRespuestasTicket(){
       
        
        String numeroTicket=request.getParameter("numeroTicket");
       
        ticket_servicio T=new ticket_servicio();
        String respuestas[][]=T.getListaRespuestasTicket(numeroTicket);
        
        
        
        
        try {
            
            JSONObject jo = new JSONObject();
            
            for (int i=0;i<respuestas.length;i++){
                ArrayList<String> list = new ArrayList<String>();
                
                list.add( respuestas[i][0] );
                list.add( respuestas[i][1] );
                list.add( respuestas[i][2] );
                list.add( respuestas[i][3] );
                list.add( respuestas[i][4] );
                list.add( respuestas[i][5] );
                list.add( respuestas[i][6] );
                list.add( respuestas[i][7] );
                
                
                jo.put(i+"", new JSONArray(list));
                
            }
         
            
            try {
                response.setContentType("application/json; charset=utf-8");
                response.getWriter().write(jo.toString());
            } catch (IOException ex) {
                Logger.getLogger(Tickets.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
        } catch (JSONException ex) {
            Logger.getLogger(Tickets.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }
    
    
}
