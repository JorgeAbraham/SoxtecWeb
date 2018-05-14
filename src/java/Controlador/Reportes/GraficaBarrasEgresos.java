/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Reportes;

import Controlador.Controlador;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.ManejadorDeDatos;

/**
 *
 * @author usuario
 */
public class GraficaBarrasEgresos extends Controlador {
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
    
    public void graficaGeneral() {
        
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
       
        utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"graficaEgresos.jasper", response, ManejadorDeDatos.BD.getCon());
    }
    
    public void ver() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/reportes/ver.jsp");
    }
    
    public void graficaFiltrada() {
        
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
        Map parameters = new HashMap();
        
        String fechaInicio=request.getParameter("fechaInicio");
        String fechaFin=request.getParameter("fechaFin");
        String Lugar=request.getParameter("Lugar");
        
        parameters.put("fechaInicio", fechaInicio);
        parameters.put("fechaFin", fechaFin);
        parameters.put("Lugar", Lugar);
        
        String tipo=request.getParameter("tipoGrafica");
        
        if (  tipo.equals("1")   ){
        
            utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"reportePagoAplicadoPorMeses.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        }
        if (  tipo.equals("2")   ){
        
            utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"reportePagoAplicadoPorLugar.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        }
        if (  tipo.equals("3")   ){
        
            utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"reportePagoAplicadoPorSemana.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        }
    }
}
