import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';

/// Página del dashboard administrativo premium.
///
/// Proporciona una vista moderna y responsiva con métricas clave y últimas transacciones
/// para el rol de Administrador, utilizando animaciones y diseño Material 3.
class AdminDashboardPage extends StatelessWidget {
  /// Constructor de AdminDashboardPage.
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          return CustomScrollView(
            slivers: [
              // SliverAppBar expandido con gradiente
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Panel Directivo',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purple],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Colors.white),
                    onPressed: () {
                      context.read<AuthBloc>().add(LogoutRequested());
                    },
                    tooltip: 'Cerrar Sesión',
                  ),
                ],
              ),
              // Sliver con métricas
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInDown(
                        duration: const Duration(milliseconds: 600),
                        child: Text(
                          'Métricas Clave',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // SliverGrid para métricas
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isWide ? 3 : 1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  delegate: SliverChildListDelegate([
                    FadeInLeft(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 200),
                      child: const _MetricCard(
                        title: 'Ventas del Día',
                        value: '\$12,500.00',
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                      child: const _MetricCard(
                        title: 'Tickets Procesados',
                        value: '45',
                        icon: Icons.receipt,
                        color: Colors.blue,
                      ),
                    ),
                    FadeInRight(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 600),
                      child: const _MetricCard(
                        title: 'Stock Crítico',
                        value: '3 patinetas',
                        icon: Icons.warning,
                        color: Colors.orange,
                      ),
                    ),
                  ]),
                ),
              ),
              // Sliver con transacciones
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 800),
                        child: Text(
                          'Últimas Transacciones',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              // SliverList para transacciones
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final transaction = _mockTransactions[index];
                    return FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 1000 + index * 100),
                      child: _TransactionItem(transaction: transaction),
                    );
                  }, childCount: _mockTransactions.length),
                ),
              ),
              // Espacio al final
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          );
        },
      ),
    );
  }
}

/// Datos mockeados de transacciones para simulación.
const List<Map<String, String>> _mockTransactions = [
  {'id': '001', 'cliente': 'Juan Pérez', 'monto': '\$150.00', 'hora': '10:30'},
  {
    'id': '002',
    'cliente': 'María García',
    'monto': '\$200.00',
    'hora': '11:15',
  },
  {'id': '003', 'cliente': 'Carlos López', 'monto': '\$75.00', 'hora': '12:00'},
  {
    'id': '004',
    'cliente': 'Ana Rodríguez',
    'monto': '\$300.00',
    'hora': '12:45',
  },
  {
    'id': '005',
    'cliente': 'Pedro Sánchez',
    'monto': '\$125.00',
    'hora': '13:20',
  },
];

/// Widget para una tarjeta de métrica con efecto glassmorphism.
///
/// Muestra una métrica con ícono, título y valor en un Card con blur de fondo.
class _MetricCard extends StatelessWidget {
  /// Título de la métrica.
  final String title;

  /// Valor de la métrica.
  final String value;

  /// Ícono representativo.
  final IconData icon;

  /// Color del ícono.
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: color.withValues(alpha: 0.3)),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget para un elemento de transacción en la lista.
///
/// Incluye animación y diseño moderno.
class _TransactionItem extends StatelessWidget {
  /// Datos de la transacción.
  final Map<String, String> transaction;

  const _TransactionItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          child: Text(
            transaction['id']!,
            style: GoogleFonts.poppins(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          transaction['cliente']!,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          'Hora: ${transaction['hora']}',
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
        trailing: Text(
          transaction['monto']!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
