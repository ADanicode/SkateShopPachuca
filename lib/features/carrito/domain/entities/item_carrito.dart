import '../../../catalogo/domain/entities/producto.dart';

/// Entidad que representa un item en el carrito de compras.
///
/// Contiene un producto y la cantidad seleccionada.
class ItemCarrito {
  /// Producto en el carrito.
  final Producto producto;

  /// Cantidad del producto.
  final int cantidad;

  /// Constructor de la entidad ItemCarrito.
  const ItemCarrito({required this.producto, required this.cantidad});

  /// Calcula el subtotal para este item (precio * cantidad).
  double get subtotal => producto.precio * cantidad;
}
