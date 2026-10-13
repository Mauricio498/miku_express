import '../models/producto.dart';

const List<Producto> productos = [
  Producto(
    id: 1,
    nombre: 'Figura Hatsune Miku',
    descripcion: 'Figura de colección con base decorativa.',
    precio: 899.00,
    imagen: 'assets/images/figura_miku.png',
    categoria: 'Figuras',
    tienda: 'Miku Collectibles',
    calificacion: 4.9,
  ),
  Producto(
    id: 2,
    nombre: 'Figura Kagamine Rin',
    descripcion: 'Figura de colección de edición ficticia.',
    precio: 749.00,
    imagen: 'assets/images/figura_rin.png',
    categoria: 'Figuras',
    tienda: 'Miku Collectibles',
    calificacion: 4.7,
  ),
];
