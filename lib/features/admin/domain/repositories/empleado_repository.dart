import '../entities/empleado.dart';

/// Interfaz abstracta para el repositorio de empleados.
///
/// Define las operaciones básicas para gestionar empleados en el sistema.
abstract class EmpleadoRepository {
  /// Obtiene la lista de todos los empleados.
  ///
  /// Retorna una lista de empleados o lanza una excepción si ocurre un error.
  Future<List<Empleado>> getEmpleados();

  /// Agrega un nuevo empleado al sistema.
  ///
  /// [empleado] El empleado a agregar.
  /// Lanza una excepción si ocurre un error durante la operación.
  Future<void> addEmpleado(Empleado empleado);
}
