<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Detalle de Película</h1>
    <div class="card">
        <div class="card-header">
            Detalle de la película
        </div>
        <div class="card-body">
            <h5 class="card-title">${movie.title}</h5>
            <p class="card-text"><strong>Director:</strong> ${movie.director}</p>
            <p class="card-text"><strong>Sinopsis:</strong> ${movie.synopsis}</p>
            <p class="card-text"><strong>Tráiler:</strong> <a href="${movie.trailer}" target="_blank">Ver Tráiler</a></p>
            <p class="card-text"><strong>Cantidad:</strong> ${movie.quantity}</p>
            <p>
                <c:choose>
                <c:when test="${movie.rentedByUser}">
            <form action="${pageContext.request.contextPath}/loanMovie" method="post">
                <input type="hidden" name="idMovie" value="${movie.idMovie}">
                <input type="hidden" name="action" value="return">
                <button type="submit" class="btn btn-warning">Devolver</button>
            </form>
            </c:when>
            <c:otherwise>
                <form action="${pageContext.request.contextPath}/loanMovie" method="post">
                    <input type="hidden" name="idMovie" value="${movie.idMovie}">
                    <input type="hidden" name="action" value="rent">
                    <button type="submit" class="btn btn-primary">Alquilar</button>
                </form>
            </c:otherwise>
            </c:choose>
            </p>

            <a href="${pageContext.request.contextPath}/listMovies.jsp" class="btn btn-primary">Volver a la lista</a>
            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editMovieModal">Modificar Película</button>

            <form action="${pageContext.request.contextPath}/movieDetails" method="post" style="display: inline;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="idMovie" value="${movie.idMovie}" />
                <button type="submit" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que deseas eliminar esta película?')">Eliminar Película</button>
            </form>

            <!-- Edit Movie Modal -->
            <div class="modal fade" id="editMovieModal" tabindex="-1" aria-labelledby="editMovieModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/movieDetails" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editMovieModalLabel">Modificar Película</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="idMovie" value="${movie.idMovie}" />
                                <div class="mb-3">
                                    <label for="newTitle" class="form-label">Nuevo Título</label>
                                    <input type="text" class="form-control" id="newTitle" name="newTitle" value="${movie.title}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newDirector" class="form-label">Nuevo Director</label>
                                    <input type="text" class="form-control" id="newDirector" name="newDirector" value="${movie.director}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newSynopsis" class="form-label">Nueva Sinopsis</label>
                                    <textarea class="form-control" id="newSynopsis" name="newSynopsis" rows="3" required>${movie.synopsis}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="newTrailer" class="form-label">Nuevo Tráiler</label>
                                    <input type="url" class="form-control" id="newTrailer" name="newTrailer" value="${movie.trailer}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newQuantity" class="form-label">Nueva Cantidad</label>
                                    <input type="number" class="form-control" id="newQuantity" name="newQuantity" value="${movie.quantity}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newPath" class="form-label">Nueva Ruta de Imagen</label>
                                    <input type="text" class="form-control" id="newPath" name="newPath" value="${movie.path}" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
