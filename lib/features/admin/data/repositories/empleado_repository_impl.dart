import '../../domain/entities/empleado.dart';
import '../../domain/repositories/empleado_repository.dart';
import '../datasources/mock_empleado_datasource.dart';

/// Implementación del repositorio de empleados usando Mock DataSource.
///
/// Esta clase actúa como puente entre la capa de dominio y la capa de datos,
/// utilizando un DataSource mock para simular operaciones de red.
class EmpleadoRepositoryImpl implements EmpleadoRepository {
  final MockEmpleadoDataSource _dataSource;

  /// Constructor que recibe el DataSource.
  EmpleadoRepositoryImpl(this._dataSource);

  @override
  Future<List<Empleado>> getEmpleados() async {
    try {
      return await _dataSource.getEmpleados();
    } catch (e) {
      throw Exception('Error al obtener empleados: $e');
    }
  }

  @override
  Future<void> addEmpleado(Empleado empleado) async {
    try {
      await _dataSource.addEmpleado(empleado);
    } catch (e) {
      throw Exception('Error al agregar empleado: $e');
    }
  }
}
