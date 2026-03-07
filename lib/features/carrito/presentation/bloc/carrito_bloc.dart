import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/item_carrito.dart';
import 'carrito_event.dart';
import 'carrito_state.dart';

/// BLoC para manejar la lógica del carrito de compras.
///
/// Gestiona la lista de items en el carrito y calcula el total.
class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  /// Lista interna de items en el carrito.
  final List<ItemCarrito> _items = [];

  /// Constructor del BLoC.
  CarritoBloc() : super(CarritoActualizado([])) {
    on<AgregarProducto>(_onAgregarProducto);
    on<EliminarProducto>(_onEliminarProducto);
  }

  /// Manejador del evento AgregarProducto.
  void _onAgregarProducto(AgregarProducto event, Emitter<CarritoState> emit) {
    // Asumiendo que event.producto es Producto
    final producto = event.producto;
    final existingIndex = _items.indexWhere(
      (item) => item.producto.id == producto.id,
    );
    if (existingIndex != -1) {
      // Incrementa cantidad si ya existe
      final existingItem = _items[existingIndex];
      _items[existingIndex] = ItemCarrito(
        producto: existingItem.producto,
        cantidad: existingItem.cantidad + 1,
      );
    } else {
      // Agrega nuevo item
      _items.add(ItemCarrito(producto: producto, cantidad: 1));
    }
    emit(CarritoActualizado(List.from(_items)));
  }

  /// Manejador del evento EliminarProducto.
  void _onEliminarProducto(EliminarProducto event, Emitter<CarritoState> emit) {
    final producto = event.producto;
    _items.removeWhere((item) => item.producto.id == producto.id);
    emit(CarritoActualizado(List.from(_items)));
  }
}
