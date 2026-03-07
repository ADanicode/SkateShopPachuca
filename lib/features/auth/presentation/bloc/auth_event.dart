/// Eventos para el BLoC de autenticación.
///
/// Define los eventos que pueden ocurrir en el proceso de autenticación.
abstract class AuthEvent {}

/// Evento que indica la solicitud de verificación del estado de autenticación.
class CheckAuthStatus extends AuthEvent {}

/// Evento que indica la solicitud de inicio de sesión con Google.
class LoginConGoogle extends AuthEvent {}

/// Evento que indica la solicitud de cierre de sesión.
class LogoutRequested extends AuthEvent {}
