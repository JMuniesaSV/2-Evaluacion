<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/includes/commonStartDoc.jsp" %>

<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", async function(event) {
            event.preventDefault();
            const passwordField = document.getElementById('password');
            const password = passwordField.value;


            const encoder = new TextEncoder();
            const data = encoder.encode(password);


            const hashBuffer = await crypto.subtle.digest('SHA-1', data);


            const hashArray = Array.from(new Uint8Array(hashBuffer));
            const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');

            const formDataTmp = $(this).serialize();
            console.log(formDataTmp);
            const formData = formDataTmp.split("password=")[0] + "password=" + hashHex;
            console.log(formData);
            $.ajax("register", {
                type: "POST",
                data: formData,
                success: function(response) {
                    if (response === "success") {
                        window.location.href = "/Videoclub/login";
                    } else {
                        $("#result").html("<div class='alert alert-danger' role='alert'>" + response + "</div>");
                    }
                },
                error: function(xhr) {
                    if (xhr.status === 409) {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Correo ya en uso</div>");
                    } else {
                        $("#result").html("<div class='alert alert-danger' role='alert'>Algo salió mal</div>");
                    }
                }
            });
        });
    });
</script>

<body>
    <header class="mb-5 mt-3">
        <div class="text-center">
            <h1 class="display-1"><a href="login" class="no-link"><i class="bi bi-camera-reels-fill"></i>2ªEv Programación</a></h1>
        </div>
    </header>
    <main class="row">
        <div class="col-12 col-sm-9 col-md-6 m-auto">
            <div class="panel">
                <form action="register" method="post">
                    <div class="form-group mb-3">
                        <label for="firstName">Nombre</label>
                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="lastName">Apellidos</label>
                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="phoneNumber">Número de teléfono</label>
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber">
                    </div>
                    <div class="form-group mb-3">
                        <label for="password">Contraseña</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button id="signupButton" class="w-100 btn btn-lg btn-primary mb-3" type="submit">Sign Up</button>
                    
                    <div id="result"></div>
                </form>
            </div>
        </div>
    </main>
</body>
</html>