<jsp:include page="cabecera.jsp" flush="true"/>

<div class="bw">
    <div class="dh">

        <jsp:include page="menu.jsp" flush="true"/>
       
        <div class="et bmj">
            
            <jsp:include page="menuSuperior.jsp" flush="true"/>
            
           

            <div class="bkz aav aaj">
                <h3 class="bla blb">Inicio</h3>
                <h3 class="bla blb">
                   <a  href="#docsModal" data-toggle="modal" id="<%  //out.print(documentos[i][1]);  %>" onclick="editaArchivo(event, <% // out.print(id);  %> , <%  //out.print(documentos[i][0]);  %> , <%  // out.print(documentos[i][6]);  %>,   '<% // out.print(documentos[i][2]);  %>'   ,   '<%  //out.print(documentos[i][3]);  %>'  ,  '<% // out.print(documentos[i][4]);  %>'  )"  >.</a>
                </h3>
            </div>

            <div class="dh bmk">
               
               
            </div>

            <hr class="aav">

            
        </div>
    </div>
</div>

            
            
            
            

<div id="docsModal" class="cb fade" tabindex="-1" role="dialog" aria-labelledby="bmp">
    <div class="modal-dialog">
        <div class="modal-content">

            <div class="ol">
                <h4 class="modal-title" id="myModalLabel">Espere...</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <div class="tab-content">
                    <div class="row">
                        <div class="col-md-12 text-center">
                            <section>
                                <div id="example1" class="example"></div>
                            </section>
                        </div>
                    </div>
                </div>
            </div>
            <div class="om">
                <button type="button" class="ce kh" data-dismiss="modal">Cool, got it!</button>
            </div>
        </div>
    </div>
</div>
                        
            
            
            
            
            
            
            






<jsp:include page="pieDePagina.jsp" flush="true"/>