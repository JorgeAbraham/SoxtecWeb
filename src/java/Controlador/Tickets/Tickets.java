/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Tickets;

import Controlador.Controlador;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
    
    
    public void cambiarPropietarioTicket(){
         String idPropietarioTicket=request.getParameter("idPropietarioTicket");
        String numeroTicket=request.getParameter("numeroTicket2");
        
        ticket_servicio T=new ticket_servicio();
        String idTicket = T.actualizaPropietarioTicket(numeroTicket, idPropietarioTicket);
        
        
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
        
        
        String idTicket = T.insertaRespuestaTicket(
                              numeroTicket, 
                              idPersonaRespuesta, 
                              textoRespuesta,
                              ordenInt+""
                          );
        
        
       
          
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
          
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/tickets/lista.jsp"); 
          
          
    }
    
    public void cambiarEstadoTicket(){
        
       
        
        String idEstadoTicket=request.getParameter("idEstadoTicket");
        String numeroTicket=request.getParameter("numeroTicket2");
        
        
        ticket_servicio T=new ticket_servicio();
        String idTicket = T.actualizaEstadoTicket(numeroTicket, idEstadoTicket);
        
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
