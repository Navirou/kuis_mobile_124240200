import 'package:flutter/material.dart';

import '../../models/data.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String keyword = '';
  // [BONUS FILTER KATEGORI - STATE] Hapus comment jika ingin filter kategori:
  String selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    // Pencarian menu (dan filter kategori jika diaktifkan)
    final hasil = catalog.where((m) {
      final matchKeyword = m.productName.toLowerCase().contains(
        keyword.toLowerCase(),
      );
      // [BONUS FILTER KATEGORI - LOGIKA] Ganti baris return di bawah jika filter aktif:
      final matchCategory =
          selectedCategory == 'Semua' || m.type == selectedCategory;
      return matchKeyword && matchCategory;
      // return matchKeyword;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              onChanged: (v) => setState(() => keyword = v),
              decoration: InputDecoration(
                hintText: 'Cari menu...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // [BONUS FILTER KATEGORI - UI CHIPS] Hapus comment di bawah untuk memunculkan tombol kategori:
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children:
                  [
                    'Semua',
                    'T-Shirt',
                    'Bag',
                    'Pants',
                    'Jacket',
                    'Accessories',
                  ].map((cat) {
                    final isSelected = selectedCategory == cat;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: hasil.length,
              itemBuilder: (context, i) {
                final menu = hasil[i];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      menu.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.broken_image, size: 50),
                    ),
                  ),
                  title: Text(menu.productName),
                  subtitle: Text('${menu.type} • ${menu.price}'),

                  // trailing: const Icon(Icons.chevron_right),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorite(menu) ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite(menu) ? Colors.pink : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        toggleFavorite(menu);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            isFavorite(menu)
                                ? '${menu.productName} ditambahkan ke favorit'
                                : '${menu.productName} dihapus dari favorit',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),

                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailPage(menu: menu)),
                    );
                    setState(() {});
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
