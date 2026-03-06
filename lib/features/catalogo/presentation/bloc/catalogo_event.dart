import 'package:equatable/equatable.dart';

/// Eventos del BLoC de catálogo.
/// Define las acciones que pueden disparar cambios de estado.
abstract class CatalogoEvent extends Equatable {
  const CatalogoEvent();

  @override
  List<Object> get props => [];
}

/// Evento para cargar el catálogo de productos.
class CargarCatalogo extends CatalogoEvent {}
