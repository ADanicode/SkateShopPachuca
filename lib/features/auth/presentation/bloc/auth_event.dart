/// Eventos para el BLoC de autenticación.
///
/// Define los eventos que pueden ocurrir en el proceso de autenticación.
abstract class AuthEvent {}

/// Evento que indica la solicitud de inicio de sesión con Google.
class LoginConGoogle extends AuthEvent {}
