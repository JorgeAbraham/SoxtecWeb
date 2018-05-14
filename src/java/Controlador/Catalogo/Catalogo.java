/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Catalogo;

import Controlador.Controlador;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.catalogo_servicio;

/**
 *
 * @author usuario
 */
public class Catalogo extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void lista() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/catalogo/lista.jsp");

    }
    
    
    public void crearCatalogo() {

        
        catalogo_servicio catalogo=new catalogo_servicio();
        catalogo.insertaCuenta  (
                                    request.getParameter("NombreCuenta"), 
                                    request.getParameter("DescrpcionCuenta")
                                );
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/catalogo/lista.jsp");

    }
    
}
