package pe.edu.vallegrande.app.pruebasAttendance;

import pe.edu.vallegrande.app.modelo.Attendance;
import pe.edu.vallegrande.app.modelo.person;
import pe.edu.vallegrande.app.service.AttendanceDao;
import pe.edu.vallegrande.app.service.personDao;

public class ReadID {

	public static void main(String[] args) {
		try {
			AttendanceDao attendanceService = new AttendanceDao();
			Attendance a = attendanceService .listarID("28");
			// System.out.println(p); //Con este Código podemos imprimir todo en una fila.
			System.out.println("ID de la asistencia: " + a.getIdAttendance());
			System.out.println("ID del estudiante: " + a.getStudentId());
			System.out.println("Fecha de asistencia: " + a.getAttendanceDateTime());
			System.out.println("Estado de la asistencia: " + a.getAttendanceStatus());
			System.out.println("Ocurrencia: " + a.getAttendance_ocurrencia());
			System.out.println("--------------------------------");
		} catch (Exception e) {
			System.err.println(e.getMessage());
		}
	}

}
