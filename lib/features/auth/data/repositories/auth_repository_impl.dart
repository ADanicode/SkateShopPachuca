import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementación del repositorio de autenticación usando Firebase y Google Sign-In.
///
/// Esta clase maneja la autenticación real con Google a través de Firebase Auth.
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Constructor que recibe instancias de FirebaseAuth y GoogleSignIn.
  AuthRepositoryImpl(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Usuario> signInWithGoogle() async {
    try {
      // Inicia el proceso de sign-in con Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Sign-in cancelado por el usuario');
      }

      // Obtiene las credenciales de autenticación
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Crea las credenciales para Firebase
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Autentica con Firebase
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user == null) {
        throw Exception('Error al obtener información del usuario');
      }

      // Retorna la entidad Usuario
      return Usuario(
        id: user.uid,
        nombre: user.displayName ?? 'Usuario',
        email: user.email ?? '',
      );
    } catch (e) {
      throw Exception('Error en la autenticación: $e');
    }
  }
}
