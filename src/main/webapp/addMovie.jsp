<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>

<div class="container">
    <h1 class="mt-5">Añadir Película</h1>

    <form action="addMovie" method="post">
        <div class="mb-3">
            <label for="title" class="form-label">Título</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        <div class="mb-3">
            <label for="director" class="form-label">Director</label>
            <input type="text" class="form-control" id="director" name="director" required>
        </div>
        <div class="mb-3">
            <label for="synopsis" class="form-label">Sinopsis</label>
            <textarea class="form-control" id="synopsis" name="synopsis" rows="3" required></textarea>
        </div>
        <div class="mb-3">
            <label for="trailer" class="form-label">Trailer</label>
            <input type="text" class="form-control" id="trailer" name="trailer" required>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Cantidad</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required>
        </div>
        <div class="mb-3">
            <label for="path" class="form-label">Ruta</label>
            <input type="text" class="form-control" id="path" name="path" required>
        </div>
        <button type="submit" class="btn btn-primary">Añadir Película</button>
    </form>
</div>

</body>
</html>
