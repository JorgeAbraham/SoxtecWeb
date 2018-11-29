/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Formatos;

import Controlador.Controlador;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.ManejadorDeDatos;
import serviciosBD.documentos_servicio;
import serviciosBD.operaciones_servicio;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author Soxtec Desarrollo
 */
public class Formatos extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    
    public void registroFormatosRevision(){
             utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/lista.jsp");

    }
    
    public void formatoRevisionPuertas(){
             utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/formatoPuertas.jsp");

    }
    
    
    public void reportesFormatosRevision(){
             utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/listaReportes.jsp");

    }
    
    public void  formatoRevisionArneses(){
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/formatoArneses.jsp");
    }
    
    
    
    
    public void crearRegistroFormato(){
        
        
        
      
        
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        operaciones_servicio OP=new operaciones_servicio();
                // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "19",   //Registrado
                                formateador.format(date),
                                formateador.format(date),
                                utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuario"),
                                "13"   //Captura de Inspeccion
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "13" )   ;
        
        
        for(int i=0;i<BaseOperaciones.length;i++){
            
            
            
            String ValorFormulario=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, BaseOperaciones[i][4]);
            
            
            if (BaseOperaciones[i][2]==null){  //Valores que no son lista
                
                
                String tipoVariable=BaseOperaciones[i][3];
                String idConcepto=BaseOperaciones[i][5];
                String nombreHTML=BaseOperaciones[i][4];
                String conceptoOperacion=null;
                
                if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorFormulario);
                }
                if (operaciones_servicio.tipoArchivo.equals(tipoVariable)){
                     
                    ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
                    for (int j=0;j<Archivos.size();j++){

                        archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(j));
                        documentos_servicio documentos=new documentos_servicio();
                        String idArchivoInsertado=documentos.insertDocument(archivo);
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado);                    
                    }
                        
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
                
                ArrayList<String> ValorArrayFormulario=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, BaseOperaciones[i][4]);
                //Se revisa cada elemento de la lista
                for (int j=0;j<ValorArrayFormulario.size();j++){
                    
                    
                    
                    
                    
                    if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoArchivo.equals(tipoVariable)){

                        ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
                        for (int k=0;k<Archivos.size();k++){

                            archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(k));
                            documentos_servicio documentos=new documentos_servicio();
                            String idArchivoInsertado=documentos.insertDocument(archivo);
                            conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado);                    
                        }

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
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/formatoPuertas.jsp");
        
        
      
    }
    
    
    public void crearRegistroFormatoArnes(){
        
        
        
      
        
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        operaciones_servicio OP=new operaciones_servicio();
                // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "19",   //Registrado
                                formateador.format(date),
                                formateador.format(date),
                                utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuario"),
                                "16"   //Captura de Inspeccion
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "16" )   ;
        
        
        for(int i=0;i<BaseOperaciones.length;i++){
            
            
            
            String ValorFormulario=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, BaseOperaciones[i][4]);
            
            
            if (BaseOperaciones[i][2]==null){  //Valores que no son lista
                
                
                String tipoVariable=BaseOperaciones[i][3];
                String idConcepto=BaseOperaciones[i][5];
                String nombreHTML=BaseOperaciones[i][4];
                String conceptoOperacion=null;
                
                if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                    conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorFormulario);
                }
                if (operaciones_servicio.tipoArchivo.equals(tipoVariable)){
                     
                    ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
                    for (int j=0;j<Archivos.size();j++){

                        archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(j));
                        documentos_servicio documentos=new documentos_servicio();
                        String idArchivoInsertado=documentos.insertDocument(archivo);
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado);                    
                    }
                        
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
                
                ArrayList<String> ValorArrayFormulario=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, BaseOperaciones[i][4]);
                //Se revisa cada elemento de la lista
                for (int j=0;j<ValorArrayFormulario.size();j++){
                    
                    
                    
                    
                    
                    if (operaciones_servicio.tipoTexto.equals(tipoVariable)){
                        conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoTexto, ValorArrayFormulario.get(j));
                    }
                    if (operaciones_servicio.tipoArchivo.equals(tipoVariable)){

                        ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
                        for (int k=0;k<Archivos.size();k++){

                            archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(k));
                            documentos_servicio documentos=new documentos_servicio();
                            String idArchivoInsertado=documentos.insertDocument(archivo);
                            conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado);                    
                        }

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
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/formatos/formatoArneses.jsp");
        
        
      
    }
    
    
    public void reportesFormatosPuertasHoy(){
    
    
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
        Map parameters = new HashMap();
        
        Date date = new Date();

        //Caso 2: obtener la fecha y salida por pantalla con formato:
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        
        parameters.put("fechaIncial", dateFormat.format(date));
        parameters.put("fechaFinal", dateFormat.format(date));
        parameters.put("horaInicial", "00:00:00");
        parameters.put("horaFinal", "24:00:00");
       
        
        utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"FormatoPuertasHOY.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        
        
    }
    
    
    
    public void formatoRevisionPuertasFecha(){
        
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
        Map parameters = new HashMap();

        parameters.put("fechaIncial",  request.getParameter("fechaIncial"));
        parameters.put("fechaFinal", request.getParameter("fechaFinal"));
        parameters.put("horaInicial",request.getParameter("horaIncial"));
        parameters.put("horaFinal", request.getParameter("horaFinal"));
        
        
        System.out.println( request.getParameter("fechaIncial") );
        System.out.println( request.getParameter("fechaFinal") );
        System.out.println( request.getParameter("horaIncial") );
        System.out.println( request.getParameter("horaFinal") );
        
        
        utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"FormatoPuertasHOY.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        
        
        
        
    }
}
