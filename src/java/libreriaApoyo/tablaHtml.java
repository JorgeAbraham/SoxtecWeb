/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package libreriaApoyo;

import java.util.ArrayList;
import serviciosBD.operaciones_servicio;

/**
 *
 * @author usuario
 */
public class tablaHtml {
    
    
    String fragmentoTabla1="<table class=\"table\" class=\"col-md-12\" >"+
                                "<thead>"+
                            "<tr>";
    String fragmentoTabla2="</tr>"+
                                "</thead>"+
                                    "<tbody>";

  
    String fragmentoTabla3=
                                    "</tbody>"+
                                "</table>";

    
    ArrayList<String> cabecera=new ArrayList();
    
    ArrayList<String> filaNumero=new ArrayList();
    
    
    ArrayList<ArrayList> contenido=new ArrayList();

    public tablaHtml() {
        
        
    }
    
    
    
    
    public void agregaRegistro(String idConcepto, String nombreCabecera,String fila, String idTipoVariable, String ContenidoTexto, String ContenidoNumerico, String contenidoFecha , String idArchivo ){
        
        addCabecera(nombreCabecera);
        
        
        String valor="";
        
        //valores=valores+"<span class=\"col-md-6\">"+ContenidoTexto+"</span>";
        
        if (idTipoVariable.equals(operaciones_servicio.tipoTexto)){
            valor=ContenidoTexto;
        }
        if (idTipoVariable.equals(operaciones_servicio.tipoArchivo)){
            valor=idArchivo;
        }
        if (idTipoVariable.equals(operaciones_servicio.tipoNumero)){
            valor=ContenidoNumerico;
        }
        if (idTipoVariable.equals(operaciones_servicio.tipoFecha)){
            valor=contenidoFecha;
        }
        if (idTipoVariable.equals(operaciones_servicio.tipoTextoLargo)){
            valor=ContenidoTexto;
        }
        
        
        
        
        agregaValor(fila,idConcepto,valor);
        
        
       
        
    }
    
    
    public void agregaValor(String fila,String idConcepto,String valor){
        
        int indiceEncontrado=0;
        boolean filaEncontrada=false;
          
        for (int i=0;i<filaNumero.size();i++){
            if (filaNumero.get(i).equals(fila)){
                filaEncontrada=true;
                indiceEncontrado=i;
            }
        }
        
        if (!filaEncontrada){  //No se encontro la fila
            
            ArrayList<String> nuevaFila=new ArrayList();
            nuevaFila.add(valor);
            contenido.add(nuevaFila);
            filaNumero.add(fila);
            
        }
        else{  //Si se encontro la fila
            
            ArrayList<String> filaExistente=contenido.get(indiceEncontrado);
            filaExistente.add(valor);
            contenido.set(indiceEncontrado, filaExistente);
            
        }
        
    }
    
    
    public String printHTMLtabla(){
        
        
        String tabla="";
        
        
        String cabeceras="";
        
        for (int i=0;i<cabecera.size();i++){
            
            cabeceras=cabeceras+"<th>"+cabecera.get(i)+"</th>"; 
            
        }
        
        
        String filasConContenido="";
        
        
        for (int i=0;i<contenido.size();i++){
            
            
            filasConContenido=filasConContenido+"<tr>";
            ArrayList aux=contenido.get(i);
            
            for (int j=0;j<aux.size();j++){
                filasConContenido=filasConContenido+("<td>"+aux.get(j)+"</td>");
            }
             filasConContenido=filasConContenido+"</tr>";
        }
        
        tabla=fragmentoTabla1+cabeceras+fragmentoTabla2+filasConContenido+fragmentoTabla3;
        
        return tabla;
        
    }
    
    
    public void addCabecera(String nombreCabecera){
        
        boolean cabeceraEncontrada=false;
        
        for (int i=0;i<cabecera.size();i++){
            if (cabecera.get(i).equals(nombreCabecera)){
                cabeceraEncontrada=true;
            }
        }
        
        if (!cabeceraEncontrada){
            cabecera.add(nombreCabecera);
        }
    }
    
    
    
    
    public static void main(String args[]){
        
        
        
        tablaHtml T=new tablaHtml();
        T.agregaRegistro("6","A","1","3",null,"1",null,null);
        T.agregaRegistro("6","A","2","3",null,"3",null,null);
        T.agregaRegistro("6","A","3","3",null,"2",null,null);
        T.agregaRegistro("7","B","1","1","Rubia",null,null,null);
        T.agregaRegistro("7","B","2","1","Pelirroja",null,null,null);
        T.agregaRegistro("7","B","3","1","Morena",null,null,null);
        T.agregaRegistro("8","C","1","3",null,"1000",null,null);
        T.agregaRegistro("8","C","2","3",null,"2000",null,null);
        T.agregaRegistro("8","C","3","3",null,"3000",null,null);
                    
        
        System.out.print(T.printHTMLtabla());
        
        
        
       
    }
    
    
    
    
}
