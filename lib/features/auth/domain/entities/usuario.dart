/// Entidad que representa a un usuario en el sistema de autenticación.
///
/// Contiene la información básica del usuario autenticado.
class Usuario {
  /// Identificador único del usuario.
  final String id;

  /// Nombre del usuario.
  final String nombre;

  /// Correo electrónico del usuario.
  final String email;

  /// Constructor de la entidad Usuario.
  const Usuario({required this.id, required this.nombre, required this.email});
}
