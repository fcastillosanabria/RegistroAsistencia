<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<link rel="icon" type="image/x-icon" href="/assets/logo-vt.svg" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- codigo para poner logo en pesta�a de navegador -->
<link rel="icon" type="image/png" sizes="100x100" href="img\Insignia SRC.png">

<title>CRUD Student Eliminados</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz"
	crossorigin="anonymous"></script>
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

.delete-button {
	cursor: pointer;
	background: transparent;
	border: none;
	padding: 0;
}

.custom-modal-dialog {
	max-width: 90%;
	width: fit-content;
}

.table-container {
	max-height: 530px; /* ajusta la altura m�xima seg�n tus necesidades */
	overflow-y: scroll;
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
</head>
<body
	class="custom-bg d-flex justify-content-center align-items-center vh-100">

<%-- Verificar si el atributo "eliminado" est� presente --%>
<% if (request.getAttribute("eliminado") != null) { %>
    <div class="alert alert-danger alert-dismissible fade show position-fixed" style="z-index: 9999; top: 50px; left: 50%; transform: translateX(-50%);" role="alert" id="alertaEliminado">
        <h4>El registro ha sido eliminado correctamente.</h4>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        // Obtener la referencia a la alerta
        var alerta = document.getElementById('alertaEliminado');
        
        // Ocultar la alerta despu�s de 4 segundos
        setTimeout(function() {
            alerta.style.display = 'none';
        }, 4000);
    </script>
 <% } %>
    
    	<%-- Verificar si el atributo "reactivado" est� presente --%>
<% if (request.getAttribute("reactivado") != null) { %>
    <div class="alert alert-success alert-dismissible fade show position-fixed" style="z-index: 9999; top: 50px; left: 50%; transform: translateX(-50%);" role="alert" id="alertaReactivado">
        <h4>El registro ha reactivado correctamente.</h4>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <script>
        // Obtener la referencia a la alerta
        var alerta = document.getElementById('alertaReactivado');
        
        // Ocultar la alerta despu�s de 4 segundos
        setTimeout(function() {
            alerta.style.display = 'none';
        }, 4000);
    </script>
<% } %>
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
							href="#" class="nav-link text-white text-center"> <span
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
							class="nav-link text-white text-center  active"> <span
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
									<form action="Controlador2" method="POST" class="mb-4">
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
														value="ListarNOMBREyAPELLIDOeliminados">Buscar Estudiante</button>
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

								<%-- Verifica si existe un mensaje de error --%>
								<%
								String errorMessage = (String) request.getAttribute("errorMessage");
								%>
								<%
								if (errorMessage != null && !errorMessage.isEmpty()) {
								%>
								<!-- Muestra el modal con el mensaje de error -->
								<div class="modal" id="errorModal" tabindex="-1" role="dialog"
									aria-labelledby="errorModalLabel" aria-hidden="true">
									<div class="modal-dialog" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="errorModalLabel">Error</h5>
												<button type="button" class="close" data-dismiss="modal"
													aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<div class="modal-body">
												<p><%=errorMessage%></p>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-dismiss="modal">Cerrar</button>
											</div>
										</div>
									</div>
								</div>

								<!-- Agrega el c�digo JavaScript para mostrar el modal -->
								<script>
        $(document).ready(function() {
            $('#errorModal').modal('show');
        });
    </script>
								<%
								}
								%>


							</div>
						</div>
						<div class="col">
							<div class="container mx-auto text-center">
								<h3>Student Eliminadas</h3>
								<form class="mb-3" action="Controlador2" method="POST">
									<input class="btn btn-primary" type="submit" name="accion"
										value="listar">
									<button type="button" class="btn btn-primary"
										onclick="window.location.href='verDNIoCNEstudent.jsp'">Buscar
										por N� Doc</button>
									<input class="btn btn-warning" data-bs-toggle="modal"
										data-bs-target="#exampleModa2" type="submit" name="accion"
										value="ListarEliminados">
								</form>
								<button class="btn btn-success" data-bs-toggle="modal"
									data-bs-target="#exportModal">Exportar</button>

								<!-- Modal de Exportaci�n -->
								<div class="modal fade" id="exportModal" tabindex="-1"
									aria-labelledby="exportModalLabel" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exportModalLabel">Exportar
													Datos</h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
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
												<button id="descargarCSV">
													<img src="img\CSV.png" alt="Descargar CSV"
														style="height: 4rem">
													<h4>CSV</h4>
												</button>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-secondary"
													data-bs-dismiss="modal">Cerrar</button>
											</div>
										</div>
									</div>
								</div>

							</div>
						</div>
					</div>
				</div>

				<div class="container">
					<div class="table-container">
						<table class="table table-bordered" id="tablaStudent">
							<thead>
								<tr>
									<!-- 					<th>ID</th> -->
									<th>TIPO DOC</th>
									<th>N� DOC</th>
									<!-- 					<th>ROLE</th> -->
									<!-- 					<th>STATUS</th> -->
									<th>TURNO</th>
									<th>NOMBRE</th>
									<th>APELLIDO</th>
									<th>NACIMIENTO</th>
									<th>SECCION</th>
									<th>GRADE</th>
									<th>EMAIL</th>
									<th>TELEFONO DEL APODERADO</th>
									<th>UBIGEO</th>
									<th>ACCIONES</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="dato" items="${datos}">
									<tr>
										<%-- 						<td>${dato.getId()}</td> --%>
										<td>${dato.getDocument_type()}</td>
										<td>${dato.getDocument_number()}</td>
										<%-- 						<td>${dato.getRole()}</td> --%>
										<%-- 						<td>${dato.getStatus()}</td> --%>
										<td>${dato.getTurn()}</td>
										<td>${dato.getNames()}</td>
										<td>${dato.getLast_names()}</td>
										<td>${dato.getFormattedBirthdate()}</td>
										<td>${dato.getSection()}</td>
										<td>${dato.getGrade()}</td>
										<td>${dato.getEmail()}</td>
										<td>${dato.getPhone_proxy()}</td>
										<td>${dato.getCityFromUbigeo()}</td>
										<td>
											<form action="Controlador2" method="POST">
												<input type="hidden" name="id" value="${dato.getId()}">
												<input class="btn btn-info" type="submit" name="accion"
													value="Reactivar">

												<button type="button" class="btn btn-danger"
													data-bs-toggle="modal" data-bs-target="#confirmModal">Eliminar</button>
												<div class="modal fade" id="confirmModal" tabindex="-1"
													aria-labelledby="confirmModalLabel" aria-hidden="true">
													<div class="modal-dialog">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="confirmModalLabel">Confirmar
																	eliminaci�n</h5>
																<button type="button" class="btn-close"
																	data-bs-dismiss="modal" aria-label="Close"></button>
															</div>
															<div class="modal-body">
																<p>�Est�s seguro de que deseas eliminar este
																	registro definitivamente?</p>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-bs-dismiss="modal">Cancelar</button>
																<input class="btn btn-danger" type="submit"
																	name="accion" value="EliminadoFisico">
															</div>
														</div>
													</div>
												</div>


												<!-- 												<input class="btn btn-danger" type="submit" name="accion" -->
												<!-- 													value="EliminadoFisico"> -->
											</form>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>


				<script
					src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
				<script
					src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.3/jspdf.umd.min.js"></script>
				<script src="https://unpkg.com/xlsx/dist/xlsx.full.min.js"></script>

<script>
// Exportar a CSV
function exportToCSV(data, filename) {
  const csvData = convertToCSV(data);
  const blob = new Blob([csvData], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  if (link.download !== undefined) {
    const url = URL.createObjectURL(blob);
    link.setAttribute('href', url);
    link.setAttribute('download', filename);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }
}

// Convertir los datos a formato CSV
function convertToCSV(data) {
  const csvArray = [];
  const header = Object.keys(data[0]);
  csvArray.push(header.join(','));

  data.forEach((item) => {
    const row = Object.values(item);
    csvArray.push(row.join(','));
  });

  return csvArray.join('\n');
}

// Conectar al bot�n de descarga
const descargarCSVBtn = document.getElementById('descargarCSV');
descargarCSVBtn.addEventListener('click', function () {
  // Llamamos a la tabla y colocamos los datos
  const table = document.getElementById('tablaStudent');
  const data = Array.from(table.rows).slice(1).map(function (row) {
	  return {
	        'TIPO DOC': row.cells[0].textContent,
	        'N� DOC': row.cells[1].textContent,
	        'TURNO': row.cells[2].textContent,
	        'NOMBRE': row.cells[3].textContent,
	        'APELLIDO': row.cells[4].textContent,
	        'NACIMIENTO': row.cells[5].textContent,
	        'SECCION': row.cells[6].textContent,
	        'GRADO': row.cells[7].textContent,
	        'EMAIL': row.cells[8].textContent,
	        'TELEFONO DEL APODERADO': row.cells[9].textContent,
	        'UBIGEO': row.cells[10].textContent,
	      };
	    });

  const filename = 'Listado_Student_Inactivos.csv';
  exportToCSV(data, filename);
});
</script>

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
    var table = document.getElementById('tablaStudent');
    var data = Array.from(table.rows).slice(1).map(function(row) {
      return {
        'TIPO DOC': row.cells[0].textContent,
        'N� DOC': row.cells[1].textContent,
        'TURNO': row.cells[2].textContent,
        'NOMBRE': row.cells[3].textContent,
        'APELLIDO': row.cells[4].textContent,
        'NACIMIENTO': row.cells[5].textContent,
        'SECCION': row.cells[6].textContent,
        'GRADO': row.cells[7].textContent,
        'EMAIL': row.cells[8].textContent,
        'TELEFONO DEL APODERADO': row.cells[9].textContent,
        'UBIGEO': row.cells[10].textContent,
      };
    });

    var filename = 'Listado_Student_Inactivos.xlsx';
    var sheetname = 'Hoja 1';
    exportToExcel(data, filename, sheetname);
  });
				</script>

				<script>
  // Obt�n una referencia al bot�n Descargar PDF
  const botonDescargarPDF = document.getElementById('descargarPDF');

  // Agrega el evento click al bot�n Descargar PDF
  botonDescargarPDF.addEventListener('click', () => {
    const tablaEstudiantes = document.getElementById('tablaStudent');

    // Configura las opciones de html2pdf
    const options = {
      filename: 'Listado_Student_Inactivos.pdf',
      image: { type: 'jpeg', quality: 0.98 },
      html2canvas: { scale: 2 },
      jsPDF: { unit: 'pt', format: 'a4', orientation: 'landscape' },
    };

    // Crea el documento PDF con html2pdf
    html2pdf().set(options).from(tablaEstudiantes).save();
  });
</script>
</body>
</html>