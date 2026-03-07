import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/carrito_bloc.dart';
import '../bloc/carrito_event.dart';
import '../bloc/carrito_state.dart';

/// Drawer lateral para el carrito de compras.
///
/// Muestra la lista de items, el total y un botón para confirmar la venta.
class CarritoDrawer extends StatelessWidget {
  const CarritoDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Carrito de Compras'),
            automaticallyImplyLeading: false,
          ),
          Expanded(
            child: BlocBuilder<CarritoBloc, CarritoState>(
              builder: (context, state) {
                if (state is CarritoActualizado) {
                  if (state.items.isEmpty) {
                    return Center(child: Text('El carrito está vacío'));
                  }
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        title: Text(item.producto.nombre),
                        subtitle: Text(
                          'Cantidad: ${item.cantidad} - Subtotal: \$${item.subtotal.toStringAsFixed(2)}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            context.read<CarritoBloc>().add(
                              EliminarProducto(item.producto),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          BlocBuilder<CarritoBloc, CarritoState>(
            builder: (context, state) {
              if (state is CarritoActualizado) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total: \$${state.total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          print(
                            'Venta confirmada. Total: \$${state.total.toStringAsFixed(2)}',
                          );
                        },
                        child: Text('Confirmar Venta'),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
