<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<!-- codigo para poner logo en pestaña de navegador -->
<link rel="icon" type="image/png" sizes="100x100"
	href="img\Insignia SRC.png">

<title>Reporte individual</title>
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
	max-height: 530px; /* ajusta la altura máxima según tus necesidades */
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

				<div class="p-0">
					<div class="row">
						<div class="col-6 mb-3">
							<div>
								<h1>Reporte Individual</h1>
								<form action="Controlador2" method="POST">
									<input type="submit" class="btn btn-success w-25" name="accion"
										value="BuscarOtraAula"> <input type="hidden"
										name="studentId" value="${studentIdParam}">
								</form>

								<!-- Button modal Exportacion -->
								<button class="btn btn-danger" data-bs-toggle="modal"
									data-bs-target="#exportModal">Exportar</button>
							</div>
						</div>

						<div class="col-6 mb-3">
							<form
								action="Controlador2?studentId=${param.studentId}&studentDocument=${param.studentDocument}&studentNames=${param.studentNames}&studentLastNames=${param.studentLastNames}"
								method="POST">
								<h2>Filtrar por fecha</h2>
								<div class="row">
									<input type="hidden" name="studentId"
										value="${param.studentId}">
									<div class="col-6 mb-3">
										<h5>Fecha de inicio</h5>
										<input type="date" class="form-control" name="txtFechaInicio"
											id="txtFechaInicio" required>
									</div>

									<div class="col-6 mb-3">
										<h5>Fecha de termino</h5>
										<input type="date" class="form-control" name="txtFechaFin"
											id="txtFechaFin" required>
									</div>
								</div>

								<input class="btn btn-success" type="submit" name="accion"
									value="GenerarReporteFiltroFecha"> 
							</form>

							<form
								action="Controlador2?studentId=${param.studentId}&studentDocument=${param.studentDocument}&studentNames=${param.studentNames}&studentLastNames=${param.studentLastNames}"
								method="POST">
								<input type="hidden" name="studentId" value="${param.studentId}">

								<input class="btn btn-info" type="submit" name="accion"
									value="VerReportesCompleto">
							</form>
						</div>
					</div>


					<!-- Modal de Exportación -->
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
									<p>Seleccione el formato de exportación:</p>

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

					<!-- Este codigo es para ver el reporte -->
					<div class="table-container">
						<form action="Controlador2" method="POST">

							<!-- Este Div es para mostrar los datos que se volvera a mostrar con param de acuerdo a lo que se vio en RegistrarAsistenciaResultados.jsp -->
							<!-- Esta oculto porque no es necesario que el usuario lo vea ;) -->
							<div style="display: none;">
								<input name="id-actual-estudiante" value="${param.studentId}">
								<input name="studentDocument" value="${param.studentDocument}">
								<input name="studentNames" value="${param.studentNames}">
								<input name="studentLastNames" value="${param.studentLastNames}">
							</div>

							<div class="table-container">
								<table class="table table-bordered table-striped">
									<thead class="thead-dark">
										<tr>
											<th colspan="4" class="table-header">

												<div class="row">
													<div class="col-10">
														<div class="form-group">
															<h4>Información del Reporte:</h4>
															<h5>
																N° Doc: ${param.studentDocument} <br> Alumna:
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
											<th class="table-header">Opciones</th>
										</tr>
									</thead>

									<tbody>
										<c:forEach var="attendance" items="${reporte}">
											<tr>
												<td style="display: none;">${attendance.idAttendance}</td>
												<td style="display: none;">${attendance.studentId}</td>
												<td>${attendance.attendanceDateTimeDB}</td>
												<td>${attendance.attendanceStatusDB}</td>
												<td>${attendance.attendance_ocurrencia}</td>
												<td>
													<form
														action="Controlador2?studentId=${param.studentId}&studentDocument=${param.studentDocument}&studentNames=${param.studentNames}&studentLastNames=${param.studentLastNames}"
														method="POST">

														<!-- Este input es para mostrar y enviar el id el resgistro a eliminar  -->
														<input type="hidden" name="id_attendance"
															value="${attendance.getIdAttendance()}">


														<!-- Este input es solo para ver el id del estudiante ya que en el action se mantendra el id del estudiante -->
														<input type="hidden" name="id-actual-estudiante"
															value="${attendance.getStudentId()}">


														<!-- 														<button class="btn btn-success" type="button" -->
														<%-- 															onclick="openModal('Edit', '${attendance.idAttendance}')">Editar</button> --%>

														<button class="btn btn-success" type="button"
															data-bs-toggle="offcanvas"
															data-bs-target="#staticBackdrop"
															aria-controls="staticBackdrop"
															onclick="openOffcanvas('Edit', '${attendance.idAttendance}')">Editar</button>


														<input class="btn btn-danger" type="submit" name="accion"
															value="Eliminar">

													</form>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>

						</form>
					</div>
				</div>


				<div class="offcanvas offcanvas-end" data-bs-scroll="true"
					data-bs-backdrop="false" tabindex="-1" id="staticBackdrop"
					aria-labelledby="offcanvasScrollingLabel">
					<div class="offcanvas-header">
						<h5 class="offcanvas-title" id="offcanvasScrollingLabel">Editar
							Registro</h5>
						<button type="button" class="btn-close"
							data-bs-dismiss="offcanvas" aria-label="Close"></button>
					</div>
					<div class="offcanvas-body">aqui van los datos a editar, se
						insertara de acuerdo al script que esta al final de este archivo</div>
				</div>


				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title fs-5" id="exampleModalLabel">Editar
									registro</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>

							<div class="modal-body">aqui van los datos a editar, se
								insertara de acuerdo al script que esta al final de este archivo</div>

						</div>
					</div>
				</div>


				<!-- Este codigo es solo para que la importacion este sin las opciones de eliminar o editar -->
				<div class="table-container" style="display: none;">
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
														<h4>Información del Reporte:</h4>
														<h5>
															N° Doc: ${param.studentDocument} <br> Alumna:
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
											<td>${attendance.attendanceDateTimeDB}</td>
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
  // Obtén una referencia al botón Descargar PDF
  const botonDescargarPDF = document.getElementById('descargarPDF');

  // Agrega el evento click al botón Descargar PDF
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

	<script>
    function openModal(action, idAttendance) {
        console.log("openModal called with action: " + action + ", idAttendance: " + idAttendance);

        // Realizar una solicitud AJAX para obtener los datos del servidor
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status === 200) {
                    var data = JSON.parse(xhr.responseText);
                    displayDataInModal(data);
                } else {
                    console.error("Error al obtener datos del servidor");
                }
            }
        };

        // Realizar la solicitud POST al servidor con la acción y el id_attendance
        xhr.open("POST", "Controlador2", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("accion=" + action + "&id_attendance=" + idAttendance);
    }

    function displayDataInModal(data) {
        // Obtener la referencia al modal
        var modal = new bootstrap.Modal(document.getElementById('exampleModal'));

        // Actualizar el contenido del modal con los datos
        var modalBody = modal._element.querySelector('.modal-body');
        modalBody.innerHTML = "";

        // Crear un formulario
        var form = document.createElement("form");
        form.action = "Controlador2?studentId=${param.studentId}&studentDocument=${param.studentDocument}&studentNames=${param.studentNames}&studentLastNames=${param.studentLastNames}";
        form.method = "POST";

        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                // Crear un div para cada campo del formulario
                var div = document.createElement("div");
                div.classList.add("col-6", "mb-3");

                // Crear una etiqueta de label
                var label = document.createElement("label");
                label.innerHTML = key + ":";

                // Crear un input para el campo
                var input = document.createElement("input");
                input.type = "text";
                input.classList.add("form-control");
                input.name = "txt" + key;
                input.id = "txt" + key;
                input.value = data[key];
                input.required = true;

                // Agregar elementos al div
                div.appendChild(label);
                div.appendChild(input);

                // Agregar div al formulario
                form.appendChild(div);
            }
        }

        // Crear un botón de submit
        var submitButton = document.createElement("input");
        submitButton.type = "submit";
        submitButton.classList.add("btn", "btn-success", "w-50");
        submitButton.name = "accion";
        submitButton.value = "ActualizarAsistencia";

        // Agregar botón al formulario
        form.appendChild(submitButton);

        // Agregar formulario al modal
        modalBody.appendChild(form);

        // Abrir el modal
        modal.show();
    }
</script>




	<script>
function openOffcanvas(action, idAttendance) {
    console.log("openOffcanvas called with action: " + action + ", idAttendance: " + idAttendance);

    // Realizar una solicitud AJAX para obtener los datos del servidor
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var data = JSON.parse(xhr.responseText);

                // Log de la respuesta JSON en la consola
                console.log("Response JSON: ", data);

                displayDataInOffcanvas(data);
            } else {
                console.error("Error al obtener datos del servidor");
            }
        }
    };

        // Realizar la solicitud POST al servidor con la acción y el id_attendance
        xhr.open("POST", "Controlador2", true);
        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhr.send("accion=" + action + "&id_attendance=" + idAttendance);
    }

    function displayDataInOffcanvas(data) {
        // Obtener la referencia al offcanvas
        var offcanvas = new bootstrap.Offcanvas(document.getElementById('staticBackdrop'));

        // Actualizar el contenido del offcanvas con los datos
        var offcanvasBody = offcanvas._element.querySelector('.offcanvas-body');
        offcanvasBody.innerHTML = "";

        // Crear un formulario
        var form = document.createElement("form");
        form.action = "Controlador2?studentId=${param.studentId}&studentDocument=${param.studentDocument}&studentNames=${param.studentNames}&studentLastNames=${param.studentLastNames}";
        form.method = "POST";

        for (var key in data) {
            if (data.hasOwnProperty(key)) {
                // Crear un div para cada campo del formulario
                var div = document.createElement("div");
                div.classList.add("col-6", "mb-3");

                // Crear una etiqueta de label
                var label = document.createElement("label");
                label.innerHTML = key + ":";

                // Crear un input para el campo
                var input = document.createElement("input");
                input.type = "text";
                input.classList.add("form-control");
                input.name = "txt" + key;
                input.id = "txt" + key;
                input.value = data[key];
                input.required = false;

                // Agregar elementos al div
                div.appendChild(label);
                div.appendChild(input);

                // Agregar div al formulario
                form.appendChild(div);
            }
        }

        // Log en la consola para verificar el contenido del formulario
        console.log(form);

        // Crear un botón de submit
        var submitButton = document.createElement("input");
        submitButton.type = "submit";
        submitButton.classList.add("btn", "btn-success", "w-50");
        submitButton.name = "accion";
        submitButton.value = "ActualizarAsistencia";

        // Agregar botón al formulario
        form.appendChild(submitButton);

        // Log en la consola para verificar el contenido del formulario después de agregar el botón
        console.log(form);

        // Agregar formulario al offcanvas
        offcanvasBody.appendChild(form);

        // Log en la consola para verificar el contenido del offcanvas después de agregar el formulario
        console.log(offcanvasBody);

        // Abrir el offcanvas
        offcanvas.show();
    }
</script>


</body>
</html>