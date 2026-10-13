import '../models/producto.dart';

const List<Producto> productos = [
  Producto(
    id: 1,
    nombre: 'Figura Hatsune Miku',
    descripcion:
        'Figura de colección inspirada en Hatsune Miku, con una pose dinámica y una base decorativa. Ideal para exhibir en tu colección.',
    precio: 899.00,
    imagen: 'assets/images/figura_miku.png',
    categoria: 'Figuras',
    tienda: 'Miku Collectibles',
    calificacion: 4.9,
  ),
  Producto(
    id: 2,
    nombre: 'Figura Kagamine Rin',
    descripcion:
        'Figura de colección de Kagamine Rin. Un artículo decorativo para fans de Vocaloid.',
    precio: 749.00,
    imagen: 'assets/images/figura_rin.png',
    categoria: 'Figuras',
    tienda: 'Miku Collectibles',
    calificacion: 4.7,
  ),
  Producto(
    id: 3,
    nombre: 'Llavero de Miku',
    descripcion:
        'Llavero temático de Hatsune Miku para llevar en tu mochila, bolso o estuche.',
    precio: 129.00,
    imagen: 'assets/images/accesorio_miku.png',
    categoria: 'Accesorios',
    tienda: 'Otaku Accesorios',
    calificacion: 4.6,
  ),
  Producto(
    id: 4,
    nombre: 'Figura chibi de Miku',
    descripcion:
        'Figura estilo chibi con acabado colorido. Una opción compacta para decorar tu escritorio.',
    precio: 399.00,
    imagen: 'assets/images/figura_chibi.png',
    categoria: 'Figuras',
    tienda: 'Miku Collectibles',
    calificacion: 4.8,
  ),
];
