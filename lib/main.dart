import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/catalogo/data/repositories/producto_repository_impl.dart';
import 'features/catalogo/presentation/bloc/catalogo_bloc.dart';
import 'features/catalogo/presentation/pages/catalogo_page.dart';

/// Punto de entrada principal de la aplicación.
/// Configura el BlocProvider y MaterialApp.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogoBloc(ProductoRepositoryImpl()),
      child: MaterialApp(
        title: 'Punto de Venta Patinetas',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CatalogoPage(),
      ),
    );
  }
}
