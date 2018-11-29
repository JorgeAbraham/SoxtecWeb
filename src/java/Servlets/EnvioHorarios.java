/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import serviciosBD.ManejadorDeDatos;
import serviciosBD.peticiones_json_servicio;
import utilidadesCurl.SendCurl;

/**
 *
 * @author Soxtec Desarrollo
 */
@WebServlet(name = "EnvioHorarios", urlPatterns = {"/EnvioHorarios"})
public class EnvioHorarios extends HttpServlet {

    
    
    public static ManejadorDeDatos M;
    
    @Override
    public void init(ServletConfig config) throws ServletException {   
        super.init(config);
        M=new ManejadorDeDatos();
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {

        BufferedReader BF;
        try {
            BF = request.getReader();
            StringBuilder sb = new StringBuilder();

            String line;
            while ((line = BF.readLine()) != null) {
                sb.append(line);
            }
            
            System.out.println(sb.toString());

            SendCurl S = new SendCurl();
            JSONObject myObject = null;
            JSONObject detalles;
            myObject = new JSONObject();

            try {
                JSONObject jsonObj = new JSONObject(sb.toString());
                peticiones_json_servicio JSON=new peticiones_json_servicio();
                
                System.out.println("Se intenta abrir base de datos y escribir en ella.");
                
                JSON.insertaJSON(sb.toString());
                
                for (int i = 0; i < jsonObj.length(); i++) {
                    JSONObject object = jsonObj.getJSONObject("details"+(i+1));
                    String uno = object.getString("UUID");        
                    System.out.println(uno);
                    detalles = new JSONObject();
                    detalles.put("UUID", uno);
                    String dos = object.getString("idPersonal");        
                    System.out.println(dos);
                    String tres = object.getString("estado");        
                    System.out.println(tres);
                    String cuatro = object.getString("fecha");        
                    System.out.println(cuatro);
                    String cinco = object.getString("hora");        
                    System.out.println(cinco);
                    myObject.put("details" + (i+1), detalles);
                }
                
            } catch (JSONException ex) {
                Logger.getLogger(EnvioHorarios.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
        } catch (IOException ex) {
            Logger.getLogger(EnvioHorarios.class.getName()).log(Level.SEVERE, null, ex);
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

}
