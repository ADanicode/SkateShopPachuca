import 'package:flutter/material.dart';

/// Página de inventario para administradores.
///
/// Muestra un grid responsivo de productos con búsqueda y opción de agregar nuevos.
class InventarioPage extends StatefulWidget {
  /// Constructor de InventarioPage.
  const InventarioPage({super.key});

  @override
  State<InventarioPage> createState() => _InventarioPageState();
}

class _InventarioPageState extends State<InventarioPage> {
  final TextEditingController _searchController = TextEditingController();

  // Datos mockeados de productos
  final List<Map<String, dynamic>> _productos = [
    {'nombre': 'Skateboard Pro', 'precio': 2500.0, 'stock': 15},
    {'nombre': 'Longboard Cruiser', 'precio': 3200.0, 'stock': 8},
    {'nombre': 'Skate Completo', 'precio': 1800.0, 'stock': 3},
    {'nombre': 'Ruedas Street', 'precio': 450.0, 'stock': 25},
    {'nombre': 'Tabla Dance', 'precio': 2800.0, 'stock': 12},
    {'nombre': 'Ejes Indy', 'precio': 350.0, 'stock': 2},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _productos.length,
        itemBuilder: (context, index) {
          final producto = _productos[index];
          final stock = producto['stock'] as int;
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen placeholder
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.sports_soccer,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    producto['nombre'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${producto['precio']}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text('Stock: $stock'),
                    backgroundColor: stock < 5 ? Colors.red : Colors.green,
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implementar agregar producto
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Producto'),
      ),
    );
  }
}
