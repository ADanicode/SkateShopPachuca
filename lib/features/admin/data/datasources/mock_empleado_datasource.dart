import '../../domain/entities/empleado.dart';

/// DataSource mock para empleados que simula operaciones en memoria.
///
/// Esta clase simula una base de datos en memoria con latencia artificial
/// para representar operaciones de red.
class MockEmpleadoDataSource {
  /// Lista privada de empleados en memoria.
  final List<Empleado> _empleados = [
    const Empleado(
      id: '1',
      nombre: 'Juan Pérez',
      email: 'juan.perez@skateshop.com',
      rol: 'Administrador',
    ),
    const Empleado(
      id: '2',
      nombre: 'María García',
      email: 'maria.garcia@skateshop.com',
      rol: 'Trabajador',
    ),
    const Empleado(
      id: '3',
      nombre: 'Carlos López',
      email: 'carlos.lopez@skateshop.com',
      rol: 'Consultor',
    ),
  ];

  /// Obtiene la lista de empleados con simulación de latencia.
  ///
  /// Simula una llamada a API con 1 segundo de delay.
  Future<List<Empleado>> getEmpleados() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_empleados);
  }

  /// Agrega un nuevo empleado a la lista en memoria.
  ///
  /// Simula una operación de inserción con latencia.
  /// [empleado] El empleado a agregar.
  Future<void> addEmpleado(Empleado empleado) async {
    await Future.delayed(const Duration(seconds: 1));
    _empleados.add(empleado);
  }
}
