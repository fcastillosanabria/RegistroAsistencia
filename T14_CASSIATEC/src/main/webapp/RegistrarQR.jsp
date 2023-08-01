<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- codigo para poner logo en pestaña de navegador -->
<link rel="icon" type="image/png" sizes="100x100"
	href="img\Insignia SRC.png">

<title>Registrar QR</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<style>
html, body {
	height: 100%;
	overflow: hidden;
}

.nav-pills li a:hover {
	background-color: orange;
}

.nav-link.active {
	background-color: orange !important;
}

.modal-pink {
	background-color: pink;
}

/* .qrCanvas */
/* { */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	position: relative; */
/* 	overflow: hidden; */
/* 	display: flex; */
/* 	justify-content: center; */
/* 	align-items: center; */
/* } */
.video-container {
	width: 100%;
	height: 100%;
	position: relative;
	overflow: hidden;
	display: flex;
	justify-content: center;
	align-items: center;
}

#videoElement {
	width: 65%;
	/* 	height: 80%; */
	/* 	position: relative; */
	/* 	overflow: hidden; */
	/* 	display: flex; */
	/* 	justify-content: center; */
	/* 	align-items: center; */
}
</style>
<body>

<div id="alertWrapper" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 9999;">
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="successAlert" style="top: 9%; left: 50%; transform: translate(-50%, -50%);">
            <h1 class="alert-heading justify-content">Asistencia guardada</h1>
            <p><h3>Asistencia guardada exitosamente</h3></p>
            <h1><button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></h1>
        </div>
    </div>


	<div class="container-fluid">
		<div class="row flex-nowrap">
			<div
				class="bg-danger col-auto col-md-4 col-lg-2 min-vh-100 d-flex align-items-center">
				<div class="bg-danger p-2 align-items-center">
					<a href="HOME.jsp"
						class="d-flex text-decoration-none mt-1 align-items-center justify-content-center text-white">
						<img src="img\Insignia SRC.png" alt="Logo CASSIATEC"
						class="logo-img animated-img" style="height: 7rem">
					</a>
					<ul class="nav nav-pills flex-column mt-4">
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="HOME.jsp" class="nav-link text-white text-center"> <span
								class="fs-4 ms-3 d-none d-sm-inline">HOME</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="ActualizarMisDatos.jsp"
							class="nav-link text-white text-center"> <span
								class="fs-4 ms-3 d-none d-sm-inline">ACTUALIZAR MIS DATOS</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="RegistrarAsistencia.jsp"
							class="nav-link text-white text-center active"> <span
								class="fs-4 ms-3 d-none d-sm-inline">REGISTRAR ASISTENCIA</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="AgregarStudent.jsp" class="nav-link text-white text-center">
								<span class="fs-4 ms-3 d-none d-sm-inline">AGREGAR
									ESTUDIANTE</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="AgregarPerson.jsp" class="nav-link text-white text-center">
								<span class="fs-4 ms-3 d-none d-sm-inline">AGREGAR PERSON</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="ActualizarEstudiante.jsp"
							class="nav-link text-white text-center"> <span
								class="fs-4 ms-3 d-none d-sm-inline">ACTUALIZAR
									ESTUDIANTE</span>
						</a></li>
					</ul>
				</div>
			</div>

			<div class="col p-0 d-flex flex-column">
				<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
					<div class="container-fluid">
						<span id="currentDateTime" class="nav-link text-white"> <span
							id="currentTime" style="font-size: 34px;"></span> - <span
							id="currentDate"></span>
						</span>
						<button class="navbar-toggler" type="button"
							data-bs-toggle="collapse" data-bs-target="#navbarNav"
							aria-controls="navbarNav" aria-expanded="false"
							aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"></span>
						</button>
						<div class="collapse navbar-collapse justify-content-end"
							id="navbarNav">
							<ul class="navbar-nav">
								<li class="nav-item dropdown"><a
									class="nav-link dropdown-toggle text-white" href="#"
									id="logoutDropdown" role="button" data-bs-toggle="dropdown"
									aria-expanded="false"> Cerrar sesión </a>
									<ul class="dropdown-menu dropdown-menu-end"
										aria-labelledby="logoutDropdown">
										<li>
											<div class="d-flex flex-column align-items-center p-3">
												<img src="img\iconoUSUARIO.png" alt="Logo CASSIATEC"
													class="logo-img" style="height: 6rem"><span
													class="align-self-center">Auxiliar</span>
												<button class="btn btn-danger mt-2" data-bs-toggle="modal"
													data-bs-target="#confirmLogoutModal">Cerrar sesión</button>
											</div>
										</li>
									</ul></li>
							</ul>
						</div>
					</div>
				</nav>
				<script>
					// Obtener el elemento para mostrar la hora y fecha y actualizarlo cada segundo
					var currentDateTimeElement = document
							.getElementById("currentDateTime");

					// Función para obtener la hora actual en formato HH:MM:SS
					function getCurrentTime() {
						var currentDate = new Date();
						var hours = currentDate.getHours().toString().padStart(
								2, "0");
						var minutes = currentDate.getMinutes().toString()
								.padStart(2, "0");
						var seconds = currentDate.getSeconds().toString()
								.padStart(2, "0");
						return hours + ":" + minutes + ":" + seconds;
					}

					// Función para obtener la fecha actual en formato DD/MM/YYYY
					function getCurrentDate() {
						var currentDate = new Date();
						var days = [ 'Domingo', 'Lunes', 'Martes', 'Miércoles',
								'Jueves', 'Viernes', 'Sábado' ];
						var day = days[currentDate.getDay()];
						var date = currentDate.getDate().toString().padStart(2,
								"0");
						var months = [ 'enero', 'febrero', 'marzo', 'abril',
								'mayo', 'junio', 'julio', 'agosto',
								'septiembre', 'octubre', 'noviembre',
								'diciembre' ];
						var month = months[currentDate.getMonth()];
						var year = currentDate.getFullYear().toString();
						return day + ' ' + date + ' de ' + month + ' de '
								+ year;
					}

					// Actualizar la hora y fecha cada segundo
					function updateCurrentDateTime() {
						var currentTime = getCurrentTime();
						var currentDate = getCurrentDate();
						currentDateTimeElement.textContent = currentTime
								+ " - " + currentDate;
					}

					// Actualizar la hora y fecha inicial y luego cada segundo
					updateCurrentDateTime();
					setInterval(updateCurrentDateTime, 1000);

					function updateCurrentDateTime() {
						var currentTimeElement = document
								.getElementById("currentTime");
						var currentDateElement = document
								.getElementById("currentDate");

						var currentTime = getCurrentTime();
						var currentDate = getCurrentDate();

						currentTimeElement.textContent = currentTime;
						currentDateElement.textContent = currentDate;
					}
				</script>

				<!-- Modal -->
				<div class="modal fade" id="confirmLogoutModal" tabindex="-1"
					aria-labelledby="confirmLogoutModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="confirmLogoutModalLabel">Confirmar
									cierre de sesión</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="text-center mx-auto">
									<img src="img\cerrarSESION.png" alt="Logo CASSIATEC"
										class="logo-img" style="height: 6rem">
									<H4>
										<span>¿Desea cerrar <br>sesion?
										</span>
									</H4>
								</div>
							</div>
							<div class="modal-footer">
								<div class="text-center mx-auto">
									<button type="button" class="btn btn-danger"
										onclick="cerrarSesion()">Cerrar sesión</button>
									<script>
										function cerrarSesion() {
											// Redireccionar a la página de inicio de sesión
											window.location.href = "index.jsp";
										}
									</script>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="video-container flex-grow-1"
					style="background-image: linear-gradient(90deg, rgba(220, 53, 69, 1) 7%, rgba(255, 165, 0, 1) 44%, rgba(255, 255, 255, 1) 100%);">
					<div style="position: relative;">
						<video id="videoElement" autoplay style="position: relative;"></video>
						<canvas id="qrCanvas"
							style="position: absolute; top: -40%; left: -19%; width: 139%; height: 180%;"></canvas>
						<div id="qrDataOverlay"
							style="position: absolute; top: 10px; left: 10px; background-color: red; color: white; padding: 10px; border: 2px solid black; z-index: 1;"></div>
						<button
							style="position: absolute; top: -36%; left: -18%; background-color: red; color: white; padding: 10px; border: 2px solid black; z-index: 1;"
							type="button" class="btn btn-danger" onclick="volverAlRegistro()">Volver
							atrás</button>
					</div>
				</div>


				<!-- Toast para la notificación para asistencia primera vez del dia -->
<!-- 				<div class="toast" id="successToast" role="alert" -->
<!-- 					aria-live="assertive" aria-atomic="true" -->
<!-- 					style="position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999;"> -->
<!-- 					<div class="toast-header"> -->
<!-- 						<strong class="mr-auto">Asistencia guardada</strong> -->
<!-- 						<button type="button" class="ml-2 mb-1 close" data-dismiss="toast" -->
<!-- 							aria-label="Close"> -->
<!-- 							<span aria-hidden="true">&times;</span> -->
<!-- 						</button> -->
<!-- 					</div> -->
<!-- 					<div class="toast-body">Asistencia guardada exitosamente</div> -->
<!-- 				</div> -->



				<script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
				<script>
document.addEventListener("DOMContentLoaded", function() {
    const video = document.getElementById('videoElement');
    const qrCanvas = document.getElementById('qrCanvas');
    const qrDataOverlay = document.getElementById('qrDataOverlay');
    const form = document.getElementById('form');
    const qrCodeInput = document.getElementById('qrCodeInput');

    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(function(stream) {
                video.srcObject = stream;
                processVideo();
            })
            .catch(function(error) {
                console.log("Error al acceder a la cámara: " + error);
            });
    }

    function processVideo() {
        const canvas = qrCanvas;
        const context = canvas.getContext('2d');

        setInterval(function() {
            canvas.width = video.videoWidth;
            canvas.height = video.videoHeight;
            context.drawImage(video, 0, 0, canvas.width, canvas.height);
            const imageData = context.getImageData(0, 0, canvas.width, canvas.height);
            const code = jsQR(imageData.data, canvas.width, canvas.height);

            if (code) {
                console.log("Código QR detectado: " + code.data);
//                 qrDataOverlay.textContent = "Código QR detectado: " + code.data;

                // Validar el código QR antes de enviarlo al controlador
                if (validateQRCode(code.data)) {
                    // Actualizar el valor del campo oculto con el código QR detectado
                    qrCodeInput.value = code.data;

                    // Enviar el formulario al controlador utilizando AJAX
                    sendFormToController();
                } else {
                    // Mostrar un mensaje de QR inválido en tiempo real
                    qrDataOverlay.textContent = "Codigo QR inválido, muestre el codigo QR institucional, gracias";
                }

                // Dibujar el cuadrado verde alrededor del código QR
                drawQRCodeRect(code.location, canvas);
            } else {
                qrDataOverlay.textContent = "";
            }
        }, 100);
    }

    function validateQRCode(qrCode) {
        // Validar la estructura del código QR
        const qrData = qrCode.split(", ");
        return qrData.length === 3;
    }

    function drawQRCodeRect(location, canvas) {
        const context = canvas.getContext('2d');
        context.strokeStyle = 'red';
        context.lineWidth = 8;
        context.beginPath();
        context.moveTo(location.topLeftCorner.x, location.topLeftCorner.y);
        context.lineTo(location.topRightCorner.x, location.topRightCorner.y);
        context.lineTo(location.bottomRightCorner.x, location.bottomRightCorner.y);
        context.lineTo(location.bottomLeftCorner.x, location.bottomLeftCorner.y);
        context.lineTo(location.topLeftCorner.x, location.topLeftCorner.y);
        context.stroke();
        context.closePath();
    }

    function sendFormToController() {
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "ControladorQR", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    handleResponse(xhr.responseText);
                } else {
                    console.log("Error al enviar el formulario al controlador");
                }
            }
        };
        const formData = new FormData(form);
        xhr.send(new URLSearchParams(formData).toString());
    }

    function handleResponse(response) {
        const jsonResponse = JSON.parse(response);
        if (jsonResponse.success) {
            qrDataOverlay.textContent = jsonResponse.message;
            qrDataOverlay.style.backgroundColor = "green";
			console.log("Asistencia guardada exitosamente");
            
         	// Mostrar la notificación de asistencia guardada exitosamente
            //const successToast = new bootstrap.Toast(document.getElementById('successToast'));
            //successToast.show();

            // Ocultar la notificación después de 6 segundos
            //setTimeout(function() {
            //    successToast.hide();
            //}, 6000);
			const alertWrapper = document.getElementById('alertWrapper');
            alertWrapper.style.display = 'block';
            
         	// Ocultar la notificación después de 6 segundos
            setTimeout(function () {
      		alertWrapper.style.display = 'none';
    		}, 6000); // Ocultar el alert después de 6 segundos (6000 milisegundos)
            
        } else {
            qrDataOverlay.textContent = jsonResponse.message;
            qrDataOverlay.style.backgroundColor = "red";
            console.log("Este estudiante ya ha sido registrado hoy");
            
        }
        setTimeout(function() {
            qrDataOverlay.textContent = "";
            qrDataOverlay.style.backgroundColor = "red";
        }, 5000); // Ocultar el mensaje después de 5 segundos
    }
});

function volverAlRegistro() {
    // Redireccionar a la página deseada
    window.location.href = "RegistrarAsistenciaResultados.jsp";
}

</script>


				<!-- Formulario para enviar los datos al controlador -->
				<form id="form" action="ControladorQR" method="POST">
					<input type="hidden" id="qrCodeInput" name="qrCode" value="">
				</form>



			</div>
		</div>



		<script src="https://kit.fontawesome.com/3d22aaea26.js"
			crossorigin="anonymous"></script>
</body>
</html>