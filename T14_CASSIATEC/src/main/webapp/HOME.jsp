<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- codigo para poner logo en pesta�a de navegador -->
<link rel="icon" type="image/png" sizes="100x100"
	href="img\Insignia SRC.png">

<title>Home</title>
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

<jsp:include page="Promocion.jsp"></jsp:include>

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
							href="HOME.jsp" class="nav-link text-white text-center active">
								<span class="fs-4 ms-3 d-none d-sm-inline">HOME</span>
						</a></li>
						<li class="nav-item py-2 py-sm-0 align-items-center"><a
							href="ActualizarMisDatos.jsp"
							class="nav-link text-white text-center"> <span
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
					<div class="container">
						<div class="row">
							<div class="col-md-10 mx-auto">
								<div class="card">
									<div class="card-body">
										<!-- Aqu� puedes agregar los datos del person (auxiliar o director) -->
										<h2 class="text-center mt-4">
											�Bienvenido <strong>Auxiliar</strong>!
										</h2>
										<form action="Controlador" method="POST">
											<div class="row">
												<div
													class="col-lg-6 mb-3 text-center d-flex justify-content-center">
													<img src="img/iconoUSUARIO.png" alt="Usuario" width="100"
														height="100" class="align-self-center">
												</div>
												<div class="col-lg-6">
													<div class="mb-3">
														<label for="nombre" class="form-label">Nombre:</label> <input
															type="text" class="form-control" id="nombre"
															placeholder="Ingrese su nombre">
													</div>
													<div class="mb-3">
														<label for="apellido" class="form-label">Apellido:</label>
														<input type="text" class="form-control" id="apellido"
															placeholder="Ingrese su apellido">
													</div>
												</div>
											</div>


											<!--<div class="row">
								<div class="col-6 mb-3">
									<label for="nombre" class="form-label">Nombre:</label> <input
										type="text" class="form-control" id="nombre"
										placeholder="Ingrese su nombre">
								</div>

								<div class="col-6 mb-3">
									<label for="apellido" class="form-label">Apellido:</label> <input
										type="text" class="form-control" id="apellido"
										placeholder="Ingrese su apellido">
								</div>
							</div>-->

											<div class="row">
												<div class="col-6 mb-3">
													<label for="DNI" class="form-label">DNI:</label> <input
														type="text" class="form-control" id="DNI"
														placeholder="Ingrese su DNI">
												</div>

												<div class="col-6 mb-3">
													<label for="Email" class="form-label">Email:</label> <input
														type="text" class="form-control" id="Email"
														placeholder="Ingrese su Email">
												</div>
											</div>

											<div class="row">
												<div class="col-6 mb-3">
													<label for="Telefono" class="form-label">Telefono:</label>
													<input type="text" class="form-control" id="Telefono"
														placeholder="Ingrese su Telefono">
												</div>

												<div class="col-6 mb-3">
													<label for="Grados" class="form-label">Grado:</label> <input
														type="text" class="form-control" id="Grado"
														placeholder="Ingrese su Grado">
												</div>
											</div>

											<div class="row">
												<div class="col-6 mb-3">
													<label for="Turno" class="form-label">Turno:</label> <input
														type="text" class="form-control" id="edad"
														placeholder="Ingrese su Turno">
												</div>

												<div class="col-6 mb-3">
													<label for="Sexo" class="form-label">Seccion:</label> <input
														type="text" class="form-control" id="Seccion"
														placeholder="Ingrese su Seccion">
												</div>
											</div>

											<div class="row justify-content-center">
												<div class="col-lg-6 col-md-8 col-sm-10 col-12 mb-3">
													<label for="Fecha de nacimiento"
														class="form-label col-12 mb-3 text-center text-dark">Fecha
														de nacimiento:</label> <input type="text"
														class="form-control text-center input-custom placeholder-black"
														id="Fecha de nacimiento"
														placeholder="Ingrese su Fecha de nacimiento">
												</div>
											</div>

										</form>
									</div>
								</div>
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