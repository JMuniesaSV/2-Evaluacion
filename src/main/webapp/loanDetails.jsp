<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>
<main class="container mt-5">
    <h1 class="text-center mb-3">Detalles del Préstamo</h1>

    <div class="form-group">
        <label for="movieTitle">Título de la Película:</label>
        <input type="text" id="movieTitle" name="movieTitle" class="form-control" value="${loan.movieTitle}" readonly>
    </div>
    <div class="form-group">
        <label for="startDate">Fecha Inicial de Préstamo:</label>
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
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editLoanModal">Editar</button>
            <button type="submit" class="btn btn-danger" name="action" value="delete" onclick="return confirm('¿Estás seguro que quieres eliminar este préstamo?');">Eliminar</button>
        </form>
        <a href="listLoans" class="btn btn-secondary">Volver</a>
    </div>
</main>

<!-- Edit Loan Modal -->
<div class="modal fade" id="editLoanModal" tabindex="-1" aria-labelledby="editLoanModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/loanDetails" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="editLoanModalLabel">Editar Préstamo</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="action" value="edit" />
                    <input type="hidden" name="idLoan" value="${loan.idLoan}" />
                    <div class="mb-3">
                        <label for="newStartDate" class="form-label">Nueva Fecha de Inicio</label>
                        <input type="date" class="form-control" id="newStartDate" name="newStartDate" value="${loan.startDate}" required>
                    </div>
                    <div class="mb-3">
                        <label for="newExpectedDate" class="form-label">Nueva Fecha Esperada de Devolución</label>
                        <input type="date" class="form-control" id="newExpectedDate" name="newExpectedDate" value="${loan.expectedDate}" required>
                    </div>
                    <div class="mb-3">
                        <label for="newReturnDate" class="form-label">Nueva Fecha de Devolución</label>
                        <input type="date" class="form-control" id="newReturnDate" name="newReturnDate" value="${loan.returnDate}">
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
</body>
</html>
