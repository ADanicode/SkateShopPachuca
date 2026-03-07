import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// Widget reutilizable para mostrar una animación de carga usando Lottie.
///
/// Este componente carga una animación desde 'assets/lottie/loading.json'
/// y la muestra con un ancho fijo de 150 píxeles.
class CustomLoader extends StatelessWidget {
  /// Constructor de CustomLoader.
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/loading.json', width: 150);
  }
}
