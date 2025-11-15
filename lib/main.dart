import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kuis Nomor 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const ProductGridScreen(),
    );
  }
}

class ProductGridScreen extends StatelessWidget {
  const ProductGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'ROG Phone',
        'price': 'Rp 5.999.000',
        'image': 'assets/images/rog.png',
        'discount': '20%',
        'rating': 4.8,
        'sold': '1.2k',
      },
      {
        'name': 'Laptop Pro',
        'price': 'Rp 12.500.000',
        'image': 'assets/images/laptop.png',
        'discount': '15%',
        'rating': 4.7,
        'sold': '856',
      },
      {
        'name': 'Headphone Wireless',
        'price': 'Rp 899.000',
        'image': 'assets/images/headphone.png',
        'discount': '30%',
        'rating': 4.9,
        'sold': '2.5k',
      },
      {
        'name': 'Smartwatch',
        'price': 'Rp 2.499.000',
        'image': 'assets/images/smartwatch.png',
        'discount': null,
        'rating': 4.6,
        'sold': '645',
      },
      {
        'name': 'Kamera DSLR',
        'price': 'Rp 7.800.000',
        'image': 'assets/images/kamera.png',
        'discount': '25%',
        'rating': 4.8,
        'sold': '432',
      },
      {
        'name': 'Gamepad Pro',
        'price': 'Rp 599.000',
        'image': 'assets/images/gamepad.png',
        'discount': '50%',
        'rating': 4.5,
        'sold': '3.1k',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toko Online',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Produk Pilihan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${products.length} produk tersedia',
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Dibuka: ${widget.product['name']}'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          transform: Matrix4.identity()
            ..scale(isPressed ? 0.95 : (isHovered ? 1.05 : 1.0)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              // Shadow utama
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.12 : 0.06),
                blurRadius: isHovered ? 20 : 10,
                offset: Offset(0, isHovered ? 8 : 4),
                spreadRadius: 0,
              ),
              // Shadow halus untuk depth
              BoxShadow(
                color: Colors.black.withOpacity(isHovered ? 0.06 : 0.03),
                blurRadius: isHovered ? 30 : 15,
                offset: Offset(0, isHovered ? 12 : 6),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk dengan badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: Image.asset(
                        widget.product['image'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[100],
                            child: Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Badge diskon
                  if (widget.product['discount'] != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B6B), Color(0xFFFF5252)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '${widget.product['discount']} OFF',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Tombol favorite
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),

              // Detail produk
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Nama produk
                          Text(
                            widget.product['name'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),

                          // Rating dan terjual
                          Row(
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 16,
                                color: Colors.amber[700],
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${widget.product['rating']}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '• ${widget.product['sold']} terjual',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Harga dan tombol
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              widget.product['price'] as String,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2ECC71),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3498DB),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add_shopping_cart,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
