/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;




import Controlador.Tickets.Tickets;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import serviciosBD.ManejadorDeDatos;
import serviciosBD.peticiones_web_servicio;
import serviciosBD.usuario_servicio;




@WebServlet(name = "Servlet", urlPatterns = {"/Servlet"})
public class Servlet extends HttpServlet {

    
    public static ManejadorDeDatos M;
    
    @Override
    public void init(ServletConfig config) throws ServletException 
    {
        
        
        super.init(config);
        M=new ManejadorDeDatos();
     
        
        
        
    }
       
    public HttpSession SignInBD(String Email, String Pass, String idUsuario, HttpSession session ){
        usuario_servicio servicioAcceso=new usuario_servicio();
        idUsuario=servicioAcceso.acceso(Email, Pass);

        if (idUsuario!=null){
            if (!idUsuario.equals("")){
                session.setAttribute("idUsuario", idUsuario );
            }
        }else{
            System.out.println("Conexion Caida- Reconectando");
            M=new ManejadorDeDatos();
        }
        
        return session;
    }
       
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           
            HttpSession session = request.getSession();
            String idUsuario=(String)session.getAttribute("idUsuario");
            
            if (idUsuario==null){ //Si NO HAY, SESSION LA CREA
                String inputEmail=request.getParameter("inputEmail");
                String inputPassword=request.getParameter("inputPassword");
                
                session=SignInBD(inputEmail,inputPassword,idUsuario,session);
                     
                
            }
            
   
            //parametro de XML
            String Base=this.getServletContext().getInitParameter("host");
            
            //Cada peticion analiza el parametro controlador = ALGO y lo compara contra nombreVista de la tabla Vista
            if ( request.getParameter("controlador")!=null )
            {
                
                peticiones_web_servicio peticion=new peticiones_web_servicio();
                peticion.setNombreVista(request.getParameter("controlador"));
                peticion.setIdUsuario(idUsuario);
                peticion.getVistasPorNombre();
                
                if (peticion.getControlador()==null){  //No coincide el login, vuelve a mostrar login
                    
                    if (request.getParameter("controlador").equals("ticketToken")){
                          
                        Tickets T=new Tickets();
                        T.init( this , request, response, Base);
                        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(this, request, response, "/vistas/tickets/ver.jsp");
                        
                    }else{
                        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(this, request, response, "/");
                    }
                    
                    
                }
                else{
                    try {
                        try {
                             try {
                                 try {
                                        //Class userClass = Class.forName("Controlador.Acceso.Acceso");
                                        Class userClass = Class.forName(peticion.getControlador());
                                        Method metodo = userClass.getMethod("init",HttpServlet.class ,HttpServletRequest.class ,HttpServletResponse.class ,String.class );

                                        Object instancia=userClass.newInstance();

                                        metodo.invoke(instancia, this , request, response, Base);

                                         //Method metodo2 = userClass.getMethod("out" );
                                        Method metodo2 = userClass.getMethod( peticion.getMetodo() );
                                        metodo2.invoke(   instancia    );

                                     } 
                                 catch (InstantiationException | IllegalAccessException ex) {
                                     Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                                 }
                             } 
                             catch (IllegalArgumentException | InvocationTargetException ex) {
                                 Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                             }
                         } 
                         catch (NoSuchMethodException | SecurityException ex) {
                             Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                         }
                     } 
                     catch (ClassNotFoundException ex) {
                         Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                     }
                }
                
                
                
                


                
            }
            
             
        
    }
    
    
    
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         processRequest(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    
    
    public static void main(String Args[]){
       
              
        
        
                
        try {
          
            	
            try {
              
                
                try {
                      
                    try {
                        
                        Class userClass = Class.forName("Acciones.Tablero.SubirArchvio");
                        userClass.newInstance();
                        Method metodo = userClass.getMethod("out");
                        metodo.invoke(userClass.newInstance());
                        
                        
                    } catch (InstantiationException | IllegalAccessException ex) {
                        Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                      
                
                } catch (IllegalArgumentException | InvocationTargetException ex) {
                    Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                
                
            } catch (NoSuchMethodException | SecurityException ex) {
                Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
               
                
                
           
        
        
    }
    
    
    
    
}
