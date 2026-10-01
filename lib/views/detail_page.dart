import 'package:flutter/material.dart';

import '../models/data.dart';

class DetailPage extends StatefulWidget {
  final Product menu;
  const DetailPage({super.key, required this.menu});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    final menu = widget.menu;

    return Scaffold(
      // AppBar otomatis punya tombol kembali ke Home
      appBar: AppBar(
        title: Text(menu.productName),

        actions: [
          IconButton(
            icon: Icon(
              isFavorite(menu) ? Icons.favorite : Icons.favorite_border,
              color: isFavorite(menu) ? Colors.pink : null,
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                menu.imageUrl,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => const SizedBox(
                  height: 220,
                  child: Center(child: Icon(Icons.broken_image, size: 80)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              menu.productName,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(menu.type, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(
              menu.price,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Jumlah Product',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Icon(Icons.favorite, color: Colors.red),
            Text("${menu.likeCount} Likes  Stok: ${menu.stock}"),
            const SizedBox(height: 16),
            const Text('Size', style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${menu.sizes}"),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(menu.details),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
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
        icon: Icon(
          isFavorite(menu) ? Icons.favorite : Icons.favorite_border,
          color: isFavorite(menu) ? Colors.pink : Colors.white,
        ),
        label: Text(isFavorite(menu) ? 'Tersimpan' : 'Tambah Favorit'),
      ),
    );
  }
}
