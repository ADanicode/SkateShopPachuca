import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/producto.dart';
import '../bloc/catalogo_bloc.dart';
import '../bloc/catalogo_event.dart';
import '../bloc/catalogo_state.dart';

/// Página principal del catálogo.
/// Muestra el catálogo de productos usando un GridView responsivo.
class CatalogoPage extends StatelessWidget {
  const CatalogoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dispara el evento para cargar el catálogo al construir la página.
    context.read<CatalogoBloc>().add(CargarCatalogo());

    return Scaffold(
      appBar: AppBar(title: const Text('Catálogo de Patinetas')),
      body: BlocBuilder<CatalogoBloc, CatalogoState>(
        builder: (context, state) {
          if (state is CatalogoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatalogoError) {
            return Center(
              child: Text(
                'Error: ${state.mensaje}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is CatalogoLoaded) {
            return _buildCatalogoGrid(state.productos);
          }
          return const Center(child: Text('Bienvenido al Catálogo'));
        },
      ),
    );
  }

  /// Construye el GridView responsivo para mostrar los productos.
  Widget _buildCatalogoGrid(List<Producto> productos) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina el número de columnas basado en el ancho de la pantalla.
        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75, // Relación de aspecto para las tarjetas.
          ),
          itemCount: productos.length,
          itemBuilder: (context, index) {
            final producto = productos[index];
            return _buildProductoCard(producto);
          },
        );
      },
    );
  }

  /// Construye una tarjeta para un producto individual.
  Widget _buildProductoCard(Producto producto) {
    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text('Marca: ${producto.marca}'),
            const SizedBox(height: 8.0),
            Text('Stock: ${producto.stock}'),
            const SizedBox(height: 8.0),
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
