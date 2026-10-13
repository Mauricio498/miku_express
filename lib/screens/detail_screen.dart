import 'package:flutter/material.dart';

import '../models/producto.dart';

class DetailScreen extends StatefulWidget {
  final Producto producto;
  final bool initiallyFavorite;
  final ValueChanged<bool> onFavoriteChanged;

  const DetailScreen({
    super.key,
    required this.producto,
    required this.initiallyFavorite,
    required this.onFavoriteChanged,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isFavorite;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.initiallyFavorite;
  }

  void _toggleFavorite() {
    setState(() => _isFavorite = !_isFavorite);
    widget.onFavoriteChanged(_isFavorite);
  }

  void _placeOrder() {
    final total = widget.producto.precio * _quantity;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Color(0xFF168A78),
            size: 44,
          ),
          title: const Text('¡Pedido simulado!'),
          content: Text(
            'Has solicitado $_quantity unidad(es) de '
            '${widget.producto.nombre}.\n\n'
            'Total ficticio: \$${total.toStringAsFixed(2)} MXN\n\n'
            'Esto es una demostración. No se ha realizado ninguna compra real.',
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final producto = widget.producto;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del producto'),
        actions: [
          IconButton(
            tooltip: _isFavorite ? 'Quitar favorito' : 'Añadir favorito',
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? const Color(0xFFFF5D91) : null,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          children: [
            Container(
              height: 300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8F4),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Hero(
                tag: 'producto-${producto.id}',
                child: Image.asset(
                  producto.imagen,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image_not_supported_outlined,
                      size: 90,
                      color: Color(0xFF168A78),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    producto.categoria.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF168A78),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      fontSize: 11,
                    ),
                  ),
                ),
                const Icon(Icons.star, color: Colors.amber, size: 19),
                const SizedBox(width: 4),
                Text(
                  '${producto.calificacion.toStringAsFixed(1)} / 5',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              producto.nombre,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vendido por ${producto.tienda}',
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              '\$${producto.precio.toStringAsFixed(2)} MXN',
              style: const TextStyle(
                color: Color(0xFF168A78),
                fontSize: 27,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descripción',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              producto.descripcion,
              style: const TextStyle(
                height: 1.5,
                color: Color(0xFF55566A),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_shipping_outlined,
                    color: Color(0xFF168A78),
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Entrega simulada',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          producto.disponible
                              ? 'Disponible para solicitar'
                              : 'Agotado temporalmente',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    producto.disponible
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: producto.disponible
                        ? const Color(0xFF168A78)
                        : Colors.redAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cantidad',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                  icon: const Icon(Icons.remove),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    '$_quantity',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                ),
                IconButton.filledTonal(
                  onPressed: () => setState(() => _quantity++),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: producto.disponible ? _placeOrder : null,
              icon: const Icon(Icons.shopping_bag_outlined),
              label: const Text('Realizar pedido'),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Demostración académica: no se procesan pagos ni pedidos reales.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }
}
