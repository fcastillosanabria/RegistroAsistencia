<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- codigo para poner logo en pesta�a de navegador -->
<link rel="icon" type="image/png" sizes="100x100"
	href="img\Insignia SRC.png">

<title>CRUD Person</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
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

.table-container {
	max-height: 300px; /* ajusta la altura m�xima seg�n tus necesidades */
	overflow-y: scroll;
}

.modal-pink {
	background-color: pink;
}

@keyframes move {
  0% {
    transform: translateX(0);
  }
  50% {
    transform: translateX(-20px);
  }
  100% {
    transform: translateX(0);
  }
}

.animated-img {
  animation: move 2s infinite;
}
</style>
<body>

	<!-- Modal de anuncio -->
	<div id="modalPromocion" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content modal-pink">
				<div class="modal-header">
					<h2 class="modal-title">Promoci�n</h2>
				</div>
				<div class="modal-body text-center">
					<h3>Compre el sistema ahora</h3>
					<h4>�Descuentos de locura!</h4>
				</div>
				<div class="modal-footer">
					<a href="mailto:jcanales@vallegrande.edu.pe"
						class="btn btn-success">Contactarme</a>
					<button type="button" class="btn btn-warning"
						data-bs-dismiss="modal" id="btnComprarMasTarde">Comprar
						m�s tarde</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<script>
		$(document).ready(
				function() {
					var modalPromocion = new bootstrap.Modal(document
							.getElementById('modalPromocion'));
					var timer;

					// Funci�n para mostrar el modal autom�ticamente cada 5 segundos
					function mostrarModalPromocion() {
						modalPromocion.show();
						timer = setTimeout(function() {
							modalPromocion.hide();
							setTimeout(mostrarModalPromocion, 5000);
						}, 5000);
					}

					// Mostrar el modal al cargar la p�gina
					mostrarModalPromocion();

					// Funci�n para cancelar el bucle por 30 minutos
					function cancelarBucle() {
						clearTimeout(timer);
						setTimeout(mostrarModalPromocion, 1800000); // 30 minutos en milisegundos
					}

					// Manejador de eventos para el bot�n "Comprar m�s tarde"
					$('#btnComprarMasTarde').click(function() {
						modalPromocion.hide();
						cancelarBucle();
					});
				});
	</script>


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
							href="#" class="nav-link text-white text-center  active"> <span
								class="fs-4 ms-3 d-none d-sm-inline">ACTUALIZAR MIS DATOS</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="RegistrarAsistencia.jsp" class="nav-link text-white text-center"> <span
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

			<div class="col p-0">
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
									aria-expanded="false"> Cerrar sesi�n </a>
									<ul class="dropdown-menu dropdown-menu-end"
										aria-labelledby="logoutDropdown">
										<li>
											<div class="d-flex flex-column align-items-center p-3">
												<img src="img\iconoUSUARIO.png" alt="Logo CASSIATEC"
													class="logo-img" style="height: 6rem"><span
													class="align-self-center">Auxiliar</span>
												<button class="btn btn-danger mt-2" data-bs-toggle="modal"
													data-bs-target="#confirmLogoutModal">Cerrar sesi�n</button>
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

					// Funci�n para obtener la hora actual en formato HH:MM:SS
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

					// Funci�n para obtener la fecha actual en formato DD/MM/YYYY
					function getCurrentDate() {
						var currentDate = new Date();
						var days = [ 'Domingo', 'Lunes', 'Martes', 'Mi�rcoles',
								'Jueves', 'Viernes', 'S�bado' ];
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
									cierre de sesi�n</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="text-center mx-auto">
									<img src="img\cerrarSESION.png" alt="Logo CASSIATEC"
										class="logo-img" style="height: 6rem">
									<H4>
										<span>�Desea cerrar <br>sesion?
										</span>
									</H4>
								</div>
							</div>
							<div class="modal-footer">
								<div class="text-center mx-auto">
									<button type="button" class="btn btn-danger"
										onclick="cerrarSesion()">Cerrar sesi�n</button>
									<script>
										function cerrarSesion() {
											// Redireccionar a la p�gina de inicio de sesi�n
											window.location.href = "index.jsp";
										}
									</script>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="p-0">

					<div class="row">
						<div class="col d-flex align-items-end">
							<div class="container">
								<!-- Div para buscar person -->
								<div class="row">
									<form action="Controlador" method="POST" class="mb-4">
										<div class="row">
											<div class="col-4 mb-3">
												<div class="form-group">
													<label for="txtTurn">Nombres:</label> <input type="text"
														class="form-control mb-2" id="txtNames" name="txtNames"
														placeholder="Ingrese el Nombre"
														onkeypress="return validateLetters(event)">
												</div>
												<div class="col">
													<button type="submit" class="btn btn-success" name="accion"
														value="ListarNOMBREyAPELLIDO">Me siento con
														suerte</button>
												</div>
											</div>
											<div class="col-4 mb-3">
												<div class="form-group">
													<label for="txtTurn">Apellidos:</label> <input type="text"
														class="form-control" id="txtLast_names"
														name="txtLast_names" placeholder="Ingrese el Apellido"
														onkeypress="return validateLetters(event)">
												</div>
											</div>
										</div>

										<!-- 										script para solo colocar letras en los input -->
										<script>
											function validateLetters(event) {
												var key = event.key;
												var regex = /[a-zA-Z\s]/;
												if (!regex.test(key)) {
													event.preventDefault();
													return false;
												}
											}
										</script>

									</form>
								</div>
							</div>
						</div>
						<div class="col">
							<div class="container mx-auto text-center">
								<h3>Person activos</h3>
								<form class="mb-3" action="Controlador" method="POST">
									<input class="btn btn-primary" type="submit" name="accion"
										value="Listar">
									<button type="button" class="btn btn-primary"
										onclick="window.location.href='verDNIoCNE.jsp'">Buscar
										por N� Doc</button>
									<input class="btn btn-warning" data-bs-toggle="modal"
										data-bs-target="#exampleModa2" type="submit" name="accion"
										value="ListarEliminados">
								</form>
							</div>
						</div>
					</div>

				</div>

			</div>
		</div>
	</div>

	<script src="https://kit.fontawesome.com/3d22aaea26.js"
		crossorigin="anonymous"></script>
</body>
</html>