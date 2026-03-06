import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/producto_repository.dart';
import 'catalogo_event.dart';
import 'catalogo_state.dart';

/// BLoC para manejar la lógica de estado del catálogo.
/// Gestiona los eventos y emite estados correspondientes.
class CatalogoBloc extends Bloc<CatalogoEvent, CatalogoState> {
  final ProductoRepository productoRepository;

  CatalogoBloc(this.productoRepository) : super(CatalogoInitial()) {
    on<CargarCatalogo>(_onCargarCatalogo);
  }

  /// Maneja el evento CargarCatalogo.
  /// Llama al repositorio y emite los estados correspondientes.
  Future<void> _onCargarCatalogo(
    CargarCatalogo event,
    Emitter<CatalogoState> emit,
  ) async {
    emit(CatalogoLoading());
    try {
      final productos = await productoRepository.obtenerCatalogo();
      emit(CatalogoLoaded(productos));
    } catch (e) {
      emit(CatalogoError(e.toString()));
    }
  }
}
