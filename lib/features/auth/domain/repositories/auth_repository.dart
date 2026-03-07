import '../entities/usuario.dart';

/// Repositorio abstracto para operaciones de autenticación.
///
/// Define los métodos necesarios para manejar la autenticación de usuarios.
abstract class AuthRepository {
  /// Inicia sesión con Google y devuelve el usuario autenticado.
  ///
  /// Retorna un [Future] que resuelve en un [Usuario] si la autenticación es exitosa,
  /// o lanza una excepción en caso de error.
  Future<Usuario> signInWithGoogle();
}
