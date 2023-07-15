package pe.edu.vallegrande.app.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nimbusds.jose.shaded.json.JSONObject;

import pe.edu.vallegrande.app.service.QRCodeProcessor;

/**
 * Servlet implementation class ControladorQR
 */
@WebServlet("/ControladorQR")
public class ControladorQR extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControladorQR() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String qrCode = request.getParameter("qrCode");
	    System.out.println("Código QR recibido: " + qrCode);

	    // Procesar el código QR y guardar la asistencia en la base de datos
	    QRCodeProcessor qrCodeProcessor = new QRCodeProcessor();
	    boolean isRegistered = qrCodeProcessor.processQRCode(qrCode);

	    // Crear un objeto JSON con la información de respuesta
	    JSONObject jsonResponse = new JSONObject();
	    if (isRegistered) {
	        jsonResponse.put("success", false);
	        jsonResponse.put("message", "Este estudiante ya ha sido registrado hoy");
	    } else {
	        jsonResponse.put("success", true);
	        jsonResponse.put("message", "Asistencia guardada exitosamente");
	    }

	    // Enviar la respuesta al front-end
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    response.getWriter().write(jsonResponse.toString());

//		// Aquí puedes procesar el código QR y realizar la lógica correspondiente
//		QRCodeProcessor qrCodeProcessor = new QRCodeProcessor();
//		qrCodeProcessor.processQRCode(qrCode);
//
//		// Envia una respuesta al front-end
//		response.getWriter().write("Asistencia guardada exitosamente");
		
		
		
//		// Verificar si la acción es para leer el código QR
//		if (accion != null && accion.equals("LeerQR")) {
//			// Obtén el código QR del cuerpo de la solicitud
//			  BufferedReader reader = request.getReader();
//			  StringBuilder requestBody = new StringBuilder();
//			  String line;
//			  while ((line = reader.readLine()) != null) {
//			    requestBody.append(line);
//			  }
//			  String qrCode = requestBody.toString();
//
//			  System.out.println("Código QR recibido: " + qrCode);
//
//			  // Aquí puedes procesar el código QR y realizar la lógica correspondiente
//
//			  // Imprime los datos del código QR en la consola de Eclipse
//			  System.out.println("Datos del código QR: " + qrCode);
//
//			  // Envia una respuesta al front-end
//			  response.getWriter().write("Asistencia guardada exitosamente");
//		} else {
//			// Otros casos del controlador
		
	}

}
