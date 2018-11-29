/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Autos;

import Controlador.Controlador;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.catalogo_servicio;
import serviciosBD.documentos_servicio;
import serviciosBD.operaciones_servicio;
import serviciosBD.usuario_servicio;
import utilidadEmail.CorreoElectronico;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author usuario
 */
public class Autos extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void verExpedienteAutos() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/automovil/lista.jsp");

    }
    
    public void registroAutomovil(){

        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        operaciones_servicio OP=new operaciones_servicio();
                // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "17",   //Orden de Compra
                                formateador.format(date),
                                formateador.format(date),
                                "1",//utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuario"),
                                "12"   //Autos
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "12" )   ;
        
        
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
        
        
        
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=verExpedienteAutos");
        
      
        
    }
    
    public void verAutomovil(){
        
         utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/automovil/ver.jsp");
         
    }
    
    public void editaValorAuto(){
        
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        
        String idConceptoOperacion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idConceptoOperacion");
        String idTipoVariable=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idTipoVariable");
        String idConcepto=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idConcepto");
      
        operaciones_servicio OP=new operaciones_servicio();
        
        String conceptoOperacion;   
         String valorEdicion;
        if ( idTipoVariable.equals(operaciones_servicio.tipoTexto) ){  //Texto 
            
           
            valorEdicion = utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
            
            conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
            
        }
        if (idTipoVariable.equals(operaciones_servicio.tipoArchivo) ){  //Archivo
            ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
            ArrayList<String> nombreVariableEnForm=utilidadesWeb.utilidadWeb.listaDeParametrosDeArchivosSubidosPeticionMultipart(peticion);
                    
            for (int j=0;j<Archivos.size();j++){

                if ( nombreVariableEnForm.get(j).equals("valorEdicion")  ){

                    archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(j));
                    documentos_servicio documentos=new documentos_servicio();
                    String idArchivoInsertado=documentos.insertDocument(archivo);
                                    
                    conceptoOperacion = OP.actualizaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado, idConceptoOperacion);

                }

            }
        }
        if (idTipoVariable.equals("3") ){  //Numero
             valorEdicion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
             conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
        }
        if (idTipoVariable.equals("4") ){  //Fecha
             valorEdicion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
             conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
        }
        if (idTipoVariable.equals("5")){  //Area
             valorEdicion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
             conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
        }
        if (idTipoVariable.equals("6")){  //Catalogo
            
            if (idConcepto.equals("39")){
                
                valorEdicion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
                conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
                
            }
            if (idConcepto.equals("51")){
                valorEdicion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "valorEdicion");
                conceptoOperacion=OP.actualizaInformacion(idTipoVariable,valorEdicion, idConceptoOperacion);
            }
            
        }
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=verAutomovil&numeroOperacion="+utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "numeroOperacion"));
         
    }
    
    
}
