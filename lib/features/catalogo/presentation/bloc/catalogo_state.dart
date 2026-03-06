import 'package:equatable/equatable.dart';
import '../../domain/entities/producto.dart';

/// Estados del BLoC de catálogo.
/// Representan los diferentes estados de la UI relacionados con el catálogo.
abstract class CatalogoState extends Equatable {
  const CatalogoState();

  @override
  List<Object> get props => [];
}

/// Estado inicial del catálogo.
class CatalogoInitial extends CatalogoState {}

/// Estado de carga del catálogo.
class CatalogoLoading extends CatalogoState {}

/// Estado cuando el catálogo se carga exitosamente.
class CatalogoLoaded extends CatalogoState {
  final List<Producto> productos;

  const CatalogoLoaded(this.productos);

  @override
  List<Object> get props => [productos];
}

/// Estado de error al cargar el catálogo.
class CatalogoError extends CatalogoState {
  final String mensaje;

  const CatalogoError(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}
