import 'package:flutter/material.dart';
import 'admin_dashboard_page.dart';
import 'inventario_page.dart';
import 'usuarios_page.dart';

/// Página de layout administrativo con navegación responsiva.
///
/// Proporciona una navegación adaptativa: BottomNavigationBar en móvil,
/// AppBar con menú superior en Web/Tablet.
class AdminLayoutPage extends StatefulWidget {
  /// Constructor de AdminLayoutPage.
  const AdminLayoutPage({super.key});

  @override
  State<AdminLayoutPage> createState() => _AdminLayoutPageState();
}

class _AdminLayoutPageState extends State<AdminLayoutPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    const AdminDashboardPage(),
    const InventarioPage(),
    const UsuariosPage(),
  ];

  static const List<String> _titles = <String>[
    'Dashboard',
    'Inventario',
    'Usuarios',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          // Navegación inferior para móvil
          return Scaffold(
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.inventory),
                  label: 'Inventario',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Usuarios',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
          );
        } else {
          // Navegación superior para Web/Tablet
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(
                    Icons.sports_soccer,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'SkateShop Pachuca - ${_titles[_selectedIndex]}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                Row(
                  children: List.generate(_titles.length, (index) {
                    return TextButton(
                      onPressed: () => _onItemTapped(index),
                      style: TextButton.styleFrom(
                        foregroundColor: _selectedIndex == index
                            ? Theme.of(context).primaryColor
                            : Colors.black,
                      ),
                      child: Text(_titles[index]),
                    );
                  }),
                ),
              ],
            ),
            body: _pages[_selectedIndex],
          );
        }
      },
    );
  }
}
