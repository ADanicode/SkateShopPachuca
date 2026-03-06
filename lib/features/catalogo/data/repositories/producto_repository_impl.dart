import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/producto.dart';
import '../../domain/repositories/producto_repository.dart';

/// Implementación del repositorio de productos usando HTTP.
/// Realiza una petición GET a la API de inventario y mapea el JSON a entidades Producto.
class ProductoRepositoryImpl implements ProductoRepository {
  final String baseUrl = 'https://api-patinetas.onrender.com/api/productos';

  @override
  Future<List<Producto>> obtenerCatalogo() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData
            .map(
              (json) => Producto(
                id: json['id'] as int,
                nombre: json['nombre'] as String,
                marca: json['marca'] as String,
                precio: (json['precio'] as num).toDouble(),
                stock: json['stock'] as int,
              ),
            )
            .toList();
      } else {
        throw Exception('Error al cargar el catálogo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
