/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Operaciones;

import Controlador.Controlador;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author usuario
 */
public class Operaciones extends Controlador {
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
    
    public void verTodasOperaciones() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/operaciones/lista.jsp");
    }
    
}
