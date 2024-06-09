<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<body>
<%@ include file="/includes/headerBar.jsp" %>
<main class="container mt-5">
    <h1 class="text-center mb-3">Alquileres activos</h1>

    <!-- Barra de búsqueda -->
    <form action="listLoans" method="get" class="mb-3">
        <div class="input-group">
            <input type="text" class="form-control" name="searchTerm" placeholder="Buscar por título o fecha">
            <button class="btn btn-primary" type="submit">Buscar</button>
        </div>
    </form>

    <table class="" data-toggle="table" data-pagination="true" data-sortable="true">
        <thead class="table-dark">
        <tr>
            <th data-align="center" data-halign="center" data-sortable="true">Titulo</th>
            <th data-align="center" data-halign="center" data-sortable="true">Fecha inical de reserva</th>
            <th data-align="center" data-halign="center" data-sortable="true">Fecha de devolucion esperada</th>
            <th data-align="center" data-halign="center" data-sortable="true">Fecha de devolucion</th>
            <th data-align="center" data-halign="center" data-sortable="false">Estado</th>
            <th data-align="center" data-halign="center" data-sortable="false">Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${loans}" var="loan">
            <tr>
                <td>${loan.movieTitle}</td>
                <td><fmt:formatDate value="${loan.startDate}" pattern="dd/MM/yyyy"/></td>
                <td><fmt:formatDate value="${loan.expectedDate}" pattern="dd/MM/yyyy"/></td>

                <c:if test="${loan.returnDate == null}">
                    <td>—</td>
                    <td>
                        <form method="POST" action="loanMovie">
                            <input type="hidden" name="idLoan" value="${loan.idLoan}"/>
                            <input type="hidden" name="action" value="return">
                            <button type="submit" class="btn btn-primary btn-sm" onclick="return confirm('Seguro que quieres devolver la película?');">Devolver</button>
                        </form>
                    </td>
                </c:if>
                <c:if test="${loan.returnDate != null}">
                    <td><fmt:formatDate value="${loan.returnDate}" pattern="dd/MM/yyyy"/></td>
                    <td><span class="badge bg-success">Película devuelta</span></td>
                </c:if>
                <td><a href="loanDetails?idLoan=${loan.idLoan}" class="btn btn-info btn-sm">Detalles</a></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>
</body>
</html>
