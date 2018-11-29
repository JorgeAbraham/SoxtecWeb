/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Nomina;

import Controlador.Controlador;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.ManejadorDeDatos;
import serviciosBD.documentos_servicio;
import serviciosBD.lugar_servicio;
import serviciosBD.operaciones_servicio;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author Soxtec Desarrollo
 */
public class Nomina extends Controlador {
    
    
    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }
    
    public void verListaDeNomina(){
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/nomina/lista.jsp");

    }
    
    
    
    public void borrarRegistroNomina(){
        
        String idRegistroNomina=request.getParameter("idRegistroNomina");
        
        operaciones_servicio operacion=new operaciones_servicio();
        operacion.actualizaEstado(idRegistroNomina, "20");
        
         utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/nomina/lista.jsp");
        
    }
    
    
    
    public void imprimeRecibo(){
        
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
        Map parameters = new HashMap();
        
        Date date = new Date();
        //Caso 2: obtener la fecha y salida por pantalla con formato:
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        
        parameters.put("fecha", dateFormat.format(date));
        parameters.put("semana", request.getParameter("sem"));
        parameters.put("anio", request.getParameter("anio"));
        parameters.put("operacion", request.getParameter("op"));
       
        utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"\\Nomina\\reciboDePago.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        
    }
    
    public void imprimeReciboTotal(){
        
        String carpetaReportes=Servlet.getServletContext().getInitParameter("CarpetaReportes");
        Map parameters = new HashMap();
        
        Date date = new Date();
        //Caso 2: obtener la fecha y salida por pantalla con formato:
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        
        parameters.put("fecha", dateFormat.format(date));
        parameters.put("semana", request.getParameter("sem"));
        parameters.put("anio", request.getParameter("anio"));

       
       
        
        
        utilidadesWeb.utilidadWeb.imprimeEnHtmlReporteJasper(carpetaReportes+"\\Nomina\\reciboDePagoTotal.jasper", response, ManejadorDeDatos.BD.getCon(), parameters );
        
    }
    
    
    
    public void informacionDeEmpleado(){
        
        String idpersona=request.getParameter("idpersona");
        
        lugar_servicio lugar=new lugar_servicio();
        String LUGAR[][]=lugar.listaLugaresPorIDPersona(idpersona);
        
        response.setContentType( "text/html; charset=iso-8859-1" );
        PrintWriter out;
        try {
            
            out = response.getWriter();
            out.println("<h2>Lugar: "+LUGAR[0][1]+"</h2>  <input type=\"hidden\" id=\"idLugarPersonaSeleccionada\" name=\"idLugarPersonaSeleccionada\" value=\""+LUGAR[0][0]+"\">   ");
           
            out.println("<input type=\"button\" class=\"btn btn-success col-12\"  value=\"Autogenerar Conceptos 12 Horas X 7 dias = 84 Horas\"  onclick=\"autogenerarHoras(84)\"/>");
            out.println("<input type=\"button\" class=\"btn btn-success col-12\"  value=\"Autogenerar Conceptos 12 Horas X 6 dias = 72 Horas\"  onclick=\"autogenerarHoras(72)\"/>");
            out.println("<input type=\"button\" class=\"btn btn-success col-12\"  value=\"Autogenerar Conceptos 12 Horas X 5 dias = 60 Horas\"  onclick=\"autogenerarHoras(60)\"/>");
            out.println("<input type=\"button\" class=\"btn btn-success col-6\"  value=\"Autogenerar Horas:\"  onclick=\"autogenerarHoras(getElementById('horasPersonalizadas').value)\"/><input type=\"text\" value=\"0\"  id=\"horasPersonalizadas\"  /> ");
        } catch (IOException ex) {
            Logger.getLogger(Nomina.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    
    
    public void acualizaModalEdicionRegistroNomina(){
        
        String idOperacion=request.getParameter("idOperacion");
        
        
        operaciones_servicio operacionNominaConceptos = new operaciones_servicio();
                                    
        ArrayList<String> tipoOperacionNominaConceptos=new ArrayList();
        tipoOperacionNominaConceptos.add("22");

        ArrayList<String> estadosOperacionNominaConceptos=new ArrayList();
        estadosOperacionNominaConceptos.add("19");

        ArrayList<String> idConceptoNominaConceptos=new ArrayList();
        ArrayList<Boolean> idConceptoNominaConceptosLista=new ArrayList();
        idConceptoNominaConceptos.add("124"); idConceptoNominaConceptosLista.add(false);
        idConceptoNominaConceptos.add("125"); idConceptoNominaConceptosLista.add(false);
        idConceptoNominaConceptos.add("126"); idConceptoNominaConceptosLista.add(false);

        idConceptoNominaConceptos.add("128"); idConceptoNominaConceptosLista.add(true);
        idConceptoNominaConceptos.add("129"); idConceptoNominaConceptosLista.add(true);
        idConceptoNominaConceptos.add("130"); idConceptoNominaConceptosLista.add(true);
        idConceptoNominaConceptos.add("131"); idConceptoNominaConceptosLista.add(true);

        String reqConceptos[][]=operacionNominaConceptos.listaOperacionesConcatenadas(idConceptoNominaConceptos,estadosOperacionNominaConceptos,tipoOperacionNominaConceptos,"","",0," AND 	o.idOperacion="+idOperacion+"     ",idConceptoNominaConceptosLista);

        
        String texto="";       
        String color="";
        
        
        
        float Cantidad=0;
       
            texto=texto+"<div class=\"card border-success mb-3\" >";
                texto=texto+"<div class=\"card-body text-success\">";
                    texto=texto+"<table class=\"table\">";
                      texto=texto+"<thead class=\"thead-dark\">";
                            texto=texto+"<tr>";
                                texto=texto+"<th scope=\"col\">Descripción</th>";
                                texto=texto+"<th scope=\"col\">Cantidad</th>";
                                texto=texto+"<th scope=\"col\">Importe</th>";
                            texto=texto+"</tr>";
                        texto=texto+"</thead>";
                      
                        texto=texto+"<tbody>";
                        
                            
                                
                            for (int j=0;j<reqConceptos.length;j++){
                               
                                Cantidad=Cantidad+ Float.parseFloat(reqConceptos[j][11]);
               
                                if (Float.parseFloat(reqConceptos[j][11])<0){
                                    color="class=\"table-danger\"";
                                }
                                
                                texto=texto+"<tr "+ color +" >";
                                
                                 /*
                                
                                    texto=texto="<td>"+reqConceptos[j][9]+"</td>";
                                    texto=texto="<td>"+reqConceptos[j][10]+"</td>";       
                                    texto=texto="<td>"+reqConceptos[j][11]+"</td>";  


*/
                                texto=texto="</tr>";       
                            
                            }
  
                         
                        texto=texto+"</tbody>";
                           
                    texto=texto+"</table>";
                    texto=texto+"<h1 class=\"text-right\">Total  $ "+Cantidad+"</h1>";
               
                texto=texto+"</div>";       
                    
            texto=texto+"</div>";         
               
                

            

        System.out.println(texto);


        response.setContentType( "text/html; charset=iso-8859-1" );
        PrintWriter out;
        try {
            
            out = response.getWriter();
            
            
            
            out.println( texto+
                        "<input type=\"hidden\" id=\"idRegistroOperacion\" name=\"idRegistroOperacion\" value=\""+idOperacion+"\" />");
            
            
        } catch (IOException ex) {
            Logger.getLogger(Nomina.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    
    
    
    
    
    public void registroNomina(){
        
        
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
                                "22"   //Captura de Inspeccion
                            );
        
        
        String BaseOperaciones[][] = OP.listaOperacionesBasePorTipo( "22" )   ;
        
        
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
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/nomina/lista.jsp");
        
        
        
    }
    
    
}
