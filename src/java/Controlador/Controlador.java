/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Abraham
 */
public class Controlador {
    
    protected HttpServlet Servlet;
    protected String Base;
    protected HttpServletRequest request;
    protected HttpServletResponse response;
    
    
    public void Control(HttpServlet Servlet,HttpServletRequest request,HttpServletResponse response,String Base){
        this.Servlet=Servlet;
        this.request=request;
        this.response=response;
        this.Base=Base;
    }
    
}
