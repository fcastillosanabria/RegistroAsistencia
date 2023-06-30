<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

.table-container {
	max-height: 530px; /* ajusta la altura m�xima seg�n tus necesidades */
	overflow-y: scroll;
}

th.table-header {
	background-color: red;
	color: white;
}
</style>
<body>
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

					<h1>Reporte Individual</h1>
					<form action="Controlador2" method="POST">
						<input type="submit" class="btn btn-success w-25" name="accion"
							value="BuscarOtraAula"> <input type="hidden"
							name="studentId" value="${studentIdParam}">
					</form>

					<!-- Button modal Exportacion -->
					<button class="btn btn-danger" data-bs-toggle="modal"
						data-bs-target="#exportModal">Exportar</button>

					<!-- Modal de Exportaci�n -->
					<div class="modal fade" id="exportModal" tabindex="-1"
						aria-labelledby="exportModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exportModalLabel">Exportar
										Datos</h5>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<p>Seleccione el formato de exportaci�n:</p>

									<button id="descargarPDF">
										<img src="img\PDF.png" alt="Descargar PDF"
											style="height: 4rem">
										<h4>PDF</h4>
									</button>
									<button id="descargarExcel">
										<img src="img\EXCEL.png" alt="Descargar EXCEL"
											style="height: 4rem">
										<h4>EXCEL</h4>
									</button>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-danger"
										data-bs-dismiss="modal">Cerrar</button>
								</div>
							</div>
						</div>
					</div>

					<div class="table-container">
						<form action="Controlador2" method="POST">
							<div class="col-6 mb-3" style="display: none;">
								<input type="hidden" name="idreporte" value="${student.getId()}">
							</div>

							<div class="table-container">
								<table class="table table-bordered table-striped"
									id="tablaResporteIndividual">
									<thead class="thead-dark">
										<tr>

											<th colspan="3" class="table-header">

												<div class="row">
													<div class="col-10">
														<div class="form-group">
															<h4>Informaci�n del Reporte:</h4>
															<h5>
																N� Doc: ${param.studentDocument} <br> Alumna:
																${param.studentLastNames}, ${param.studentNames}
															</h5>
														</div>
													</div>

													<div class="col-2">
														<div class="form-group text-center">
															<img src="img\Insignia SRC.png" alt="login-icon"
																style="height: 6rem;" />
														</div>
													</div>
												</div>
											</th>

										</tr>
										<tr>
											<th class="table-header">Fecha</th>
											<th class="table-header">Estado de Asistencia</th>
											<th class="table-header">Ocurrencia</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="attendance" items="${reporte}">
											<tr>
												<td>${attendance.attendanceDateTime}</td>
												<td>${attendance.attendanceStatusDB}</td>
												<td>${attendance.attendance_ocurrencia}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

						</form>
					</div>

				</div>
			</div>
		</div>
	</div>
	<script src="https://kit.fontawesome.com/3d22aaea26.js"
		crossorigin="anonymous"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.3/jspdf.umd.min.js"></script>

	<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>
	<script src="https://unpkg.com/file-saver/dist/FileSaver.min.js"></script>


	<script>
				// Exportar a Excel
  function exportToExcel(data, filename, sheetname) {
    var workbook = XLSX.utils.book_new();
    var worksheet = XLSX.utils.json_to_sheet(data);
    XLSX.utils.book_append_sheet(workbook, worksheet, sheetname);
    var excelData = XLSX.write(workbook, { bookType: 'xlsx', type: 'array' });
    var blob = new Blob([excelData], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
    var link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = filename;
    link.click();
    URL.revokeObjectURL(link.href);
  }

  // Conectar al boton 
  var descargarExcelBtn = document.getElementById('descargarExcel');
  descargarExcelBtn.addEventListener('click', function() {
    
    // Llamamos a la tabla y colocamos los datos
    var table = document.getElementById('tablaResporteIndividual');
    var data = Array.from(table.rows).slice(1).map(function(row) {
      return {
        'Fecha': row.cells[0].textContent,
        'Estado de Asistencia': row.cells[1].textContent,
        'Ocurrencia': row.cells[2].textContent,
      };
    });

    var filename = 'Reporte_Individual.xlsx';
    var sheetname = 'Hoja 1';
    exportToExcel(data, filename, sheetname);
  });
				</script>

	<script>
  // Obt�n una referencia al bot�n Descargar PDF
  const botonDescargarPDF = document.getElementById('descargarPDF');

  // Agrega el evento click al bot�n Descargar PDF
  botonDescargarPDF.addEventListener('click', () => {
    const tablaEstudiantes = document.getElementById('tablaResporteIndividual');

    // Configura las opciones de html2pdf
    const options = {
      filename: 'Reporte_Individual.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 2 },
      jsPDF: { unit: 'pt', format: 'a4', orientation: 'portrait' },
    };

    // Crea el documento PDF con html2pdf
    html2pdf().set(options).from(tablaEstudiantes).save();
  });
</script>
</body>
</html>