	<!-- Modal -->
	<div id="modalPromocion" class="modal fade" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content modal-pink">
				<div class="modal-header">
					<h2 class="modal-title">Promoci�n</h2>
				</div>
				<div class="modal-body text-center">
					<h3>Compre el sistema ahora</h3>
					<h4>�Descuentos de locura!</h4>
				</div>
				<div class="modal-footer">
					<a href="mailto:jcanales@vallegrande.edu.pe"
						class="btn btn-success">Contactarme</a>
					<button type="button" class="btn btn-warning"
						data-bs-dismiss="modal" id="btnComprarMasTarde">Comprar
						m�s tarde</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
	<script>
		$(document).ready(
				function() {
					var modalPromocion = new bootstrap.Modal(document
							.getElementById('modalPromocion'));
					var timer;

					// Funci�n para mostrar el modal autom�ticamente cada 5 segundos
					function mostrarModalPromocion() {
						modalPromocion.show();
						timer = setTimeout(function() {
							modalPromocion.hide();
							setTimeout(mostrarModalPromocion, 5000);
						}, 5000);
					}

					// Mostrar el modal al cargar la p�gina
					mostrarModalPromocion();

					// Funci�n para cancelar el bucle por 30 minutos
					function cancelarBucle() {
						clearTimeout(timer);
						setTimeout(mostrarModalPromocion, 1800000); // 30 minutos en milisegundos
					}

					// Manejador de eventos para el bot�n "Comprar m�s tarde"
					$('#btnComprarMasTarde').click(function() {
						modalPromocion.hide();
						cancelarBucle();
					});
				});
	</script>