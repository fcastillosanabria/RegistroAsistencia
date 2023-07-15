package pe.edu.vallegrande.app.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class QRCodeProcessor {

	private static final String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=CASSIATEC;encrypt=true;TrustServerCertificate=True;";
	private static final String DB_USER = "sa";
	private static final String DB_PASSWORD = "francisDE";

	public boolean  processQRCode(String qrCode) {
		// Extraer los datos del código QR
		String[] qrData = qrCode.split(", ");
		int studentId = Integer.parseInt(qrData[0]);
		String attendanceStatus = qrData[1];
		String attendanceOcurrencia = qrData[2];

		 // Verificar si el estudiante ya ha sido registrado para la fecha actual
        if (isStudentRegistered(studentId)) {
            System.out.println("Este estudiante ya ha sido registrado hoy.");
            return true; // Indicar que el estudiante está registrado
        }

        // Guardar los datos en la base de datos
        saveAttendanceData(studentId, attendanceStatus, attendanceOcurrencia);

        System.out.println("Datos de asistencia guardados exitosamente.");
        return false; // Indicar que el estudiante no estaba registrado previamente
	}

	private  boolean isStudentRegistered(int studentId) {
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

	private  void saveAttendanceData(int studentId, String attendanceStatus, String attendanceOcurrencia) {
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

}
