<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        $("#changePass").hide(); // Esconde el formulario inicialmente

        $("#toggleChangePass").click(function() {
            $("#changePass").toggle(); // Alterna la visibilidad del formulario
        });

        $("form").on("submit", async function(event) {
            event.preventDefault();
            const passwordFieldCurrent = document.getElementById('currentPassword');
            const passwordFieldNew = document.getElementById('newPassword');
            const passwordCurrent = passwordFieldCurrent.value;
            const passwordNew = passwordFieldNew.value;

            const encoder1 = new TextEncoder();
            const encoder2 = new TextEncoder();
            const data1 = encoder1.encode(passwordCurrent);
            const data2 = encoder2.encode(passwordNew);

            const hashBuffer1 = await crypto.subtle.digest('SHA-1', data1);
            const hashBuffer2 = await crypto.subtle.digest('SHA-1', data2);

            const hashArray1 = Array.from(new Uint8Array(hashBuffer1));
            const hashArray2 = Array.from(new Uint8Array(hashBuffer2));
            const hashHex1 = hashArray1.map(b => b.toString(16).padStart(2, '0')).join('');
            const hashHex2 = hashArray2.map(b => b.toString(16).padStart(2, '0')).join('');

            const formData = "&currentPassword=" + hashHex1 + "&newPassword=" + hashHex2;
            $.ajax("changePassword", {
                type: "POST",
                data: formData,
                success: function(response) {
                    $("#result").html("<div class='alert alert-success' role='alert'>" + "Contraseña cambiada" + "</div>");
                },
                error: function(xhr) {
                    $("#result").html("<div class='alert alert-danger' role='alert'>" + "Algo salio mal" + "</div>");
                }
            });
        });
    });
</script>

<body>
<%@ include file="/includes/headerBar.jsp" %>
<main class="container my-4">
    <h1 class="text-center mb-4">Tu perfil</h1>

    <div id="result"></div>

    <div class="form-group">
        <label for="firstName">NOmbre:</label>
        <input type="text" id="firstName" name="firstName" class="form-control" value="${user.firstName}" readonly disabled>
    </div>
    <div class="form-group">
        <label for="lastName">Apellidos:</label>
        <input type="text" id="lastName" name="lastName" class="form-control" value="${user.lastName}" readonly disabled>
    </div>
    <div class="form-group">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" class="form-control" value="${user.email}" readonly disabled>
    </div>
    <div class="form-group">
        <label for="phoneNumber">Número de teléfono:</label>
        <input type="text" id="phoneNumber" name="phoneNumber" class="form-control" value="${user.phoneNumber}" readonly disabled>
    </div>

    <button id="toggleChangePass" class="btn btn-primary mt-3">Cambiar contraseña</button>

    <form id="changePass" action="changePassword" method="POST" class="mt-3">
        <div class="form-group">
            <label for="currentPassword">Contraseña actual:</label>
            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
        </div>
        <div class="form-group">
            <label for="newPassword">Nueva Contraseña:</label>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
        </div>
        <button type="submit" class="btn btn-success">Cambiar Contraseña</button>
    </form>
</main>
</body>
</html>
