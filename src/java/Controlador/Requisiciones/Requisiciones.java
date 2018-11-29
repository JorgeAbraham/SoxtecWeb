/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Requisiciones;

import Controlador.Controlador;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.documentos_servicio;
import serviciosBD.operaciones_servicio;
import serviciosBD.usuario_servicio;
import utilidadEmail.CorreoElectronico;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author usuario
 */
public class Requisiciones extends Controlador {

    public final int montRequisicionesBajo=3000;
    public final int montRequisicionesMedio=5000;
    
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void lista() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/requisicion/lista.jsp");

    }

    public void verRequisicionPagoPendiente() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/requisicion/verPagoPendiente.jsp");
    }
    
    
    public void verRequisicion() {
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/requisicion/ver.jsp");
    } 
    
    
    public void crear() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/requisicion/crear.jsp");

    }
    
    public void crearPagoPendiente() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/requisicion/crearPagoPendiente.jsp");

    }
    

    public void registraPagoPendiente(){

        
        // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();   
     
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        
        
        
        operaciones_servicio OP=new operaciones_servicio();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "1",   //Solicitud
                                formateador.format(date),
                                formateador.format(date),
                                utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuario"),
                                "7"   //Orden de Pago
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "7" )   ;
        
        
        for(int i=0;i<BaseOperaciones. length;i++){
            
            
            
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
                    ArrayList<String> nombreVariableEnForm=utilidadesWeb.utilidadWeb.listaDeParametrosDeArchivosSubidosPeticionMultipart(peticion);
                    
                    
                    
                    for (int j=0;j<Archivos.size();j++){

                        if ( nombreVariableEnForm.get(j).equals(nombreHTML)  ){

                            archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(j));
                            documentos_servicio documentos=new documentos_servicio();
                            String idArchivoInsertado=documentos.insertDocument(archivo);
                            conceptoOperacion=OP.insertaInformacion(operaciones_servicio.tipoArchivo, idArchivoInsertado);                    
                            
                        }
                        
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
        
         
        
        
        
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=comprobarPago");
        
      
        
    }

    
    public void crearOrdenDeCompra(){

        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        operaciones_servicio OP=new operaciones_servicio();
                // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "1",   //Orden de Compra
                                formateador.format(date),
                                formateador.format(date),
                                utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuario"),
                                "1"   //Solicitud
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "1" )   ;
        
        
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
        
        
        
        
        String Base=Servlet.getServletContext().getInitParameter("host");
        String MailAuth=Servlet.getServletContext().getInitParameter("MailAuth");
        String MailStartTLS=Servlet.getServletContext().getInitParameter("MailStartTLS");
        String MailHost=Servlet.getServletContext().getInitParameter("MailHost");
        String MailPort=Servlet.getServletContext().getInitParameter("MailPort");
        String MailSoxtec=Servlet.getServletContext().getInitParameter("MailSoxtec");
        String MailPassword=Servlet.getServletContext().getInitParameter("MailPassword");
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", MailAuth);
        props.put("mail.smtp.starttls.enable", MailStartTLS);
        props.put("mail.smtp.host", MailHost);
        props.put("mail.smtp.port", MailPort);
        utilidadEmail.CorreoElectronico CE=new CorreoElectronico( props,
                                                        MailSoxtec, 
                                                        MailPassword
                                                    );
        
      
        
        String usuarioNombre=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion,"userName" );
        String fechaEntrega=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion,"FechaEntrega" );
        String descripcion=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion,"DescRazon" );
        String total=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion,"Total" );
        ArrayList<String> cantidad=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, "Cantidad");
        ArrayList<String> descripcionArticulo=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, "DescripcioDeAriculo");
        ArrayList<String> precioUnitario=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, "PrecioUnitario");
        ArrayList<String> importe=utilidadesWeb.utilidadWeb.ArrayDeVariablaDePeticionMultipart(peticion, "Importe");
                
        
        
        usuario_servicio enviarCorreoPerfilAdministrativo=new usuario_servicio();
        String asignados[][]=new String[0][0];
            
        if (Double.parseDouble(total)  < montRequisicionesBajo  ){
            asignados = enviarCorreoPerfilAdministrativo.emailPorIDPerfil("6");
        }
        if (Double.parseDouble(total)  >= montRequisicionesBajo && Double.parseDouble(total) < montRequisicionesMedio ){
            asignados = enviarCorreoPerfilAdministrativo.emailPorIDPerfil("7");
        }
        if (Double.parseDouble(total)  >= montRequisicionesMedio  ){
            asignados = enviarCorreoPerfilAdministrativo.emailPorIDPerfil("8");
        }
                
        
        
        
        
        
        String conceptos="";
        for (int i=0;i<cantidad.size();i++){
            conceptos=conceptos+cantidad.get(i)+"\t "+descripcionArticulo.get(i)+"\t "+precioUnitario.get(i)+"\t "+importe.get(i)+"\n ";
        }
            
        
        
        //Se envia el Correo
        for (int i=0;i<asignados.length;i++){
            
            CE.enviaStartTLS(
                                asignados[i][0],
                                usuarioNombre+" ha solicitado un nuevo requerimiento.", 
                                "TE HEMOS ENVIADO UNA SOLICITUD POR FAVOR VERIFICA TU PORTAL EN INTRANET"
                                
                                /* usuarioNombre+" solicito: \nDescripción: \n"+" Numero de Operación: "+NumeroDeOperacion+"  Fecha de entrega: "+fechaEntrega+"    \n\n"+
                                descripcion+"\n"+
                                "Cantidad\t Descripción \t Precio Unitario \t Importe \n"+
                                conceptos+
                                "Total $"+total 
                                */
                            );
            
        }
        
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=requisiciones");
        
      
        
    }
    
    
}
