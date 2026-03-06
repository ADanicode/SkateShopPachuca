import 'package:equatable/equatable.dart';

/// Entidad que representa un producto en el catálogo.
/// Utiliza Equatable para comparaciones eficientes.
class Producto extends Equatable {
  final int id;
  final String nombre;
  final String marca;
  final double precio;
  final int stock;

  const Producto({
    required this.id,
    required this.nombre,
    required this.marca,
    required this.precio,
    required this.stock,
  });

  @override
  List<Object> get props => [id, nombre, marca, precio, stock];
}
