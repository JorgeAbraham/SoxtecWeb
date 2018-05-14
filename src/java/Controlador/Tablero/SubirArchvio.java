/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Tablero;

import java.io.File;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Abraham
 */
public class SubirArchvio {
    
    
    
    
    public void out(){
        
        
        
    }
    
    public void Subir(HttpServletRequest request) {
        
         /*FileItemFactory es una interfaz para crear FileItem*/
        FileItemFactory file_factory = new DiskFileItemFactory();
 
        /*ServletFileUpload esta clase convierte los input file a FileItem*/
        ServletFileUpload servlet_up = new ServletFileUpload(file_factory);
        /*sacando los FileItem del ServletFileUpload en una lista */
        List items;
        try {
            items = servlet_up.parseRequest((RequestContext) request);
            for(int i=0;i<items.size();i++){
                /*FileItem representa un archivo en memoria que puede ser pasado al disco duro*/
                FileItem item = (FileItem) items.get(i);
                /*item.isFormField() false=input file; true=text field*/
                if (! item.isFormField()){
                    /*cual sera la ruta al archivo en el servidor*/
                    File archivo_server = new File("/subidos/"+item.getName());
                    try {
                        /*y lo escribimos en el servido*/
                        item.write(archivo_server);
                    } catch (Exception ex) {
                        Logger.getLogger(SubirArchvio.class.getName()).log(Level.SEVERE, null, ex);
                    }

                }
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(SubirArchvio.class.getName()).log(Level.SEVERE, null, ex);
        }
 
       
        
        
    }
    
    
    
}
