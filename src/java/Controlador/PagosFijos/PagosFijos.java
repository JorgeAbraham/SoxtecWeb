/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.PagosFijos;

import Controlador.Controlador;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.operaciones_servicio;
import serviciosBD.pagos_fijos_servicio;
import static utilidadesFecha.sumaFecha.sumarDiasAFecha;
import static utilidadesFecha.sumaFecha.sumarMesAFecha;

/**
 *
 * @author usuario
 */
public class PagosFijos extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void lista() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/pagosFijos/lista.jsp");
    }
    
    public void crearPagoFijo() {
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        

        
        
        pagos_fijos_servicio pagosFijos=new pagos_fijos_servicio();
        String idPagoFijo=pagosFijos.insertaPagoFijo  (
                                    request.getParameter("fechaUltimaPago"), 
                                    request.getParameter("titulo"),
                                    request.getParameter("descripcion"),
                                    request.getParameter("periodo"),
                                    request.getParameter("Monto"),
                                    request.getParameter("fechaCalculoFinal"),
                                    request.getParameter("Cuenta")
                                    
                                );
        
        String usuariosIds[]=request.getParameterValues("usuarios");
         
        for (int i=0;i<usuariosIds.length;i++){
            pagosFijos.insertaCorreoPagoFijo(idPagoFijo, usuariosIds[i]);
        }
        
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        
        Date fechaInicial=null;
        Date fechaFinal=null;
        
        try {
            fechaInicial = dateFormat.parse(request.getParameter("fechaUltimaPago"));
            fechaFinal = dateFormat.parse(request.getParameter("fechaCalculoFinal"));
        } catch (ParseException ex) {
            Logger.getLogger(PagosFijos.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        
        
        // Se empieza con la programacion de los pagos Fijos
        
        String periodo[][]=pagosFijos.listaPeriodos(request.getParameter("periodo"));
        
        Date fechaProgramada=fechaInicial;
        String pagoFijoId=null;
        
        while (fechaProgramada.getTime()<fechaFinal.getTime()){
            if (periodo[0][3].equals("1")){ //Día
                fechaProgramada=sumarDiasAFecha(fechaProgramada, Integer.parseInt( periodo[0][2] )   );
            }
            if (periodo[0][3].equals("2")){ //Semana
                fechaProgramada=sumarDiasAFecha(fechaProgramada, Integer.parseInt( periodo[0][2] )   );
            }
            if (periodo[0][3].equals("3")){ //Mes
                fechaProgramada=sumarMesAFecha(fechaProgramada, Integer.parseInt( periodo[0][2] )   );
            }
            if (periodo[0][3].equals("4")){  //Año
                fechaProgramada=sumarMesAFecha(fechaProgramada, Integer.parseInt( periodo[0][2] )   );
            }
            
            if (fechaProgramada.getTime()<fechaFinal.getTime()){
                
                operaciones_servicio OP=new operaciones_servicio();
                
                 //Crea una Operacion de Aprovacion Rechazo
                String NumeroDeOperacion=OP.insertaOperacion(
                             "9", ////Pago Pendiente
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("idUsuario"),
                             "10"   //Programación de Pago Fijo
                         );
        
                        //Se inserta la informacion en la tabla pertenencia de valores
                String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "10" ) ;  //Aplicacion

                UUID uuid = UUID.randomUUID();
                pagosFijos.insertaPagoProgramado(
                                            formateador.format(fechaProgramada), 
                                            NumeroDeOperacion, 
                                            idPagoFijo, 
                                            "1", 
                                            uuid.toString()
                                        );
                
                //Se recorren las Variables Base
                for(int i=0;i<BaseOperaciones.length;i++){
                    
                    String ValorFormulario=null;
                    if (BaseOperaciones[i][4].equals("UsuarioPagoFijo")){
                        ValorFormulario = request.getParameter("idUsuario");
                    }
                    if (BaseOperaciones[i][4].equals("FechaPagoFijo")){
                        ValorFormulario = formateador.format(date);
                    }
                    if (BaseOperaciones[i][4].equals("DescripcionPagoFijo")){
                        ValorFormulario = request.getParameter("descripcion");
                    }
                    if (BaseOperaciones[i][4].equals("MontoPagoFijo")){
                        ValorFormulario = request.getParameter("Monto");
                    }
                    if (BaseOperaciones[i][4].equals("CuentaPagoFijo")){
                        ValorFormulario = request.getParameter("Cuenta");
                    }
                
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

                
                
            }
            
            
            
        }
        
       
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/pagosFijos/lista.jsp");
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public void aplicarPagoFijo(){
        
        
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String idOperacion=request.getParameter("idOperacionAplicacionPagoFijo");
         
        operaciones_servicio OP=new operaciones_servicio();
        
        //Inserta Operaciones y actualiza el estado
        OP.actualizaEstado(idOperacion, "15");  //Aplicado
        
        
        //Crea una Operacion de Aprovacion Rechazo
        String NumeroDeOperacion=OP.insertaOperacion(
                             "15", //Realizado
                             formateador.format(date),
                             formateador.format(date),
                             request.getParameter("UsuarioPagadoFijo"),
                             "11"   //Aplicacion
                         );
        
        
        // Se inserta la relacion entre las operaciones 
        OP.insertaRelacionOperaciones(idOperacion, NumeroDeOperacion, "7");  //Relacion de Aplicación
        
        //Se inserta la informacion en la tabla pertenencia de valores
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "11" ) ;  //Aplicacion
        
        
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
