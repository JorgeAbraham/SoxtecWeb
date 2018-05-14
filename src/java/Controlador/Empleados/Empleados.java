/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Empleados;

import Controlador.Controlador;
import java.util.ArrayList;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serviciosBD.documentos_servicio;
import serviciosBD.persona_servicio;
import utilidadesWeb.utilidadWeb;
import utilidadesbasicas.archivoSerializableParaBD;

/**
 *
 * @author Abraham
 */
public class Empleados extends Controlador {

    public void init(HttpServlet Servlet, HttpServletRequest request, HttpServletResponse response, String Base) {
        Control(Servlet, request, response, Base);
    }

    public void lista() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/empleado/lista.jsp");

    }

    public void perfil() {

        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/empleado/perfil.jsp");

    }
    
    public void crearEmpleado() {

        persona_servicio persona=new persona_servicio();
        
        persona.setApellidoPaterno(request.getParameter("ApellidoPaterno"));
        persona.setApellidoMaterno(request.getParameter("ApellidoMaterno"));
        persona.setNombre(request.getParameter("Nombre"));
        persona.setIdTipoPersona(2); //Empleado
        String idPersona=persona.agregar();
        
        persona.agregaPersonaLugar(request.getParameter("Lugar"), idPersona, "1");//Relacion Laboral
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/vistas/empleado/lista.jsp");

    }
    
    
    
    

    public void subirArchivoEnBD() {
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
        for (int i=0;i<Archivos.size();i++){
            
            archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(i));
            documentos_servicio documentos=new documentos_servicio();
            String idArchivoInsertado=documentos.insertDocument(archivo);

            documentos_servicio documentos2=new documentos_servicio();
            System.out.println(   documentos2.insertaRequisito(
                                            utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersona") , 
                                            idArchivoInsertado, 
                                             utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idVariableAlmacenamiento") 
                                        )   );
        }
   
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersona")+"");

    }
    
    public void editarInformacion() {
        
        documentos_servicio documento=new documentos_servicio();
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditar"), 
                                        request.getParameter("idVariableAlmacenamientoEditar"), 
                                        request.getParameter("idTipoEditar"), 
                                        request.getParameter("valorEditar")
                                    );
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+request.getParameter("idPersonaEditar")+"");
    }
    
    
    public void descargarArchivo(){
        
        archivoSerializableParaBD archivo  = utilidadesbasicas.utilidadVinculoBD.operacionSQSelectBlob("archivo", "idArchivo", Integer.parseInt(request.getParameter("requisitoId")), "archivo","nombreArchivo");
        utilidadWeb.downloadUbicacion(response, archivo);
        
    }
    
    
    public void editarEstado() {
        
        documentos_servicio documento=new documentos_servicio();
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarEstado"), 
                                        "29", 
                                        "1", //Texto Tipo de dato
                                        request.getParameter("valorEditar")
                                    );
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+request.getParameter("idPersonaEditarEstado")+"");
    }
    
    
    
    public void agregaIncidencia() {
        
        String idArchivoInsertado=null;
        documentos_servicio documentos;
        documentos_servicio documento=new documentos_servicio();
        
        ArrayList peticion[]=utilidadesWeb.utilidadWeb.subirArchivo(Servlet, request,"c:/Temp/");
        
        String indice=documento.consultaIndiceDeRequerimiento(
                                        utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersonaEditarIncidencias"), 
                                        "5"
                                    );
        if (indice == null){ //Se busca en los requisitos si el valor tiene indice
            indice="1";
        }else{
            indice=(Integer.parseInt(indice)+1)+"";
        }
        
        
        ArrayList<String> Archivos=utilidadesWeb.utilidadWeb.listaDeArchivosSubidosPeticionMultipart(peticion);
        for (int i=0;i<Archivos.size();i++){
            
            archivoSerializableParaBD archivo=new  archivoSerializableParaBD(Archivos.get(i));
            
            documentos = new documentos_servicio();
            
            idArchivoInsertado = documentos.insertDocument(archivo);

            
        }
        
        if (idArchivoInsertado!=null){
            documentos_servicio documentos2=new documentos_servicio();
            documentos2.insertaRequisito(
                                            utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersonaEditarIncidencias") , 
                                            idArchivoInsertado, 
                                            "32",
                                            indice
                                        );
        }   

  
        documento = new documentos_servicio();
        
        
        documento.insertaInformacion(
                                        utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersonaEditarIncidencias") ,
                                        "30" ,
                                        "4", //Fecha Tipo de dato        
                                        utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "fechaIncapacidad") ,
                                        indice
                                    );
        
        documento.insertaInformacion(
                                        utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersonaEditarIncidencias") ,
                                        "31" ,
                                        "1", //Texto Tipo de dato        
                                        utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "motivoIncapacidad") ,
                                        indice
                                    );
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+utilidadesWeb.utilidadWeb.valorDeVariablaDePeticionMultipart(peticion, "idPersonaEditarIncidencias")+"");
        
      

        
    }
    
    public void agregaIncidencia2() {
        
        
        documentos_servicio documento=new documentos_servicio();
        
        String indice=documento.consultaIndiceDeRequerimiento(
                                        request.getParameter("idPersonaEditarIncidencias2"),
                                        request.getParameter("idVariableAlmacenamientoIncidencias2")
                                    );
        
        if (indice == null){ //Se busca en los requisitos si el valor tiene indice
            indice="1";
        }else{
            indice=(Integer.parseInt(indice)+1)+"";
        }
       
        documento = new documentos_servicio();
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarIncidencias2") ,
                                        "37",
                                        "4", //Fecha Tipo de dato        
                                        request.getParameter("fechaIncidencia"),
                                        indice
                                    );
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarIncidencias2") ,
                                        "38",
                                        "1", //Fecha Tipo de dato        
                                        request.getParameter("motivoIncidencia"),
                                        indice
                                    );
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarIncidencias2") ,
                                        "39",
                                        "1", //Fecha Tipo de dato        
                                        request.getParameter("descripcionIncidencia"),
                                        indice
                                    );
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+request.getParameter("idPersonaEditarIncidencias2")+"");
        
      
       
    }
    
    
    public void agregaEquipoSeguridad() {
        
   
        documentos_servicio documento=new documentos_servicio();
        
        String indice=documento.consultaIndiceDeRequerimiento(
                                        request.getParameter("idPersonaEditarEquipoSeguridad"),
                                        request.getParameter("idVariableAlmacenamientoEquipoSeguridad")
                                    );
        
        if (indice == null){ //Se busca en los requisitos si el valor tiene indice
            indice="1";
        }else{
            indice=(Integer.parseInt(indice)+1)+"";
        }
       
        
       
        documento = new documentos_servicio();
        
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarEquipoSeguridad") ,
                                        "35",
                                        "4", //Fecha Tipo de dato        
                                        request.getParameter("fechaEntrega"),
                                        indice
                                    );
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarEquipoSeguridad") ,
                                        "36",
                                        "1", //Texto Tipo de dato        
                                        request.getParameter("equipoEntregado"),
                                        indice
                                    );
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+request.getParameter("idPersonaEditarEquipoSeguridad")+"");
        
      
       
    }
    
    
     public void agregaVacaciones() {
        
   
        documentos_servicio documento=new documentos_servicio();
        
        String indice=documento.consultaIndiceDeRequerimiento(
                                        request.getParameter("idPersonaEditarVacaciones"),
                                        request.getParameter("idVariableAlmacenamientoVacaciones")
                                    );
        
        if (indice == null){ //Se busca en los requisitos si el valor tiene indice
            indice="1";
        }else{
            indice=(Integer.parseInt(indice)+1)+"";
        }
       
        
       
        documento = new documentos_servicio();
        
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarVacaciones") ,
                                        "40",
                                        "4", //Fecha Tipo de dato        
                                        request.getParameter("fechaInicioVacaciones"),
                                        indice
                                    );
        
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarVacaciones") ,
                                        "41",
                                        "4", //Fecha Tipo de dato        
                                        request.getParameter("fechaFinVacaciones"),
                                        indice
                                    );
        
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarVacaciones") ,
                                        "42",
                                        "1", //Texto Tipo de dato        
                                        request.getParameter("descripcionVacaciones"),
                                        indice
                                    );
        
        documento.insertaInformacion(
                                        request.getParameter("idPersonaEditarVacaciones") ,
                                        "43",
                                        "1", //Texto Tipo de dato        
                                        "Sin Aprobar",
                                        indice
                                    );
        
        
        utilidadesWeb.utilidadWeb.htmlAbrirUbicacion(Servlet, request, response, "/Servlet?controlador=empleadosPerfil&empleadoId="+request.getParameter("idPersonaEditarVacaciones")+"");
        
      
       
    }
    

}
