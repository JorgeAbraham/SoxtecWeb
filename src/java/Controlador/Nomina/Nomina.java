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
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import serviciosBD.ManejadorDeDatos;
import serviciosBD.catalogo_servicio;
import serviciosBD.documentos_servicio;
import serviciosBD.lugar_servicio;
import serviciosBD.operaciones_servicio;
import serviciosBD.persona_servicio;
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
        
        String idRegistroNomina=request.getParameter("idRegistroNominaBorrar");
        
        operaciones_servicio operacion=new operaciones_servicio();
        operacion.actualizaEstado(idRegistroNomina, "20");
        
         utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/nomina/lista.jsp");
        
    }
    
    
    public void verificaRegistroNomina(){
        
        String idRegistroNomina=request.getParameter("idRegistroNominaVerifica");
        String verificaEstadoID=request.getParameter("verificaEstadoID");
        
        operaciones_servicio operacion=new operaciones_servicio();
        operacion.actualizaEstado(idRegistroNomina, verificaEstadoID);
        
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
        
        System.out.println(dateFormat.format(date));
        System.out.println(request.getParameter("sem"));
        System.out.println(request.getParameter("anio"));
        System.out.println(request.getParameter("op"));
        
       
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
    
    
    public void buscaEmpleado(){
        
        String lugarSeleccion=request.getParameter("lugarSeleccion");
        String buscarFiltro=request.getParameter("buscarFiltro");
        
        
        lugar_servicio lugar=new lugar_servicio();
        
        String LUGAR[][]=null;
        if (!lugarSeleccion.equals("")){
           
            LUGAR = lugar.lugaresPorId(lugarSeleccion);
        }
    
        
        String nombreLugar="";
         
        if (LUGAR != null){
            if (LUGAR.length>0){
                if (!LUGAR[0][1].equals("")){
                    nombreLugar= " AND  nombre='" + LUGAR[0][1] + "'";
                }
               
            }
        }
         
         persona_servicio servicio=new persona_servicio();
         String Servicio[][]=servicio.LISTAEmpleadosPorStringYSinAsignar(
                                                                            " v.valorTexto='ingresado'  OR  v.valorTexto='alta'     OR   v.valorTexto='sinDefinir'   OR   v.valorTexto='paroTecnico'   ",
                                                                            "  name like '%"+buscarFiltro+"%'  "+nombreLugar+"      "   
                                                                        );
     
        response.setContentType( "text/html; charset=iso-8859-1" );
        
        JSONArray ja = new JSONArray();
        JSONObject json;
        for (int i=0;i<Servicio.length;i++){
            try {
               
                json=new JSONObject();
                
                json.put("0", Servicio[i][0]);
                json.put("1", Servicio[i][1]);
                json.put("2", Servicio[i][2]);
                json.put("3", Servicio[i][3]);
                json.put("4", Servicio[i][4]);
                
                ja.put(i,json);
                
            } catch (JSONException ex) {
                Logger.getLogger(Nomina.class.getName()).log(Level.SEVERE, null, ex);
            }
          
            
        }
        
        JSONObject mainObj = new JSONObject();
        try {
            mainObj.put("employees", ja);
           
        } catch (JSONException ex) {
            Logger.getLogger(Nomina.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
         
        
        PrintWriter out;
        try {
            
            out = response.getWriter();
            out.println(mainObj);
           
        } catch (IOException ex) {
            Logger.getLogger(Nomina.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        
    }
    
    public void acualizaModalEdicionRegistroNomina(){
        
        String idOperacion=request.getParameter("idOperacion");
        
         //$("idLugarPersonaSeleccionada").remove();
        
        operaciones_servicio operacionNominaConceptos = new operaciones_servicio();
                                    
        ArrayList<String> tipoOperacionNominaConceptos=new ArrayList();
        tipoOperacionNominaConceptos.add("22");


        ArrayList<String> estadosOperacionNominaConceptos=new ArrayList();
        estadosOperacionNominaConceptos.add("19");
        estadosOperacionNominaConceptos.add("24");

        ArrayList<String> idConceptoNominaConceptos=new ArrayList();
        ArrayList<Boolean> idConceptoNominaConceptosLista=new ArrayList();
        idConceptoNominaConceptos.add("124"); idConceptoNominaConceptosLista.add(false); //fechaNomina    5
        idConceptoNominaConceptos.add("125"); idConceptoNominaConceptosLista.add(false); //SemanaNomina  6
        idConceptoNominaConceptos.add("126"); idConceptoNominaConceptosLista.add(false); //anioNomina   7
        idConceptoNominaConceptos.add("127"); idConceptoNominaConceptosLista.add(false); //personaNomina  8

        idConceptoNominaConceptos.add("128"); idConceptoNominaConceptosLista.add(true); //conceptoNomina
        idConceptoNominaConceptos.add("129"); idConceptoNominaConceptosLista.add(true); //descrpcionNomina
        idConceptoNominaConceptos.add("130"); idConceptoNominaConceptosLista.add(true); //cantidadNomina
        idConceptoNominaConceptos.add("131"); idConceptoNominaConceptosLista.add(true); //ImporteNomina
        
        
        
        
        
        String reqConceptos[][]=operacionNominaConceptos.listaOperacionesConcatenadas(idConceptoNominaConceptos,estadosOperacionNominaConceptos,tipoOperacionNominaConceptos,"","",0," AND 	o.idOperacion="+idOperacion+"     ",idConceptoNominaConceptosLista);

        
        String texto="";       
        if(reqConceptos!=null){
        if(reqConceptos.length>0){
        
                    lugar_servicio lugar=new lugar_servicio();
                    String LUGAR[][]=lugar.listaLugaresPorIDPersona(reqConceptos[0][8]);   //127






                    String color="";

                    catalogo_servicio C = new catalogo_servicio();
                    String conceptos[][]=C.listaPorTipoCatalogo(16); 
                    String conceptosLista;


                    texto=texto+"<input type=\"hidden\" id=\"idLugarPersonaSeleccionada\" name=\"idLugarPersonaSeleccionada\" value=\""+LUGAR[0][0]+"\">";
                        texto=texto+"<input type=\"hidden\" id=\"nuevoNumeroDeFilas\" name=\"nuevoNumeroDeFilas\" value=\""+(reqConceptos.length)+"\">";
                        texto=texto+"<input type=\"hidden\" id=\"fechaNomina\" name=\"fechaNomina\"     value=\""+reqConceptos[0][5]+"\">";
                        texto=texto+"<input type=\"hidden\" id=\"SemanaNomina\" name=\"SemanaNomina\"   value=\""+reqConceptos[0][6]+"\">";
                        texto=texto+"<input type=\"hidden\" id=\"anioNomina\" name=\"anioNomina\"       value=\""+reqConceptos[0][7]+"\">";
                        texto=texto+"<input type=\"hidden\" id=\"personaNomina\" name=\"personaNomina\" value=\""+reqConceptos[0][8]+"\">";




                    float Cantidad=0;

                        texto=texto+"<div class=\"card border-success mb-3\" >";
                            texto=texto+"<div class=\"card-body text-success\">";
                                texto=texto+"<table class=\"table\"  id=\"tabla6\" >";
                                  texto=texto+"<thead class=\"thead-dark\">";
                                        texto=texto+"<tr>";
                                            texto=texto+"<th scope=\"col\">Concepto</th>";
                                            texto=texto+"<th scope=\"col\">Descripción</th>";
                                            texto=texto+"<th scope=\"col\">Cantidad</th>";
                                            texto=texto+"<th scope=\"col\">Importe</th>";

                                        texto=texto+"</tr>";
                                    texto=texto+"</thead>";

                                    texto=texto+"<tbody>";



                                        for (int j=0;j<reqConceptos.length;j++){

                                            Cantidad=Cantidad+ Float.parseFloat(reqConceptos[j][12]);

                                            if (Float.parseFloat(reqConceptos[j][11])<0){
                                                color="class=\"table-danger\"";
                                            }

                                            texto=texto+"<tr "+ color +" >";


                                                conceptosLista="";
                                                for (int i=0;i<conceptos.length;i++){  
                                                    if (conceptos[i][0].equals(reqConceptos[j][9])){
                                                        conceptosLista=conceptosLista+"<option value=\'"+conceptos[i][0]+"\'   selected=\"selected\"  >"+conceptos[i][1]+"</option>";
                                                    }
                                                    else{
                                                        conceptosLista=conceptosLista+"<option value=\'"+conceptos[i][0]+"\'  >"+conceptos[i][1]+"</option>";
                                                    }

                                                 }  



                                                texto=texto+"<td><div class=\'form-group\'>"+
                                                                "<select id=\'conceptoNomina_"+(j+1)+"' name=\'conceptoNomina[]\' class=\'\' onchange=\'cambiarComboConcepto("+(j+1)+")\'    >"+
                                                                    "<option value=\'\'></option>"+
                                                                    conceptosLista+
                                                                "</select>"+
                                                            "</div></td>";



                                                        //+reqConceptos[j][8]+"\" ></td>";






                                                texto=texto+"<td><input type=\"text\" class=\"form-control\" name=\'descrpcionNomina[]\' id=\"descrpcionNomina_"+(j+1)+"\"  value=\""+reqConceptos[j][10]+"\"   onkeyup=\"calcularTotales(event);\"   ></td>";
                                                texto=texto+"<td><input type=\"text\" class=\"form-control\" name=\'cantidadNomina[]\' id=\"cantidadNomina_"+(j+1)+"\" value=\""+reqConceptos[j][11]+"\"  onkeyup=\"calcularTotales(event);\"    ></td>";
                                                texto=texto+"<td><input type=\"text\" class=\"form-control\" name=\'ImporteNomina[]\' id=\"ImporteNomina_"+(j+1)+"\" value=\""+reqConceptos[j][12]+"\"  onkeyup=\"calcularTotales(event);\"   ></td>";




                                            texto=texto+"</tr>";       

                                        }


                                    texto=texto+"</tbody>";

                                texto=texto+"</table>";

                                texto=texto+"<h1 class=\"text-right\">Total  $ ";
                                texto=texto+"<input type=\"text\" name=\"costoTotal\"  id=\"costoTotal\"   class=\"col-md-4\" value=\""+Cantidad+"\"  >";



                                texto=texto+"</h1>";


                                texto=texto+"<a href='javascript:;' class=\"col-md-2 btn btn-white btn-md bla blb \" onclick=\"agregaFila(6);\" >Agregar <i class=\"fa fa-plus-circle\" ></i> </a>";
                                texto=texto+"<div class=\"col-md-8\"></div>";
                                texto=texto+"<a href='javascript:;' class=\"col-md-2  btn btn-white btn-md bla blb \" onclick=\"eliminaFila(6);\" >Eliminar <i class=\"fa fa-remove\" ></i></a>";


                            texto=texto+"</div>";       

                        texto=texto+"</div>";         

                
        }
        }   

        response.setContentType( "text/html; charset=iso-8859-1" );
        PrintWriter out;
        try {
            
            out = response.getWriter();
            
            
            
            out.println( texto +
                        "<input type=\"hidden\" id=\"idRegistroOperacionEditar\" name=\"idRegistroOperacionEditar\" value=\""+idOperacion+"\" />");
            
            
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
    
    
    public void editaRegistroNomina(){
        
        

        
        
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        
                
        String idRegistroNomina=utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idRegistroOperacionEditar");
        
        
        operaciones_servicio operacion=new operaciones_servicio();
        operacion.actualizaEstado(idRegistroNomina, "23");
        
         
        
        operaciones_servicio OP=new operaciones_servicio();
                // el que formatea
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        Date date=new Date();
        
        String NumeroDeOperacion=OP.insertaOperacion(
                               "19",   //Registrado
                                formateador.format(date),
                                formateador.format(date),
                                utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idUsuarioEditar"),
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
