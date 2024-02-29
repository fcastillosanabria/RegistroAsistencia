package pe.edu.vallegrande.app.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import pe.edu.vallegrande.app.db.Conexion;
import pe.edu.vallegrande.app.modelo.Attendance;
import pe.edu.vallegrande.app.modelo.person;

public class AttendanceDao {

	PreparedStatement ps;
	ResultSet rs;
	Conexion c = new Conexion();
	Connection con;

	// Este codigo es para hacer la prueba en consola
	public int guardarAsistenciaGrupal(List<Attendance> listaAttendances) {
		int r = 0;
		String sql = "INSERT INTO registro_asistencia (id_estudent, attendance_status, attendance_ocurrencia) VALUES (?, ?, ?)";
		try {
			con = c.conectar();
			con.setAutoCommit(false); // Desactivar la confirmación automática

			ps = con.prepareStatement(sql);

			for (Attendance a : listaAttendances) {
				ps.setString(1, a.getStudentId());
				ps.setString(2, a.getAttendanceStatus());
				ps.setString(3, a.getAttendance_ocurrencia());
				ps.addBatch(); // Agregar el registro a la ejecución en lote
			}

			int[] results = ps.executeBatch(); // Ejecutar la inserción en lote

			for (int result : results) {
				if (result == 1) {
					r++; // Incrementar el contador de registros insertados exitosamente
				}
			}

			con.commit(); // Confirmar la transacción

			if (r == listaAttendances.size()) {
				r = 1;
			} else {
				r = 0;
			}
		} catch (SQLException e) {
			try {
				con.rollback(); // Deshacer la transacción en caso de error
			} catch (SQLException ex) {
				System.out.println("Error al deshacer la transacción: " + ex.getMessage());
			}
			System.out.println("Error al insertar: " + e.getMessage());
		} finally {
			try {
				con.setAutoCommit(true); // Reactivar la confirmación automática
				if (ps != null) {
					ps.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (SQLException e) {
				System.out.println("Error al cerrar la conexión: " + e.getMessage());
			}
		}
		return r;
	}

	// listar reporte individual
	public List<Attendance> obtenerReporteIndividual(String studentId) {
		List<Attendance> reporte = new ArrayList<>();
		String sql = "SELECT id_attendance, id_estudent, attendance_datetime, attendance_status, attendance_ocurrencia FROM registro_asistencia WHERE id_estudent = ?";

		try {
			con = c.conectar();
			ps = con.prepareStatement(sql);
			ps.setString(1, studentId);
			rs = ps.executeQuery();

			while (rs.next()) {
				Attendance attendance = new Attendance();
				attendance.setIdAttendance(rs.getString("id_attendance"));
				attendance.setStudentId(rs.getString("id_estudent"));
				attendance.setAttendanceDateTime(rs.getString("attendance_datetime"));
				attendance.setAttendanceStatus(rs.getString("attendance_status"));
				attendance.setAttendance_ocurrencia(rs.getString("attendance_ocurrencia"));
				reporte.add(attendance);
			}
		} catch (SQLException e) {
			System.out.println("Error al obtener el reporte individual: " + e.getMessage());
		}

		return reporte;
	}

	// listar un reporte por id para la actualizacion
	public Attendance listarID(String idAttendance) {
		String sql = "select * from registro_asistencia where id_attendance=" + idAttendance;
		Attendance a= new Attendance();
		try {
			con = c.conectar();
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				a.setIdAttendance(rs.getString(1));
				a.setStudentId(rs.getString(2));
				a.setAttendanceDateTime(rs.getString(3));
				a.setAttendanceStatus(rs.getString(4));
				a.setAttendance_ocurrencia(rs.getString(5));
			}
		} catch (Exception e) {
		}
		return a;
	}
	
	//listar por fechas
	public List<Attendance> obtenerReportePorFechas(String studentId, String fechaInicio, String fechaFin) {
	    List<Attendance> reporte = new ArrayList<>();
	    String sql = "SELECT id_attendance, id_estudent, attendance_datetime, attendance_status, attendance_ocurrencia " +
	                 "FROM registro_asistencia " +
	                 "WHERE id_estudent = ? AND attendance_datetime BETWEEN ? AND ?";

	    try {
	        con = c.conectar();
	        ps = con.prepareStatement(sql);
	        ps.setString(1, studentId);
	        ps.setString(2, fechaInicio + " 00:00:00"); // Agregar la hora de inicio del día
	        ps.setString(3, fechaFin + " 23:59:59");   // Agregar la hora de fin del día
	        rs = ps.executeQuery();

	        while (rs.next()) {
	            Attendance attendance = new Attendance();
	            attendance.setIdAttendance(rs.getString("id_attendance"));
	            attendance.setStudentId(rs.getString("id_estudent"));
	            attendance.setAttendanceDateTime(rs.getString("attendance_datetime"));
	            attendance.setAttendanceStatus(rs.getString("attendance_status"));
	            attendance.setAttendance_ocurrencia(rs.getString("attendance_ocurrencia"));
	            reporte.add(attendance);
	        }
	    } catch (SQLException e) {
	        System.out.println("Error al obtener el reporte por fechas: " + e.getMessage());
	    }

	    return reporte;
	}

	// actualizar reporte
	public int actualizar(Attendance a) {
		int r = 0;
		String sql = "update registro_asistencia set id_estudent=?, attendance_datetime=?, attendance_status=?, attendance_ocurrencia=? where id_attendance=?";
		try {
			con = c.conectar();
			ps = con.prepareStatement(sql);
			ps.setString(1, a.getStudentId());
			ps.setString(2, a.getAttendanceDateTime());
			ps.setString(3, a.getAttendanceStatus());
			ps.setString(4, a.getAttendance_ocurrencia());
			ps.setString(5, a.getIdAttendance());
			r = ps.executeUpdate();
			if (r == 1) {
				r = 1;
			} else {
				r = 0;
			}
		} catch (Exception e) {
			System.out.println("Error al actualizar: " + e.getMessage());
		}
		return r;
	}

	// eliminar reporte
	// Eliminado fisico
	public void delete(String idAttendance) {
		String sql = "delete from registro_asistencia where id_attendance=" + idAttendance;
		try {
			con = c.conectar();
			ps = con.prepareStatement(sql);
			ps.executeUpdate();
		} catch (Exception e) {
		}
	}
}
