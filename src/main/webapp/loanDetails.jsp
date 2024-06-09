<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>
<main class="container mt-5">
    <h1 class="text-center mb-3">Detalles del Alquiler</h1>

    <div class="form-group">
        <label for="movieTitle">Título de la Película:</label>
        <input type="text" id="movieTitle" name="movieTitle" class="form-control" value="${loan.movieTitle}" readonly>
    </div>
    <div class="form-group">
        <label for="startDate">Fecha Inicial de Reserva:</label>
        <input type="text" id="startDate" name="startDate" class="form-control" value="<fmt:formatDate value='${loan.startDate}' pattern='dd/MM/yyyy'/>" readonly>
    </div>
    <div class="form-group">
        <label for="expectedDate">Fecha de Devolución Esperada:</label>
        <input type="text" id="expectedDate" name="expectedDate" class="form-control" value="<fmt:formatDate value='${loan.expectedDate}' pattern='dd/MM/yyyy'/>" readonly>
    </div>
    <div class="form-group">
        <label for="returnDate">Fecha de Devolución:</label>
        <input type="text" id="returnDate" name="returnDate" class="form-control" value="<c:choose><c:when test='${loan.returnDate != null}'><fmt:formatDate value='${loan.returnDate}' pattern='dd/MM/yyyy'/></c:when><c:otherwise>—</c:otherwise></c:choose>" readonly>
    </div>
    <div class="mt-3">
        <form action="loanDetails" method="post">
            <input type="hidden" name="idLoan" value="${loan.idLoan}">
            <button type="button" class="btn btn-primary" onclick="location.href='editLoan?idLoan=${loan.idLoan}'">Editar</button>
            <button type="submit" class="btn btn-danger" name="action" value="delete" onclick="return confirm('Seguro que quieres eliminar este préstamo?');">Eliminar</button>
        </form>
        <a href="listLoans" class="btn btn-secondary">Volver</a>
    </div>
</main>
</body>
</html>
