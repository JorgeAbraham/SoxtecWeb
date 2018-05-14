<%@page import="serviciosBD.peticiones_web_servicio"%>
<div class="en ble">
    <nav class="bll">
        
        <% String host=application.getInitParameter("host");  %>
        
        <div class="blf">
            <button class="bkb bkd blg" type="button" data-toggle="collapse" data-target="#nav-toggleable-md">
                <span class="yz">Toggle nav</span>
            </button>
            <img src="<% out.println(host); %>imagenes/GLOBO.png"  width="100" height="100">
            <!--a class="blh bmh" href="index.html">
                
                <span class="bv bch bli"></span>
            </a-->
        </div>

        
        
        
        <div class="collapse bki" id="nav-toggleable-md">
            
            
            <form class="blj">
                <input class="form-control" type="text" placeholder="Search...">
                <button type="submit" class="ku">
                    <span class="bv bdb"></span>
                </button>
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
            
            
        </div>
        
        
        
    </nav>
</div>