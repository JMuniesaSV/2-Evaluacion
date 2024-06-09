<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Detalle de Calificación</h1>
    <div class="card">
        <div class="card-header">
            Calificación ID: ${rating.idRating}
        </div>
        <div class="card-body">
            <h5 class="card-title">Rating: ${rating.rating}</h5>
            <p class="card-text">Review: ${rating.review}</p>
            <a href="${pageContext.request.contextPath}/listRatings.jsp" class="btn btn-primary">Volver a la lista</a>
            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editRatingModal">Modificar Calificación</button>
            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteRatingModal">Eliminar Calificación</button>
            <!-- Edit Rating Modal -->
            <div class="modal fade" id="editRatingModal" tabindex="-1" aria-labelledby="editRatingModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/ratingDetails" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editRatingModalLabel">Modificar Calificación</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="action" value="edit" />
                                <input type="hidden" name="idRating" value="${rating.idRating}" />
                                <div class="mb-3">
                                    <label for="newRating" class="form-label">Nuevo Rating</label>
                                    <input type="number" class="form-control" id="newRating" name="newRating" value="${rating.rating}" min="1" max="5" required>
                                </div>
                                <div class="mb-3">
                                    <label for="newReview" class="form-label">Nueva Review</label>
                                    <textarea class="form-control" id="newReview" name="newReview" rows="3">${rating.review}</textarea>
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
            <!-- Delete Rating Modal -->
            <div class="modal fade" id="deleteRatingModal" tabindex="-1" aria-labelledby="deleteRatingModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="${pageContext.request.contextPath}/ratingDetails" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="deleteRatingModalLabel">Confirmar Eliminación</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <p>¿Estás seguro de que deseas eliminar esta calificación?</p>
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="idRating" value="${rating.idRating}" />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-danger">Eliminar</button>
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
