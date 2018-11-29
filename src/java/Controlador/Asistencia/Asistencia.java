/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Asistencia;

import Controlador.Controlador;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Soxtec Desarrollo
 */
public class Asistencia extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void verHorarioAsistencia() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/Asistencia/Asistencia.jsp");

    }
    
    public void filtrarHorarioPorLugar() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=verHorarioAsistencia&idLugar="+request.getParameter("idLugar")+"");
    }
    
    
}
