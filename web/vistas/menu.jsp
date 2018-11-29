<%@page import="serviciosBD.peticiones_web_servicio"%>
<div class="en ble">
    <nav class="bll">
        
        <% String host=application.getInitParameter("host");  %>
        
        <div class="blf">
            <button class="bkb bkd blg" type="button" data-toggle="collapse" data-target="#nav-toggleable-md">
                <span class="yz">Toggle nav</span>
            </button>
            <img src="<% out.println(host); %>imagenes/GLOBO.png"  width="50" height="50">
            
            <a  href="https://www.soxtec.com.mx">Soxtec S.A. de C.V.</a>
        </div>
          
        
        
        
        <div class="collapse bki" id="nav-toggleable-md">
            
            
            <form id="buscarParametro" action="" method = "post"  >
                <input class="form-control" type="text" id="buscar" name="buscar"  placeholder="Search..."   >
            </form>
           
            
            
            
            <ul class="nav lq nav-stacked st">
                
                
                <li class="asv">Menú</li>
             
                
                <%  serviciosBD.peticiones_web_servicio vista=new peticiones_web_servicio();
                    vista.setIdTipoVista(peticiones_web_servicio.menuPrincipal);
                    vista.setIdUsuario((String)session.getAttribute("idUsuario"));
                    vista.setIdTipoVista(peticiones_web_servicio.menuPrincipal);
                    
                    String menu[][]=vista.getVistasPoridTipoVista();
                  

                    for (int i=0;i<menu.length;i++){ %>
                    <li class="lp">
                        <a class="ln " href="<% out.println(host); %>Servlet?controlador=<%   out.println( menu[i][1]  );  %>"><%   out.println( menu[i][5]  );  %></a>
                    </li>
                    <%
                    }
                 
                %>
                
            <hr class="bmi aah">
            </ul>
            
        </div>
        
        
        
    </nav>
</div>