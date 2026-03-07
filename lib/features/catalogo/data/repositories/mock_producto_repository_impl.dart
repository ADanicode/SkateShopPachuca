import '../../domain/entities/producto.dart';
import '../../domain/repositories/producto_repository.dart';

/// Implementación mock del repositorio de productos.
///
/// Devuelve una lista quemada de productos después de un delay de 2 segundos.
class MockProductoRepositoryImpl implements ProductoRepository {
  @override
  Future<List<Producto>> obtenerCatalogo() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      Producto(
        id: 1,
        nombre: 'Tabla de Skate Completa',
        marca: 'Santa Cruz',
        precio: 150.0,
        stock: 10,
      ),
      Producto(
        id: 2,
        nombre: 'Lija para Grip',
        marca: 'Mob Grip',
        precio: 20.0,
        stock: 50,
      ),
      Producto(
        id: 3,
        nombre: 'Ruedas de Skate',
        marca: 'Bones',
        precio: 30.0,
        stock: 20,
      ),
      Producto(
        id: 4,
        nombre: 'Rodamientos ABEC 7',
        marca: 'Bones',
        precio: 25.0,
        stock: 30,
      ),
      Producto(
        id: 5,
        nombre: 'Ejes de Skate',
        marca: 'Independent',
        precio: 15.0,
        stock: 40,
      ),
    ];
  }
}
