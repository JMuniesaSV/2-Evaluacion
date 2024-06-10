<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Lista de Películas</h1>

    <form method="get" action="${pageContext.request.contextPath}/listMovies">
        <div class="input-group mb-3">
            <input type="text" class="form-control" name="searchTerm" placeholder="Buscar...">
            <div class="input-group-append">
                <button class="btn btn-outline-secondary" type="submit">Buscar</button>
            </div>
        </div>
    </form>

    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/addMovie" class="btn btn-primary">Añadir Película</a>
    </div>

    <table id="moviesTable" class="table" data-pagination="false" data-sortable="true">
        <thead class="table-dark">
        <tr>
            <th data-field="title" data-align="center" data-halign="center" data-sortable="true">Título</th>
            <th data-field="director" data-align="center" data-halign="center" data-sortable="true">Director</th>
            <th data-field="synopsis" data-align="center" data-halign="center" data-sortable="false">Sinopsis</th>
            <th data-field="trailer" data-align="center" data-halign="center" data-sortable="false">Tráiler</th>
            <th data-field="image" data-align="center" data-halign="center" data-sortable="false">Imagen</th>
        </tr>
        </thead>
        <tbody id="moviesTableBody">
        <c:forEach var="movie" items="${movies}">
            <tr>
                <td data-field="title"><a href="${pageContext.request.contextPath}/movieDetails?idMovie=${movie.idMovie}">${movie.title}</a></td>
                <td data-field="director">${movie.director}</td>
                <td data-field="synopsis">${movie.synopsis}</td>
                <td data-field="trailer"><a class="no-link" href="${movie.trailer}"><i class="bi bi-camera-reels"></i></a></td>
                <td data-field="image"><img class="fixed-table-image-size" src="static/images/movies/${movie.path}"></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>