import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/usuario.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC para manejar la lógica de autenticación.
///
/// Gestiona los eventos de autenticación y emite los estados correspondientes.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  /// Constructor que recibe el repositorio de autenticación.
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<LoginConGoogle>(_onLoginConGoogle);
    on<LogoutRequested>(_onLogoutRequested);
  }

  /// Manejador del evento CheckAuthStatus.
  ///
  /// Verifica si hay un usuario autenticado en Firebase y emite AuthSuccess si existe.
  /// Si no hay usuario, emite AuthError indicando que no está autenticado.
  void _onCheckAuthStatus(CheckAuthStatus event, Emitter<AuthState> emit) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      // Usuario logueado, crear entidad con rol aleatorio basado en datos reales
      final roles = ['Trabajador', 'Administrador', 'Consultor'];
      final rolAsignado = roles[Random().nextInt(roles.length)];
      final usuario = Usuario(
        id: currentUser.uid,
        nombre: currentUser.displayName ?? 'Usuario',
        email: currentUser.email ?? '',
        rol: rolAsignado,
      );
      emit(AuthSuccess(usuario));
    } else {
      // No hay usuario autenticado
      emit(AuthError('Usuario no autenticado'));
    }
  }

  /// Manejador del evento LoginConGoogle.
  Future<void> _onLoginConGoogle(
    LoginConGoogle event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final usuario = await _authRepository.signInWithGoogle();
      emit(AuthSuccess(usuario));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  /// Manejador del evento LogoutRequested.
  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
