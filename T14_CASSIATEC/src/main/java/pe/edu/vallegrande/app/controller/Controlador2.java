package pe.edu.vallegrande.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.util.SystemOutLogger;

import pe.edu.vallegrande.app.modelo.Attendance;
import pe.edu.vallegrande.app.modelo.student;
import pe.edu.vallegrande.app.service.AttendanceDao;
import pe.edu.vallegrande.app.service.studentDao;

/**
 * Servlet implementation class Controlador
 */
@WebServlet("/Controlador2")
public class Controlador2 extends HttpServlet {

	studentDao dao = new studentDao();
	student s = new student();
	student st = new student();

	AttendanceDao daoAsis = new AttendanceDao();
	Attendance asis = new Attendance();

	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Controlador2() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String accion = request.getParameter("accion");
		switch (accion) {
		case "listar":
			List<student> datos = dao.listar();
			request.setAttribute("datos", datos);
			request.getRequestDispatcher("crudCompletoStudent.jsp").forward(request, response);
			break;
		case "ListarDNIoCNE":
			String documentNumber = request.getParameter("txtDocumentNumber");
			studentDao studentDao = new studentDao();
			student student = studentDao.listarDNIoCNE(documentNumber);
			request.setAttribute("student", student);
			request.getRequestDispatcher("ResultadoVerDocStudent.jsp").forward(request, response);
			break;

		case "ListarNOMBREyAPELLIDO":
			String names = request.getParameter("txtNames");
			String lastNames = request.getParameter("txtLast_names");

			if (names.isEmpty() && lastNames.isEmpty()) {
				// Los dos campos están vacíos, establecer mensaje de error en variable
				String errorMessage = "No se aceptan campos vacíos para la búsqueda";
				request.setAttribute("errorMessage", errorMessage);
			} else {
				List<student> studentListNOMAPE = dao.listarNOMyAPE(names, lastNames);
				System.out.println("Cantidad de personas encontradas: " + studentListNOMAPE.size());
				request.setAttribute("studentList", studentListNOMAPE);
			}
			request.getRequestDispatcher("MostrarNombreApellidoStudent.jsp").forward(request, response);
			break;

		case "ListarNOMBREyAPELLIDOeliminados":
			String names1 = request.getParameter("txtNames");
			String lastNames1 = request.getParameter("txtLast_names");

			if (names1.isEmpty() && lastNames1.isEmpty()) {
				// Los dos campos están vacíos, establecer mensaje de error en variable
				String errorMessage = "No se aceptan campos vacíos para la búsqueda";
				request.setAttribute("errorMessage", errorMessage);
			} else {
				List<student> studentListNOMAPE = dao.listarNOMyAPEinactivos(names1, lastNames1);
				System.out.println("Cantidad de personas encontradas: " + studentListNOMAPE.size());
				request.setAttribute("studentList", studentListNOMAPE);
			}
			request.getRequestDispatcher("MostrarNombreApellidoeliminadosStudent.jsp").forward(request, response);
			break;
		case "ListarEliminados":
			List<student> datos1 = dao.listarInactivos();
			request.setAttribute("datos", datos1);
			request.getRequestDispatcher("listarELIMINADOSstudent.jsp").forward(request, response);
			break;
		case "Guardar":
			String id = request.getParameter("txtid");
			String Document_type = request.getParameter("txtDocument_type");
			String Document_number = request.getParameter("txtDocument_number");
			String Status = request.getParameter("txtStatus");
			String Turn = request.getParameter("txtTurn");
			String Names = request.getParameter("txtNames");
			String Last_names = request.getParameter("txtLast_names");
			String Birthdate = request.getParameter("txtBirthdate");
			String Section = request.getParameter("txtSection");
			String Grade = request.getParameter("txtGrade");
			String Email = request.getParameter("txtEmail");
			String Phone_proxy = request.getParameter("txtPhone");
			String Code_ubigeo = request.getParameter("txtCode_ubigeo");
			s.setId(id);
			s.setDocument_type(Document_type);
			s.setDocument_number(Document_number);
			s.setStatus(Status);
			s.setTurn(Turn);
			s.setNames(Names);
			s.setLast_names(Last_names);
			s.setBirthdate(Birthdate);
			s.setSection(Section);
			s.setGrade(Grade);
			s.setEmail(Email);
			s.setPhone_proxy(Phone_proxy);
			s.setCode_ubigeo(Code_ubigeo);

			// Realizar la inserción en la base de datos
			int resultadoInsercion = dao.agregar(s);

			// Verificar el resultado de la inserción
			boolean insercionExitosa = (resultadoInsercion > 0);
			String mensajeResultado;

			if (insercionExitosa) {
				mensajeResultado = "Se ha agregado una estudiante nuevo con exito";
			} else {
				mensajeResultado = "No se pudo agregar al estudiante. Por favor, verifique sus datos sean unicos y no dejar campos vacios";
			}

			// Guardar el resultado en una variable
			request.setAttribute("mensajeResultado", mensajeResultado);

			request.getRequestDispatcher("AgregarStudent.jsp").forward(request, response);
			break;
		case "Editar":
			String ide = request.getParameter("id");
			student s = dao.listarID(ide);
			request.setAttribute("student", s);
			request.getRequestDispatcher("EditarStudent.jsp").forward(request, response);
			break;
		case "Actualizar":
			String id1 = request.getParameter("txtid");
			String Document_type1 = request.getParameter("txtDocument_type");
			String Document_number1 = request.getParameter("txtDocument_number");
			String Role1 = request.getParameter("txtRole");
			String Status1 = request.getParameter("txtStatus");
			String Turn1 = request.getParameter("txtTurn");
			String Names1 = request.getParameter("txtNames");
			String Last_names1 = request.getParameter("txtLast_names");
			String Birthdate1 = request.getParameter("txtBirthdate");
			String Section1 = request.getParameter("txtSection");
			String Grade1 = request.getParameter("txtGrade");
			String Email1 = request.getParameter("txtEmail");
			String Phone_proxy1 = request.getParameter("txtPhone");
			String Code_ubigeo1 = request.getParameter("txtCode_ubigeo");
			st.setId(id1);
			st.setDocument_type(Document_type1);
			st.setDocument_number(Document_number1);
			st.setRole(Role1);
			st.setStatus(Status1);
			st.setTurn(Turn1);
			st.setNames(Names1);
			st.setLast_names(Last_names1);
			st.setBirthdate(Birthdate1);
			st.setSection(Section1);
			st.setGrade(Grade1);
			st.setEmail(Email1);
			st.setPhone_proxy(Phone_proxy1);
			st.setCode_ubigeo(Code_ubigeo1);
			dao.actualizar(st);
			// Realizar la actualización en la base de datos
			int resultadoActualizacion = dao.actualizar(st);

			// Verificar el resultado de la actualización
			if (resultadoActualizacion > 0) {
				// La actualización fue exitosa
				String mensajeResultadoActualizacion = "Se ha actualizado el person con éxito";
				request.setAttribute("Actualizar", true);
				request.setAttribute("mensajeResultadoActualizacion", mensajeResultadoActualizacion);
				request.getRequestDispatcher("Controlador2?accion=listar").forward(request, response);
			} else {
				// La actualización no fue exitosa
				String mensajeResultadoActualizacion = "No se pudo actualizar el person. Por favor, verifique que los datos sean únicos y no deje campos vacíos";

				// Guardar el resultado y el objeto pe en variables de solicitud
				request.setAttribute("Actualizar", false);
				request.setAttribute("mensajeResultadoActualizacion", mensajeResultadoActualizacion);
				request.setAttribute("st", st);

				// Redireccionar a la acción "Editar" con los datos del objeto pe
				request.getRequestDispatcher("Controlador2?accion=Editar&id=" + id1).forward(request, response);
			}
			break;
		case "Delete":
			String id2 = request.getParameter("id");
			dao.deleteLogico(id2);
			request.setAttribute("eliminado", true);
			request.getRequestDispatcher("Controlador2?accion=listar").forward(request, response);
			break;
		case "Reactivar":
			String id3 = request.getParameter("id");
			dao.activacionLogico(id3);
			request.setAttribute("reactivado", true);
			request.getRequestDispatcher("Controlador2?accion=listar").forward(request, response);
			break;
		case "EliminadoFisico":
			String id4 = request.getParameter("id");
			dao.delete(id4);
			request.getRequestDispatcher("Controlador2?accion=ListarEliminados").forward(request, response);
			break;
		case "DeleteDOC":
			String id5 = request.getParameter("id");
			dao.deleteLogico(id5);
			request.setAttribute("eliminado", true);
			request.getRequestDispatcher("Controlador2?accion=ListarEliminados").forward(request, response);
			break;
		case "BuscarAula":
			String grado = request.getParameter("txtGrade");
			String seccion = request.getParameter("txtSection");
			String turno = request.getParameter("txtTurn");
			List<student> students = dao.listarPorTurnoSeccionGrado(turno, seccion, grado);
			request.setAttribute("students", students);
			request.getRequestDispatcher("RegistrarAsistenciaResultados.jsp").forward(request, response);
			break;
		case "GuardarAsistencia":
			AttendanceDao attendanceDao = new AttendanceDao();
			List<Attendance> attendanceList = new ArrayList<>();

			// Obtener los parámetros del formulario
			Enumeration<String> parameterNames = request.getParameterNames();
			while (parameterNames.hasMoreElements()) {
				String paramName = parameterNames.nextElement();
				if (paramName.startsWith("attendanceStatus")) {
					String studentId = paramName.replace("attendanceStatus_", "");
					String attendanceStatus = request.getParameter(paramName);
					String attendanceOcurrencia = request.getParameter("attendanceOcurrencia_" + studentId); // Obtener
																												// la
																												// ocurrencia

					Attendance attendance = new Attendance();
					attendance.setStudentId(studentId);
					attendance.setAttendanceStatus(attendanceStatus);
					attendance.setAttendance_ocurrencia(attendanceOcurrencia); // Establecer la ocurrencia
					attendanceList.add(attendance);
				}
			}

			int result = attendanceDao.guardarAsistenciaGrupal(attendanceList);

			if (result == 1) {
				request.setAttribute("mensaje", "Asistencia guardada exitosamente");
			} else {
				request.setAttribute("mensaje", "Error al guardar la asistencia");
			}

			// Redireccionar a la página de resultados o a donde desees mostrar el mensaje
			request.getRequestDispatcher("RegistrarAsistenciaResultados.jsp").forward(request, response);
			break;
		case "GenerarReporte":
			String studentIdReporte = request.getParameter("studentId");

			System.out.println("ID del estudiante: " + studentIdReporte); // Agrega esta línea para verificar el ID

			AttendanceDao attendanceDaoReporte = new AttendanceDao();
			List<Attendance> reporteReporte = attendanceDaoReporte.obtenerReporteIndividual(studentIdReporte);

			System.out.println("Reporte individual del estudiante " + studentIdReporte + ":"); // Agrega esta línea para
																						// verificar el reporte
			for (Attendance attendance : reporteReporte) {
				System.out.println("Id Reporte: " + attendance.getIdAttendance());
				System.out.println("Id del estudiante: " + attendance.getStudentId());
				System.out.println("Fecha: " + attendance.getAttendanceDateTime());
				System.out.println("Estado: " + attendance.getAttendanceStatusDB());
				System.out.println("Ocurrencia: " + attendance.getAttendance_ocurrencia());
				System.out.println("------------------------");
			}

			request.setAttribute("reporte", reporteReporte);
			request.getRequestDispatcher("ReporteIndividual.jsp").forward(request, response);
			break;
		case "GenerarReporteFiltroFecha":
			String studentIdReporteFiltroFecha = request.getParameter("studentId");
			String FechaInicio = request.getParameter("txtFechaInicio");
			String FechaFin = request.getParameter("txtFechaFin");

			System.out.println("ID del estudiante: " + studentIdReporteFiltroFecha); // Agrega esta línea para verificar el ID
			System.out.println("FechaInicio: " + FechaInicio);
			System.out.println("FechaFin: " + FechaFin);

			AttendanceDao attendanceDaoReporteFiltroFecha = new AttendanceDao();
			List<Attendance> reporteFiltroFecha = attendanceDaoReporteFiltroFecha.obtenerReportePorFechas(studentIdReporteFiltroFecha, FechaInicio, FechaFin);

			System.out.println("Reporte individual del estudiante " + studentIdReporteFiltroFecha + ":"); // Agrega esta línea para
																						// verificar el reporte
			for (Attendance attendance : reporteFiltroFecha) {
				System.out.println("Id Reporte: " + attendance.getIdAttendance());
				System.out.println("Id del estudiante: " + attendance.getStudentId());
				System.out.println("Fecha: " + attendance.getAttendanceDateTime());
				System.out.println("Estado: " + attendance.getAttendanceStatusDB());
				System.out.println("Ocurrencia: " + attendance.getAttendance_ocurrencia());
				System.out.println("------------------------");
			}

			request.setAttribute("reporte", reporteFiltroFecha);
			request.getRequestDispatcher("ReporteIndividualFiltradoFecha.jsp").forward(request, response);
			break;
		case "VerReportesCompleto":
			String studentIdReportesCompleto = request.getParameter("studentId");

			System.out.println("ID del estudiante: " + studentIdReportesCompleto); // Agrega esta línea para verificar el ID

			AttendanceDao attendanceDaoReportesCompleto = new AttendanceDao();
			List<Attendance> reporteReportesCompleto = attendanceDaoReportesCompleto.obtenerReporteIndividual(studentIdReportesCompleto);

			System.out.println("Reporte individual del estudiante " + reporteReportesCompleto + ":"); // Agrega esta línea para
																						// verificar el reporte
			for (Attendance attendance : reporteReportesCompleto) {
				System.out.println("Id Reporte: " + attendance.getIdAttendance());
				System.out.println("Id del estudiante: " + attendance.getStudentId());
				System.out.println("Fecha: " + attendance.getAttendanceDateTime());
				System.out.println("Estado: " + attendance.getAttendanceStatusDB());
				System.out.println("Ocurrencia: " + attendance.getAttendance_ocurrencia());
				System.out.println("------------------------");
			}

			request.setAttribute("reporte", reporteReportesCompleto);
			request.getRequestDispatcher("ReporteIndividual.jsp").forward(request, response);
			break;
		case "Edit":
			try {
				String ideEdit = request.getParameter("id_attendance");
				System.out.println("Edit Action - id_attendance: " + ideEdit);

				// Verificar si el ideEdit está llegando correctamente
				if (ideEdit != null && !ideEdit.isEmpty()) {
					Attendance a = daoAsis.listarID(ideEdit);
					System.out.println("Attendance Data: " + a);

					// Enviar los datos como respuesta JSON
					response.setContentType("application/json");
					response.setCharacterEncoding("UTF-8");
					response.getWriter().write(convertAttendanceToJson(a));
				} else {
					System.out.println("Error: id_attendance is null or empty");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			break;
		case "ActualizarAsistencia":
			String idattendance = request.getParameter("txtidAttendance");
			String StudentId = request.getParameter("txtstudentId");
			String AttendanceDateTime = request.getParameter("txtattendanceDateTime");
			String AttendanceStatus = request.getParameter("txtattendanceStatus");
			String AttendanceOcurrencia = request.getParameter("txtattendance_ocurrencia");
			
			String id6 = idattendance;
			System.out.println("id_attendance: " + id6);
			
			asis.setIdAttendance(idattendance);
			asis.setStudentId(StudentId);
			asis.setAttendanceDateTime(AttendanceDateTime);
			asis.setAttendanceStatus(AttendanceStatus);
			asis.setAttendance_ocurrencia(AttendanceOcurrencia);
			daoAsis.actualizar(asis);
			dao.actualizar(st);

			// Obtén nuevamente el reporte actualizado después de eliminar
			String studentId2 = StudentId;
			AttendanceDao attendanceDao3 = new AttendanceDao();
			List<Attendance> nuevoReporte = attendanceDao3.obtenerReporteIndividual(studentId2);

			// Agrega el nuevo reporte al atributo de la solicitud
			request.setAttribute("reporte", nuevoReporte);
			
			System.out.println("Se actualizo con exito");

			// Redirige a la misma página con el id del estudiante
			request.getRequestDispatcher("ReporteIndividual.jsp").forward(request, response);
			break;
		case "Eliminar":
			String idEliminar = request.getParameter("id_attendance");
			System.out.println("ID de asistencia a eliminar: " + idEliminar);
			daoAsis.delete(idEliminar);

			// Obtén nuevamente el reporte actualizado después de eliminar
			String studentIdEliminar = request.getParameter("id-actual-estudiante");
			AttendanceDao attendanceDaoEliminar = new AttendanceDao();
			List<Attendance> nuevoReporteEliminar = attendanceDaoEliminar.obtenerReporteIndividual(studentIdEliminar);

			// Agrega el nuevo reporte al atributo de la solicitud
			request.setAttribute("reporte", nuevoReporteEliminar);

			// Redirige a la misma página con el id del estudiante
			request.getRequestDispatcher("ReporteIndividual.jsp").forward(request, response);
			break;
		case "BuscarOtraAula":
			request.getRequestDispatcher("RegistrarAsistenciaResultados.jsp").forward(request, response);
			break;

		default:
			throw new AssertionError();
		}

	}

	private String convertAttendanceToJson(Attendance attendance) {
		// Convertir el objeto Attendance a formato JSON
		// Implementa la lógica de conversión a JSON según tus necesidades
		// Puedes utilizar librerías como Gson o Jackson para esto
		// Aquí, se muestra un ejemplo simple sin usar librerías externas
		return "{" + "\"idAttendance\": " + attendance.getIdAttendance() + "," + "\"studentId\": "
				+ attendance.getStudentId() + "," + "\"attendanceDateTime\": \"" + attendance.getAttendanceDateTime()
				+ "\"," + "\"attendanceStatus\": \"" + attendance.getAttendanceStatus() + "\","
				+ "\"attendance_ocurrencia\": \"" + attendance.getAttendance_ocurrencia() + "\"" + "}";
	}

}
