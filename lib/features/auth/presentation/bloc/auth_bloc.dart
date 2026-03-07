import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// BLoC para manejar la lógica de autenticación.
///
/// Gestiona los eventos de autenticación y emite los estados correspondientes.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  /// Constructor que recibe el repositorio de autenticación.
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginConGoogle>(_onLoginConGoogle);
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
}
