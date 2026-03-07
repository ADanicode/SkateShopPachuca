import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'package:skateshoppachuca/core/presentation/widgets/custom_loader.dart';

/// Página de inicio de sesión.
///
/// Proporciona una interfaz moderna para autenticarse con Google.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo centrado (puedes reemplazar con tu logo real)
              const Icon(
                Icons.sports_soccer, // Cambia por tu logo
                size: 100,
                color: Colors.blue,
              ),
              const SizedBox(height: 40),
              const Text(
                'Skate Shop Pachuca',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CustomLoader();
                  }
                  return ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoginConGoogle());
                    },
                    icon: const Icon(Icons.login),
                    label: const Text('Iniciar sesión con Google'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
              if (context.watch<AuthBloc>().state is AuthError)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    (context.watch<AuthBloc>().state as AuthError).message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
