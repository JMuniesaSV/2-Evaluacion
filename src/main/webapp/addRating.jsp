<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Añadir Calificación</h1>

    <form action="addRating" method="post">
        <div class="mb-3">
            <label for="idMovie" class="form-label">Película</label>
            <select class="form-select" id="idMovie" name="idMovie" required>
                <!-- Aquí asumimos que has pasado una lista de películas a la JSP -->
                <c:forEach var="movie" items="${movies}">
                    <option value="${movie.idMovie}">${movie.title}</option>
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <label for="rating" class="form-label">Calificación</label>
            <select class="form-select" id="rating" name="rating" required>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
            </select>
        </div>
        <div class="mb-3">
            <label for="review" class="form-label">Reseña</label>
            <textarea class="form-control" id="review" name="review" rows="3" required></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Añadir Calificación</button>
    </form>
</div>

</body>
</html>
