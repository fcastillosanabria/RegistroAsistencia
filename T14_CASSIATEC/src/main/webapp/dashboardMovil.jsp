<div class="offcanvas offcanvas-start bg-danger min-vh-100 py-5 px-5" id="intro">

	<div class="row">
		<div class="col-4">
			<span id="currentDateTimeSmall" class="nav-link text-white"> <span
				id="currentTimeSmall" style="font-size: 34px;"></span>
			</span>
		</div>
		<div class="col-6"></div>
		<div class="col-2 text-end">
			<button class="animated-button" data-bs-toggle="offcanvas"
				data-bs-target="#intro">
				<img src="img\marca.png" alt="cerrar Dashboard">
			</button>
		</div>
	</div>




	<script>
		// Obtener el elemento para mostrar la hora y actualizarlo cada segundo
		var currentTimeSmallElement = document
				.getElementById("currentTimeSmall");

		// Función para obtener la hora actual en formato de 12 horas con AM/PM
		function getCurrentTime12HourFormat() {
			var currentDate = new Date();
			var hours = currentDate.getHours();
			var period = hours >= 12 ? "PM" : "AM";
			hours = hours % 12 || 12; // Convertir a formato de 12 horas
			var minutes = currentDate.getMinutes().toString().padStart(2, "0");
			var seconds = currentDate.getSeconds().toString().padStart(2, "0");
			return hours + ":" + minutes + ":" + seconds + " " + period;
		}

		// Actualizar la hora cada segundo
		function updateCurrentTime12HourFormat() {
			var currentTime = getCurrentTime12HourFormat();
			currentTimeSmallElement.textContent = currentTime;
		}

		// Actualizar la hora inicial y luego actualiza la hora cada segundo
		updateCurrentTime12HourFormat();
		setInterval(updateCurrentTime12HourFormat, 1000);
	</script>



	<a href="HOME.jsp"
		class="d-flex text-decoration-none mt-1 align-items-center justify-content-center text-white">
		<img src="img\Insignia SRC.png" alt="Logo CASSIATEC"
		class="logo-img animated-img" style="height: 17rem">
	</a>
	<ul class="nav nav-pills flex-column mt-4">
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="HOME.jsp" class="nav-link text-white text-center active"> <span
				class="fs-4 ms-3 d-none d-sm-inline">HOME</span>
		</a></li>
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="ActualizarMisDatos.jsp" class="nav-link text-white text-center">
				<span class="fs-4 ms-3 d-none d-sm-inline">ACTUALIZAR MIS
					DATOS</span>
		</a></li>
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="RegistrarAsistencia.jsp"
			class="nav-link text-white text-center"> <span
				class="fs-4 ms-3 d-none d-sm-inline">REGISTRAR ASISTENCIA</span>
		</a></li>
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="AgregarStudent.jsp" class="nav-link text-white text-center">
				<span class="fs-4 ms-3 d-none d-sm-inline">AGREGAR ESTUDIANTE</span>
		</a></li>
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="AgregarPerson.jsp" class="nav-link text-white text-center">
				<span class="fs-4 ms-3 d-none d-sm-inline">AGREGAR PERSON</span>
		</a></li>
		<li class="nav-item py-2 py-sm-0 align-items-center"><a
			href="ActualizarEstudiante.jsp"
			class="nav-link text-white text-center"> <span
				class="fs-4 ms-3 d-none d-sm-inline">ACTUALIZAR ESTUDIANTE</span>

		</a></li>
	</ul>

	<hr class="thicker-hr">
	<div class="dropdown">
		<a href="#"
			class="d-flex align-items-center text-white text-decoration-none dropdown-toggle"
			id="dropdownUser1" data-bs-toggle="dropdown" aria-expanded="false">
			<img src="img/iconoUSUARIO.png" alt="" width="32" height="32"
			class="rounded-circle me-2"> <strong>Cerrar sesión</strong>
		</a>
		<ul class="dropdown-menu dropdown-menu-dark text-small shadow bg-dark"
			aria-labelledby="dropdownUser1" style="">
			<li><a class="dropdown-item" href="#">New project...</a></li>
			<li><a class="dropdown-item" href="#">Ajustes</a></li>
			<li><a class="dropdown-item" href="#">Perfil</a></li>
			<li><hr class="dropdown-divider"></li>
			<li><a class="dropdown-item" data-bs-toggle="modal"
				data-bs-target="#confirmLogoutModal">Cerrar sesión</a></li>
		</ul>
	</div>

</div>