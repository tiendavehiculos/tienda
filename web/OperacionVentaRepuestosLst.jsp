<%-- 
    Document   : OperacionVentaRepuestos
    Created on : 17/10/2016, 05:14:12 AM
    Author     : Los Irresistibles
--%>

<%@page import="Modelo.ComprobanteVenta"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="WEB-INF/jspf/validacion.jspf" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <%@include file="WEB-INF/jspf/head.jspf" %>
        <title>Operación Venta Repuestos</title>
        <script type="text/javascript">
            function nuevo(){
                document.location = "OperacionVentaRepuestosMnt.jsp";
            }
            
            function buscar(pagina){
                var nom = document.getElementById("txtNombres").value;
                document.frmLst.action = "DetalleVentaControlador?accion=buscar&nom=" + nom + "&pag=" + pagina;
                document.frmLst.submit();
            }
            
            function buscarPag(pagina){
                var nom = document.getElementById("nombres").value;
                document.frmLst.action = "DetalleVentaControlador?accion=buscar&nom=" + nom + "&pag=" + pagina;
                document.frmLst.submit();
            }
            
            function obtenerPorId(id){
                document.frmLst.action = "DetalleVentaControlador?accion=obtenerPorId&id=" + id;
                document.frmLst.submit();
            }
            
            function eliminar(id){
                document.frmLst.action = "DetalleVentaControlador?accion=eliminar&id=" + id;
                document.frmLst.submit();
            }
        </script>
    </head>
    
    <body>
        <%@include file="WEB-INF/jspf/header.jspf" %>
        <main>
            <section class="jumbotron">
                <div class="container">
                    <h2><strong>Venta Repuestos</strong></h2>
                </div>
            </section>
            <section class="container">
                <form name="frmLst" method="post" class="form-inline formulario-resultados">
                    <div class="form-group">
                        <label for="txtDescripcion">Nombre de Cliente:</label>
                        <input class="form-control" type="text" id="txtNombres" placeholder="Texto a buscar" autofocus />
                        <div class="espacio-buscar"></div>
                        <input type="submit" onclick="buscar(1)" id="btnBuscar" class="btn btn-primary" value="Buscar" />
                        <button type="button" onclick="nuevo()" id="btnNuevo" class="btn btn-primary">Nuevo</button>
                    </div>

                    <div class="mensajes">
                        <% if(session.getAttribute("msgListado") != null){ %>
                            
                            ${msgListado}
                        <% } %>

                        <% if(session.getAttribute("msgPostOperacion") != null){ %>
                        ${msgPostOperacion}
                        <% } %>
                    </div>
                    <div class="table-responsive"> <!-- Activar para tabla responsiva -->
                        <table border="1" class="table table-hover tabla-resultados">
                            <thead align="center">
                                <td><b>#</b></td>
                                <td><b>Cliente</b></td>
                                <td><b>Fecha</b></td>
                                <td><b>Estado</b></td>
                                <td><b>Importe</b></td>
                                <td><b>Acciones</b></td>
                            </thead>
                            <%if(session.getAttribute("listaComprobanteVenta") != null){
                                List<ComprobanteVenta> lstcomprobante = (List<ComprobanteVenta>)session.getAttribute("listaComprobanteVenta");
                                for(int i=0; i < lstcomprobante.size(); i++){
                                    ComprobanteVenta comprobante = lstcomprobante.get(i);
                            %>
                            <tbody>
                                <td><center><%=(((int)session.getAttribute("pagina")*(int)session.getAttribute("registrosPorPagina"))-(int)session.getAttribute("registrosPorPagina"))+i+1 %></center></td>
                                <td><%=comprobante.getCliente() %></td>
                                <td><%=comprobante.getFecha() %></td>
                                
                                <% if(comprobante.getEstado() == true){ %>
                                    <td><center><span class="label label-success">Activo</span></center></td>
                                <% }else{ %>
                                    <td><center><span class="label label-Warning">Anulado</span></center></td>
                                <% } %>
                                
                                
                                <td><%=comprobante.getImporte() %></td>
                                <td>
                                    <center>
                                    <table>
                                        <tr>
                                            <td class="td-acciones-editar">
                                                <button class="btn btn-primary" onclick="">
                                                    <span class="glyphicon glyphicon-copy"></span>
                                                </button>
                                            </td>
                                            <td class="td-acciones-eliminar">
                                                <a class="text-danger" href="#modalEliminar<%=i+1%>" data-toggle="modal">
                                                    <button class="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></button>
                                                </a>
                                            </td>
                                        </tr>
                                    </table>
                                    </center>
                                </td>
                                
                                <!-- Modal - INICIO -->
                                <div class="modal fade text-center" id="modalEliminar<%=i+1%>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h3 class="modal-title" id="myModalLabel">Cambiar estado de Comprobante de Venta</h3>
                                            </div>
                                            <div class="modal-body">
                                                <p>Está seguro de Cambiar el estado del Comprobante de Venta:</p>
                                                <p><strong><%= "Nro. " + comprobante.getIdComprobanteVenta() + " del Cliente " + comprobante.getCliente() %></strong>.</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-dismiss="modal">Cancelar</button>
                                                <button onclick="eliminar(<%=comprobante.getIdComprobanteVenta() %>)" type="button" class="btn btn-danger">Eliminar</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- Modal - FIN -->
                            </tbody>
                            <%  
                                }
                            }
                            %>
                        </table>
                        
                        <input type="hidden" value="<%=session.getAttribute("nombres")%>" id="nombres" />
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <% if((int)session.getAttribute("pagina") == 1){ %>
                                <li class="disabled"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                            <% }else{ %>
                                <li><a href="#" onclick="buscarPag(<%=(int)session.getAttribute("pagina")-1%>)" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
                            <% } %>
                            <%
                            for(int i=1; i <= (int)session.getAttribute("nroPaginas"); i++){
                            
                                if((int)session.getAttribute("pagina") == i){       
                            %>
                                <li class="active"><a href="#"><%=i%></a></li>
                            <%      
                                }else{
                            %>
                                <li><a href="#" onclick="buscarPag(<%=i%>)"><%=i%></a></li>
                            <%
                                }
                            }
                            %>
                            <% if((int)session.getAttribute("pagina") == (int)session.getAttribute("nroPaginas")){ %>
                                <li class="disabled"><a href="#" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                            <% }else{ %>
                                <li><a href="#" onclick="buscarPag(<%=(int)session.getAttribute("pagina")+1%>)" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li>
                            <% } %>
                        </ul>
                    </nav>
                </form>
            </section>
        </main>
        <%@include file="WEB-INF/jspf/footer.jspf" %>
    </body>
</html>