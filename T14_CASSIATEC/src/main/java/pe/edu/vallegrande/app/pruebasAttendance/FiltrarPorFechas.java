package pe.edu.vallegrande.app.pruebasAttendance;

import java.util.List;

import pe.edu.vallegrande.app.modelo.Attendance;
import pe.edu.vallegrande.app.service.AttendanceDao;

public class FiltrarPorFechas {

	public static void main(String[] args) {
		// Aquí puedes inicializar tu objeto DAO (Data Access Object) o cualquier objeto que contenga el método obtenerReportePorFechas.
        AttendanceDao attendanceDao = new AttendanceDao(); // Reemplaza TuClaseDAO con el nombre real de tu clase.

        // Especifica el ID del estudiante y el rango de fechas que deseas filtrar.
        String studentId = "7";
        String fechaInicio = "2023-12-15";
        String fechaFin = "2023-12-20";

        // Llama al método para obtener el reporte por fechas.
        List<Attendance> reporte = attendanceDao.obtenerReportePorFechas(studentId, fechaInicio, fechaFin);

        // Imprime los resultados.
        System.out.println("Reporte de asistencia para el estudiante " + studentId + " en el rango de fechas " + fechaInicio + " a " + fechaFin + ":");
        for (Attendance attendance : reporte) {
            System.out.println("ID de Asistencia: " + attendance.getIdAttendance());
            System.out.println("ID de Asistencia: " + attendance.getStudentId());
            System.out.println("Fecha y Hora: " + attendance.getAttendanceDateTime());
            System.out.println("Estado de Asistencia: " + attendance.getAttendanceStatus());
            System.out.println("Ocurrencia de Asistencia: " + attendance.getAttendance_ocurrencia());
            System.out.println("------");
        }
	}

}
