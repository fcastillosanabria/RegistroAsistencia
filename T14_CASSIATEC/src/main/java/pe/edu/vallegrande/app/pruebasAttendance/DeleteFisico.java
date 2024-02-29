package pe.edu.vallegrande.app.pruebasAttendance;

import pe.edu.vallegrande.app.service.AttendanceDao;

public class DeleteFisico {

	public static void main(String[] args) {
		String idToDelete = "35"; // ID del registro a eliminar

		AttendanceDao attendaceDAO = new AttendanceDao();

		try {
			attendaceDAO.delete(idToDelete);
			System.out.println("Registro de asistencia eliminado exitosamente.");
		} catch (Exception e) {
			System.out.println("Error al eliminar el registro: " + e.getMessage());
			e.printStackTrace();
		}
	}

}
