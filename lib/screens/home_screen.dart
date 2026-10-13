import 'package:flutter/material.dart';

import '../data/productos_mock.dart';
import '../models/producto.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _favorites = {};
  String _selectedCategory = 'Todos';
  String _searchText = '';

  final List<String> _categories = const [
    'Todos',
    'Figuras',
    'Accesorios',
  ];

  List<Producto> get _filteredProducts {
    return productos.where((producto) {
      final matchesCategory = _selectedCategory == 'Todos' ||
          producto.categoria == _selectedCategory;

      final query = _searchText.trim().toLowerCase();
      final matchesSearch = query.isEmpty ||
          producto.nombre.toLowerCase().contains(query) ||
          producto.tienda.toLowerCase().contains(query) ||
          producto.categoria.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetails(Producto producto) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          producto: producto,
          initiallyFavorite: _favorites.contains(producto.id),
          onFavoriteChanged: (isFavorite) {
            setState(() {
              if (isFavorite) {
                _favorites.add(producto.id);
              } else {
                _favorites.remove(producto.id);
              }
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = _filteredProducts;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9FFF5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.delivery_dining,
                color: Color(0xFF168A78),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Miku Express',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
                Text(
                  'Tu rincón de colección',
                  style: TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Favoritos',
            onPressed: () {
              setState(() {
                _selectedCategory = 'Todos';
                _searchController.clear();
                _searchText = '';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _favorites.isEmpty
                        ? 'Todavía no tienes favoritos.'
                        : 'Tienes ${_favorites.length} producto(s) favorito(s).',
                  ),
                ),
              );
            },
            icon: const Icon(Icons.favorite_border),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFB8F0E5), Color(0xFFFFDCE8)],
                    ),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pequeñas cosas,\ngrandes colecciones.',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                                color: Color(0xFF25263A),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Encuentra tu próximo favorito.',
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 14),
                            FilledButton.icon(
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = 'Todos';
                                  _searchController.clear();
                                  _searchText = '';
                                });
                              },
                              icon: const Icon(Icons.explore, size: 17),
                              label: const Text('Explorar'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.local_mall,
                        size: 68,
                        color: Color(0xFF168A78),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() => _searchText = value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Buscar figuras, accesorios o tiendas...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 44,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    final category = _categories[index];
                    return CategoryChip(
                      label: category,
                      selected: category == _selectedCategory,
                      onTap: () {
                        setState(() => _selectedCategory = category);
                      },
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Descubre productos',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      '${visibleProducts.length} artículos',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (visibleProducts.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off, size: 54, color: Colors.black38),
                        SizedBox(height: 12),
                        Text(
                          'No encontramos productos.',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Prueba con otro nombre o categoría.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.61,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final producto = visibleProducts[index];
                      return ProductCard(
                        producto: producto,
                        isFavorite: _favorites.contains(producto.id),
                        onFavoriteTap: () {
                          setState(() {
                            if (_favorites.contains(producto.id)) {
                              _favorites.remove(producto.id);
                            } else {
                              _favorites.add(producto.id);
                            }
                          });
                        },
                        onTap: () => _openDetails(producto),
                      );
                    },
                    childCount: visibleProducts.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
