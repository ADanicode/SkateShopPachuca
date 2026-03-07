/// Entidad que representa a un empleado en el sistema.
///
/// Esta clase es inmutable y se utiliza para representar la información
/// de un empleado en la capa de dominio.
class Empleado {
  /// Identificador único del empleado.
  final String id;

  /// Nombre completo del empleado.
  final String nombre;

  /// Correo electrónico del empleado.
  final String email;

  /// Rol del empleado en el sistema (Administrador, Trabajador, Consultor).
  final String rol;

  /// Constructor de Empleado.
  const Empleado({
    required this.id,
    required this.nombre,
    required this.email,
    required this.rol,
  });

  /// Crea una copia del empleado con algunos campos modificados.
  Empleado copyWith({String? id, String? nombre, String? email, String? rol}) {
    return Empleado(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      rol: rol ?? this.rol,
    );
  }

  @override
  String toString() {
    return 'Empleado(id: $id, nombre: $nombre, email: $email, rol: $rol)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Empleado &&
        other.id == id &&
        other.nombre == nombre &&
        other.email == email &&
        other.rol == rol;
  }

  @override
  int get hashCode {
    return id.hashCode ^ nombre.hashCode ^ email.hashCode ^ rol.hashCode;
  }
}
