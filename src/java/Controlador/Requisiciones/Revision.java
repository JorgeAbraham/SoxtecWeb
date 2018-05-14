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
import serviciosBD.documentos_servicio;
import serviciosBD.operaciones_servicio;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author usuario
 */
public class Revision  extends Controlador {
     public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
     
     
    public void lista() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/lista.jsp");
    }
    
    
    public void procesarPagoPendiente() {
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String aprovacion=request.getParameter("aprobacionComprobada");
        String idOperacion=request.getParameter("idOperacionComprobada");
        
      
        operaciones_servicio OP=new operaciones_servicio();
        
        
        //Inserta Operaciones y actualiza el estado
        OP.actualizaEstado(idOperacion, aprovacion);
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             aprovacion,
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioApruebaRechazaOrdenesPag"),
                             "8"   //Orden de Compra
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "5");  
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "8" )   ;
        
        
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
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/lista.jsp");
    }
    
    
    public void revisarPagoPendiente() {
        
        
        String idOperacion=request.getParameter("numeroOperacion");
        operaciones_servicio OS=new operaciones_servicio();
        
        String estado[][]=OS.operacionCalificada(idOperacion);
        
        if (    estado[0][0].equals("3")  || 
                estado[0][0].equals("4")  ||
                estado[0][0].equals("5")  || 
                estado[0][0].equals("6")  || 
                estado[0][0].equals("7")  ||
                estado[0][0].equals("8")  
            ){  //Distinto de aprobado, rechazado, aplicado, por Comprobar y Comprobado
        
        }
        else{
            OS.actualizaEstado(idOperacion, "2");
        }
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/verPagoPendiente.jsp");
        
        
        
    }
  
    
    
    
    public void procesarComprobanteCompra(){
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String aprovacion=request.getParameter("aprobacionComprobada");
        String idOperacion=request.getParameter("idOperacionComprobada");
        
      
        operaciones_servicio OP=new operaciones_servicio();
        
        
        //Inserta Operaciones y actualiza el estado
        OP.actualizaEstado(idOperacion, aprovacion);
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             aprovacion,
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioApruebaRechazaComprobacion"),
                             "2"   //Orden de Compra
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "4");  
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "5" )   ;
        
        
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
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/lista.jsp");
    }
    
    
    public void ver() {
        String idOperacion=request.getParameter("numeroOperacion");
        operaciones_servicio OS=new operaciones_servicio();
        
        String estado[][]=OS.operacionCalificada(idOperacion);
        
        if (    estado[0][0].equals("3")  || 
                estado[0][0].equals("4")  ||
                estado[0][0].equals("5")  || 
                estado[0][0].equals("6")  || 
                estado[0][0].equals("7")  ||
                estado[0][0].equals("8")  
            ){  //Distinto de aprobado, rechazado, aplicado, por Comprobar y Comprobado
        
        }
        else{
            OS.actualizaEstado(idOperacion, "2");
        }
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/ver.jsp");
    }
     
    
    
    public void autorizarOrdenCompra(){
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String aprovacion=request.getParameter("aprobacion");
        String idOperacion=request.getParameter("idOperacion");
        String cuenta=request.getParameter("cuenta");
        
         
        operaciones_servicio OP=new operaciones_servicio();
        
        
        //Inserta Operaciones y actualiza el estado
        
        if (!aprovacion.equals("4")){//Si se rechazo
            OP.insertaOperacionesCuenta(idOperacion, cuenta);
        }
        
        OP.actualizaEstado(idOperacion, aprovacion);
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             aprovacion,
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioApruebaRechaza"),
                             "2"   //Orden de Compra
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        
        
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "1");  
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "2" )   ;
        
        
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
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/revision/lista.jsp");
    }
    
    
     
}
