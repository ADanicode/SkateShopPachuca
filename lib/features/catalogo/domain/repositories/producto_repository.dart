import '../entities/producto.dart';

/// Repositorio abstracto para el manejo de productos.
/// Define la interfaz para obtener el catálogo de productos.
abstract class ProductoRepository {
  /// Obtiene el catálogo completo de productos desde la fuente de datos.
  Future<List<Producto>> obtenerCatalogo();
}
