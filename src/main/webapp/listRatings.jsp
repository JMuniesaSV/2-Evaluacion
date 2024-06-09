<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Lista de Ratings</h1>

    <!-- Barra de búsqueda -->
    <form action="listRatings" method="get" class="mb-3">
        <div class="input-group">
            <input type="text" class="form-control" name="searchTerm" placeholder="Buscar...">
            <button class="btn btn-outline-secondary" type="submit">Buscar</button>
        </div>
    </form>

    <a href="${pageContext.request.contextPath}/addRating" class="btn btn-primary">Añadir Calificación</a>

    <table id="ratingsTable" class="" data-toggle="table" data-pagination="false" data-sortable="true">
        <thead class="table-dark">
        <tr>
            <th data-align="center" data-halign="center" data-sortable="true">Rating</th>
            <th data-align="center" data-halign="center" data-sortable="false">Review</th>
            <th data-align="center" data-halign="center" data-sortable="false">Acciones</th>
        </tr>
        </thead>
        <tbody id="ratingsTableBody">
        <c:forEach var="rating" items="${ratings}">
            <tr>
                <td>${rating.rating}</td>
                <td>${rating.review}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/ratingDetails?idRating=${rating.idRating}" class="btn btn-info">Ver Detalles</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
