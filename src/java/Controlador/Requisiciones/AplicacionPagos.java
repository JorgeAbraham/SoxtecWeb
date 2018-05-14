/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Requisiciones;

import Controlador.Controlador;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.operaciones_servicio;

/**
 *
 * @author usuario
 */
public class AplicacionPagos extends Controlador {

    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
    
    
    public void lista() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/aplicacionPagos/lista.jsp");

    }
    
    public void aplicarPagoPendiente(){
        
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String idOperacion=request.getParameter("idOperacionAplicacionOrdenPago");
         
        operaciones_servicio OP=new operaciones_servicio();
        
        //Inserta Operaciones y actualiza el estado
        OP.actualizaEstado(idOperacion, "5");  //Aplicado
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             "5", //Aplicado
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioAplicadoOrdenesPago"),
                             "9"   //Aplicacion
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "6");  //Relacion de Aplicación
        
        //Se inserta Lugar Operacion
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "6");  //Relacion de Aplicación
        
        
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "9" ) ;  //Aplicacion
        
        
        for(int i=0;i<BaseOperaciones.length;i++){
            
            String ValorFormulario=request.getParameter( BaseOperaciones[i][4] );
            
            if (BaseOperaciones[i][2]==null){  //Valores que no son lista
                
                String tipoVariable=BaseOperaciones[i][3];
                String idConcepto=BaseOperaciones[i][5];
                String nombreHTML=BaseOperaciones[i][4];
                String conceptoOperacion=null;
                
                if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorFormulario);
                }
               
                if (operaciones_servicio.tipoNumero.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoNumero, ValorFormulario);
                }
                if (operaciones_servicio.tipoFecha.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoFecha, ValorFormulario);
                }
                if (operaciones_servicio.tipoTextoLargo.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTextoLargo, ValorFormulario);
                }
                if (operaciones_servicio.catalogo.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.catalogo, ValorFormulario);
                }
                
                if(conceptoOperacion!=null){
                    OP.insertaPertenenciaDeValores(idConcepto, conceptoOperacion, NumeroDeOperacion, null);
                }
             
            }
            else{   //Valores de la lista
                
                String idConcepto=BaseOperaciones[i][5];
                String tipoVariable=BaseOperaciones[i][3];
                String conceptoOperacion=null;
                
                String valores[]=request.getParameterValues(BaseOperaciones[i][4]);
                
                ArrayList<String> ValorArrayFormulario= new ArrayList<String>(Arrays.asList(valores));
                //Se revisa cada elemento de la lista
                for (int j=0;j<ValorArrayFormulario.size();j++){
                    
                    if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorArrayFormulario.get(j));
                    }
                    
                    if (operaciones_servicio.tipoNumero.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoNumero, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoFecha.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoFecha, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoTextoLargo.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTextoLargo, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.catalogo.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.catalogo, ValorArrayFormulario.get(j));
                    }

                    if (conceptoOperacion!=null){
                        OP.insertaPertenenciaDeValores(idConcepto, conceptoOperacion, NumeroDeOperacion, (j+1)+"");
                    }
                    
                }
                
            }
            
        }
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/aplicacionPagos/lista.jsp");
      
        
    }
    
    public void aplicarRegistroPago(){

        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String idOperacion=request.getParameter("idOperacionAplicacion");
         
        operaciones_servicio OP=new operaciones_servicio();
        
        //Inserta Operaciones y actualiza el estado
        OP.actualizaEstado(idOperacion, "5");  //Aplicado
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             "5", //Aplicado
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioAplicado"),
                             "3"   //Orden de Compra
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "2");  //Relacion de Aplicación
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "3" ) ;  //Aplicacion
        
        
        for(int i=0;i<BaseOperaciones.length;i++){
            
            String ValorFormulario=request.getParameter( BaseOperaciones[i][4] );
            
            if (BaseOperaciones[i][2]==null){  //Valores que no son lista
                
                String tipoVariable=BaseOperaciones[i][3];
                String idConcepto=BaseOperaciones[i][5];
                String nombreHTML=BaseOperaciones[i][4];
                String conceptoOperacion=null;
                
                if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorFormulario);
                }
               
                if (operaciones_servicio.tipoNumero.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoNumero, ValorFormulario);
                }
                if (operaciones_servicio.tipoFecha.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoFecha, ValorFormulario);
                }
                if (operaciones_servicio.tipoTextoLargo.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTextoLargo, ValorFormulario);
                }
                if (operaciones_servicio.catalogo.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.catalogo, ValorFormulario);
                }
                
                
                if(conceptoOperacion!=null){
                    OP.insertaPertenenciaDeValores(idConcepto, conceptoOperacion, NumeroDeOperacion, null);
                }
             
            }
            else{   //Valores de la lista
                
                String idConcepto=BaseOperaciones[i][5];
                String tipoVariable=BaseOperaciones[i][3];
                String conceptoOperacion=null;
                
                String valores[]=request.getParameterValues(BaseOperaciones[i][4]);
                
                ArrayList<String> ValorArrayFormulario= new ArrayList<String>(Arrays.asList(valores));
                //Se revisa cada elemento de la lista
                for (int j=0;j<ValorArrayFormulario.size();j++){
                    
                    if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorArrayFormulario.get(j));
                    }
                    
                    if (operaciones_servicio.tipoNumero.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoNumero, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoFecha.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoFecha, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoTextoLargo.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTextoLargo, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.catalogo.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.catalogo, ValorArrayFormulario.get(j));
                    }

                    if (conceptoOperacion!=null){
                        OP.insertaPertenenciaDeValores(idConcepto, conceptoOperacion, NumeroDeOperacion, (j+1)+"");
                    }
                    
                }
                
            }
            
        }
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/aplicacionPagos/lista.jsp");
      
        
    }
    
    
    
    
}
