import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../../auth/presentation/bloc/auth_event.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../catalogo/presentation/pages/catalogo_page.dart';
import '../../../admin/presentation/pages/admin_layout_page.dart';
import 'package:skateshoppachuca/core/presentation/widgets/custom_loader.dart';
import 'splash_screen.dart';

/// Página de enrutamiento principal basada en el estado de autenticación y roles.
///
/// Esta página actúa como un router dinámico que evalúa el estado del AuthBloc
/// y dirige al usuario a la página correspondiente según su rol (RBAC).
class HomeRouterPage extends StatefulWidget {
  /// Constructor de HomeRouterPage.
  const HomeRouterPage({super.key});

  @override
  State<HomeRouterPage> createState() => _HomeRouterPageState();
}

class _HomeRouterPageState extends State<HomeRouterPage> {
  @override
  void initState() {
    super.initState();
    // Verificar el estado de autenticación al iniciar
    context.read<AuthBloc>().add(CheckAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const _LoadingScreen();
        } else if (state is AuthSuccess) {
          // Evaluación de rol para RBAC
          if (state.usuario.rol == 'Trabajador') {
            return const CatalogoPage();
          } else if (state.usuario.rol == 'Administrador' ||
              state.usuario.rol == 'Consultor') {
            return const AdminLayoutPage();
          } else {
            // Rol desconocido, redirigir a login
            return const LoginPage();
          }
        } else if (state is AuthError) {
          // Si no está autenticado o hay error, mostrar login
          return const LoginPage();
        } else {
          // Estado inicial, mostrar splash screen mientras se verifica
          return const SplashScreen();
        }
      },
    );
  }
}

/// Pantalla de carga con logo falso y indicador animado.
///
/// Muestra un logo placeholder y un CircularProgressIndicator con animación.
class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo falso (placeholder)
            Icon(
              Icons.sports_soccer, // Ícono de patineta o similar
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),
            const Text(
              'SkateShop Pachuca',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // CustomLoader animado
            const CustomLoader(),
          ],
        ),
      ),
    );
  }
}
