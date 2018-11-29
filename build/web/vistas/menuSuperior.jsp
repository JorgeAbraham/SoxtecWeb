<%@page import="serviciosBD.persona_servicio"%>
<%@page import="java.util.Date"%>


<div class="bls">
    
    
    
    
 

    <div class="row">
         <h2 class="col-5">Express Solution's Technology</h2>
        
  
        <div class="col-5">
            <span> <i class="fa fa-user" ></i>  
                <% 
                    String idUser=(String)session.getAttribute("idUsuario");  
                    persona_servicio usuario = new persona_servicio( Integer.parseInt(idUser) );
                    out.print(usuario.getNombre() + " " + usuario.getApellidoPaterno() +" "+ usuario.getApellidoMaterno());

                %>  
            </span>
        </div>
        <div class="col-1">
            <a class="btn btn-secondary bla blb text-right" href="/SoxtecWeb/LogoutServlet?">Salir <i class="fa fa-sign-out" ></i></a>
        </div>

        <div class="col-6">
            <a class="btn btn-danger bla blb" href="javascript:window.history.back();"> Regresar <i class="fa fa-step-backward" ></i></a>

        </div>
        <div class="col-6">

            <a class="btn btn-block bla blb"  onclick="actualizarBotonCabecera()" >Actualizar <i class="fa fa-rotate-right" ></i></a>
        </div>
    </div>
        
       
</div>


