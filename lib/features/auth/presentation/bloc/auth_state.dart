import '../../domain/entities/usuario.dart';

/// Estados para el BLoC de autenticación.
///
/// Representa los diferentes estados en los que puede estar el proceso de autenticación.
abstract class AuthState {}

/// Estado inicial de la autenticación.
class AuthInitial extends AuthState {}

/// Estado de carga durante la autenticación.
class AuthLoading extends AuthState {}

/// Estado de éxito en la autenticación, con el usuario autenticado.
class AuthSuccess extends AuthState {
  /// Usuario autenticado.
  final Usuario usuario;

  /// Constructor del estado de éxito.
  AuthSuccess(this.usuario);
}

/// Estado de error en la autenticación, con el mensaje de error.
class AuthError extends AuthState {
  /// Mensaje de error.
  final String message;

  /// Constructor del estado de error.
  AuthError(this.message);
}
