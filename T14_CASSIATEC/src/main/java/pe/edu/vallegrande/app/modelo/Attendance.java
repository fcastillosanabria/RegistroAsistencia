package pe.edu.vallegrande.app.modelo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Attendance {

	private String idAttendance;
    private String studentId;
    private String attendanceDateTime;
    private String attendanceStatus;
    private String attendance_ocurrencia;
	
    public Attendance() {
		// TODO Auto-generated constructor stub
	}

	public Attendance(String idAttendance, String studentId, String attendanceDateTime, String attendanceStatus,
			String attendance_ocurrencia) {
		super();
		this.idAttendance = idAttendance;
		this.studentId = studentId;
		this.attendanceDateTime = attendanceDateTime;
		this.attendanceStatus = attendanceStatus;
		this.attendance_ocurrencia = attendance_ocurrencia;
	}

	public String getIdAttendance() {
		return idAttendance;
	}

	public void setIdAttendance(String idAttendance) {
		this.idAttendance = idAttendance;
	}

	public String getStudentId() {
		return studentId;
	}

	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}

	public String getAttendanceDateTime() {
		return attendanceDateTime;
	}

	public void setAttendanceDateTime(String attendanceDateTime) {
		this.attendanceDateTime = attendanceDateTime;
	}

	public String getAttendanceStatus() {
		return attendanceStatus;
	}

	public void setAttendanceStatus(String attendanceStatus) {
		this.attendanceStatus = attendanceStatus;
	}

	public String getAttendance_ocurrencia() {
		return attendance_ocurrencia;
	}

	public void setAttendance_ocurrencia(String attendance_ocurrencia) {
		this.attendance_ocurrencia = attendance_ocurrencia;
	}

	@Override
	public String toString() {
		return "Attendance [idAttendance=" + idAttendance + ", studentId=" + studentId + ", attendanceDateTime="
				+ attendanceDateTime + ", attendanceStatus=" + attendanceStatus + ", attendance_ocurrencia="
				+ attendance_ocurrencia + "]";
	}
	
	public String getAttendanceDateTimeDB() {
		try {
			// Crear un objeto de tipo Date a partir de la cadena de fecha y hora
			SimpleDateFormat sourceFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			Date date = sourceFormat.parse(attendanceDateTime);

			// Formatear la fecha y hora en el formato deseado
			SimpleDateFormat targetFormat = new SimpleDateFormat("dd/MM/yyyy - h:mm:ss a");
			return targetFormat.format(date);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
    
	
	public String getAttendanceStatusDB() {
	    String attendanceStatus = this.getAttendanceStatus();
	    // Lógica para mapear los generos de ubigeo a las ciudades correspondientes
	    if (attendanceStatus.equals("A")) {
	      return "Asistió";
	    } else if (attendanceStatus.equals("F")) {
	      return "Faltó";
	    } else if (attendanceStatus.equals("J")) {
		      return "Justificó";
	    } else {
	      return "status Desconocida";
	    }
	  }
 
}
