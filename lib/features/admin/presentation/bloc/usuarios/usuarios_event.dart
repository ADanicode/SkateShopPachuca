import 'package:equatable/equatable.dart';
import '../../../domain/entities/empleado.dart';

/// Eventos para el BLoC de usuarios.
///
/// Define las acciones que pueden ser realizadas en la gestión de usuarios.
abstract class UsuariosEvent extends Equatable {
  const UsuariosEvent();

  @override
  List<Object> get props => [];
}

/// Evento para cargar la lista de usuarios.
class LoadUsuarios extends UsuariosEvent {}

/// Evento para agregar un nuevo usuario.
///
/// [empleado] El empleado a agregar al sistema.
class AddUsuario extends UsuariosEvent {
  final Empleado empleado;

  const AddUsuario(this.empleado);

  @override
  List<Object> get props => [empleado];
}
