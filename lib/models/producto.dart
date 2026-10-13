class Producto {
  final int id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagen;
  final String categoria;
  final String tienda;
  final double calificacion;
  final bool disponible;

  const Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.categoria,
    required this.tienda,
    required this.calificacion,
    this.disponible = true,
  });
}
