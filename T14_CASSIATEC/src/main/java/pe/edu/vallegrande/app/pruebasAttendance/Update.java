package pe.edu.vallegrande.app.pruebasAttendance;

import pe.edu.vallegrande.app.modelo.Attendance;
import pe.edu.vallegrande.app.service.AttendanceDao;

public class Update {

	public static void main(String[] args) {
		AttendanceDao dao = new AttendanceDao(); // Crear una instancia de la clase AttendanceDao

		// Crear una instancia de la clase Attendance con los datos a actualizar
		Attendance a = new Attendance();
		a.setStudentId("7");
		a.setAttendanceDateTime("2023-12-15 00:17:40.197");
		a.setAttendanceStatus("F");
		a.setAttendance_ocurrencia("Esta hospitalizado");
		a.setIdAttendance("28"); // ID a actualizar

		try {
			dao.actualizar(a);
			System.out.println("La asistencia se actualizó exitosamente.");
		} catch (Exception e) {
			System.out.println("Error al actualizar el registro: " + e.getMessage());
		}
	}
}
