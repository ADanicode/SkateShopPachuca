import 'package:equatable/equatable.dart';
import '../../../domain/entities/empleado.dart';

/// Estados para el BLoC de usuarios.
///
/// Representa los diferentes estados en los que puede estar la gestión de usuarios.
abstract class UsuariosState extends Equatable {
  const UsuariosState();

  @override
  List<Object> get props => [];
}

/// Estado inicial del BLoC de usuarios.
class UsuariosInitial extends UsuariosState {}

/// Estado de carga mientras se obtienen los usuarios.
class UsuariosLoading extends UsuariosState {}

/// Estado cuando los usuarios han sido cargados exitosamente.
///
/// [empleados] La lista de empleados obtenida.
class UsuariosLoaded extends UsuariosState {
  final List<Empleado> empleados;

  const UsuariosLoaded(this.empleados);

  @override
  List<Object> get props => [empleados];
}

/// Estado de error cuando ocurre un problema.
///
/// [message] El mensaje de error.
class UsuariosError extends UsuariosState {
  final String message;

  const UsuariosError(this.message);

  @override
  List<Object> get props => [message];
}
