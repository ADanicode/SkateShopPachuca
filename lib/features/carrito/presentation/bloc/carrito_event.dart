/// Eventos para el BLoC del carrito de compras.
///
/// Define los eventos que pueden ocurrir en la gestión del carrito.
abstract class CarritoEvent {}

/// Evento para agregar un producto al carrito.
class AgregarProducto extends CarritoEvent {
  /// Producto a agregar.
  final dynamic producto; // Asumiendo Producto, pero para evitar import aquí

  /// Constructor del evento.
  AgregarProducto(this.producto);
}

/// Evento para eliminar un producto del carrito.
class EliminarProducto extends CarritoEvent {
  /// Producto a eliminar.
  final dynamic producto;

  /// Constructor del evento.
  EliminarProducto(this.producto);
}
