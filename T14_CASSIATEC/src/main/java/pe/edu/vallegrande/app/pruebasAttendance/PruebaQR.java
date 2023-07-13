package pe.edu.vallegrande.app.pruebasAttendance;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PruebaQR {

	private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=CASSIATEC;encrypt=true;TrustServerCertificate=True;";
	private static final String DB_USER = "sa";
	private static final String DB_PASSWORD = "francisDE";

	public static void processQRCode(String qrCode) {
		// Extraer los datos del código QR
		String[] qrData = qrCode.split(", ");
		int studentId = Integer.parseInt(qrData[0]);
		String attendanceStatus = qrData[1];
		String attendanceOcurrencia = qrData[2];

		// Verificar si el estudiante ya ha sido registrado para la fecha actual
		if (isStudentRegistered(studentId)) {
			System.out.println("Este estudiante ya ha sido registrado hoy.");
			return;
		}

		// Guardar los datos en la base de datos
		saveAttendanceData(studentId, attendanceStatus, attendanceOcurrencia);

		System.out.println("Datos de asistencia guardados exitosamente.");
	}

	private static boolean isStudentRegistered(int studentId) {
		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement statement = connection.prepareStatement(
						"SELECT * FROM registro_asistencia WHERE id_estudent = ? AND CAST(attendance_datetime AS DATE) = CAST(GETDATE() AS DATE)");) {
			statement.setInt(1, studentId);
			ResultSet resultSet = statement.executeQuery();
			return resultSet.next();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private static void saveAttendanceData(int studentId, String attendanceStatus, String attendanceOcurrencia) {
		try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement statement = connection.prepareStatement(
						"INSERT INTO registro_asistencia (id_estudent, attendance_datetime, attendance_status, attendance_ocurrencia) VALUES (?, GETDATE(), ?, ?)");) {
			statement.setInt(1, studentId);
			statement.setString(2, attendanceStatus);
			statement.setString(3, attendanceOcurrencia);
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// Simulación de lectura del código QR
		String qrCode = "6, A, He asistido con exito :)";

		// Procesar el código QR
		processQRCode(qrCode);
	}
	
}
