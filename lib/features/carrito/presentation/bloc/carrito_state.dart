import '../../domain/entities/item_carrito.dart';

/// Estados para el BLoC del carrito de compras.
///
/// Representa los diferentes estados del carrito.
abstract class CarritoState {}

/// Estado que indica que el carrito ha sido actualizado.
///
/// Contiene la lista de items y calcula el total dinámicamente.
class CarritoActualizado extends CarritoState {
  /// Lista de items en el carrito.
  final List<ItemCarrito> items;

  /// Constructor del estado.
  CarritoActualizado(this.items);

  /// Calcula el total sumando precio * cantidad de cada item.
  double get total => items.fold(0, (sum, item) => sum + item.subtotal);
}
