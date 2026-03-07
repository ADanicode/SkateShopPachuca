import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/empleado_repository.dart';
import 'usuarios_event.dart';
import 'usuarios_state.dart';

/// BLoC para gestionar la lógica de usuarios.
///
/// Maneja los eventos relacionados con la obtención y adición de empleados.
class UsuariosBloc extends Bloc<UsuariosEvent, UsuariosState> {
  final EmpleadoRepository _empleadoRepository;

  /// Constructor que recibe el repositorio de empleados.
  UsuariosBloc(this._empleadoRepository) : super(UsuariosInitial()) {
    on<LoadUsuarios>(_onLoadUsuarios);
    on<AddUsuario>(_onAddUsuario);
  }

  /// Manejador del evento LoadUsuarios.
  ///
  /// Carga la lista de empleados desde el repositorio.
  Future<void> _onLoadUsuarios(
    LoadUsuarios event,
    Emitter<UsuariosState> emit,
  ) async {
    emit(UsuariosLoading());
    try {
      final empleados = await _empleadoRepository.getEmpleados();
      emit(UsuariosLoaded(empleados));
    } catch (e) {
      emit(UsuariosError(e.toString()));
    }
  }

  /// Manejador del evento AddUsuario.
  ///
  /// Agrega un nuevo empleado y recarga la lista.
  Future<void> _onAddUsuario(
    AddUsuario event,
    Emitter<UsuariosState> emit,
  ) async {
    emit(UsuariosLoading());
    try {
      await _empleadoRepository.addEmpleado(event.empleado);
      final empleados = await _empleadoRepository.getEmpleados();
      emit(UsuariosLoaded(empleados));
    } catch (e) {
      emit(UsuariosError(e.toString()));
    }
  }
}
