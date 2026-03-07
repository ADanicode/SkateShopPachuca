import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/usuarios/usuarios_bloc.dart';
import '../bloc/usuarios/usuarios_event.dart';
import '../bloc/usuarios/usuarios_state.dart';
import '../../domain/entities/empleado.dart';
import '../../data/repositories/empleado_repository_impl.dart';
import '../../data/datasources/mock_empleado_datasource.dart';
import 'package:skateshoppachuca/core/presentation/widgets/custom_loader.dart';

/// Página de gestión de usuarios para administradores.
///
/// Muestra una lista de usuarios con sus roles y opción de registrar nuevos.
class UsuariosPage extends StatelessWidget {
  /// Constructor de UsuariosPage.
  const UsuariosPage({super.key});

  Color _getRoleColor(String rol) {
    switch (rol) {
      case 'Administrador':
        return Colors.purple;
      case 'Trabajador':
        return Colors.blue;
      case 'Consultor':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getInitials(String nombre) {
    final partes = nombre.split(' ');
    if (partes.length >= 2) {
      return '${partes[0][0]}${partes[1][0]}'.toUpperCase();
    }
    return nombre[0].toUpperCase();
  }

  void _showAddEmpleadoDialog(BuildContext context, UsuariosBloc bloc) {
    final nombreController = TextEditingController();
    final emailController = TextEditingController();
    String? selectedRol;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Registrar Empleado'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: selectedRol,
              decoration: const InputDecoration(
                labelText: 'Rol',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Administrador',
                  child: Text('Administrador'),
                ),
                DropdownMenuItem(
                  value: 'Trabajador',
                  child: Text('Trabajador'),
                ),
                DropdownMenuItem(value: 'Consultor', child: Text('Consultor')),
              ],
              onChanged: (value) {
                selectedRol = value;
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nombreController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  selectedRol != null) {
                final empleado = Empleado(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nombre: nombreController.text,
                  email: emailController.text,
                  rol: selectedRol!,
                );
                bloc.add(AddUsuario(empleado));
                Navigator.of(context).pop();
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UsuariosBloc(EmpleadoRepositoryImpl(MockEmpleadoDataSource()))
            ..add(LoadUsuarios()),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Usuarios')),
          body: BlocBuilder<UsuariosBloc, UsuariosState>(
            builder: (context, state) {
              if (state is UsuariosLoading) {
                return const Center(child: CustomLoader());
              } else if (state is UsuariosLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.empleados.length,
                  itemBuilder: (context, index) {
                    final empleado = state.empleados[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getRoleColor(
                            empleado.rol,
                          ).withValues(alpha: 0.2),
                          child: Text(
                            _getInitials(empleado.nombre),
                            style: TextStyle(
                              color: _getRoleColor(empleado.rol),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          empleado.nombre,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(empleado.email),
                        trailing: Chip(
                          label: Text(empleado.rol),
                          backgroundColor: _getRoleColor(empleado.rol),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                );
              } else if (state is UsuariosError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${state.message}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<UsuariosBloc>().add(LoadUsuarios()),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                );
              }
              return const Center(child: Text('Cargando...'));
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              final bloc = context.read<UsuariosBloc>();
              _showAddEmpleadoDialog(context, bloc);
            },
            icon: const Icon(Icons.person_add),
            label: const Text('Registrar Empleado'),
          ),
        ),
      ),
    );
  }
}
