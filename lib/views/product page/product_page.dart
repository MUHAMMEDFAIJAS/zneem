import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controller/cart_controller.dart';
import '../../controller/product_controller.dart';
import '../../model/address model/address_model.dart';

class ProductPage extends StatefulWidget {
  final int categoryId;
  final AddressModel selectedAddress;
  final int productId;

  const ProductPage({
    Key? key,
    required this.categoryId,
    required this.selectedAddress,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController _productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    cartController.fetchCart(widget.selectedAddress.phoneNumber);
    _productController.fetchProducts(widget.categoryId);
  }

  Future<void> _addToCart(
      BuildContext context, int productId, int quantity) async {
    try {
      print('Adding Product ID: $productId');
      print('Selected Address: ${widget.selectedAddress}');

      await cartController.addToCart(
          productId, widget.selectedAddress.phoneNumber, widget.selectedAddress,
          quantity: quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    return Scaffold(
      appBar: AppBar(
        title: Text('Products in Category ${widget.categoryId}'),
      ),
      body: Obx(() {
        if (_productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_productController.errorMessage.isNotEmpty) {
          return Center(child: Text(_productController.errorMessage.value));
        } else if (_productController.products.isEmpty) {
          return const Center(child: Text('No products found.'));
        }

        return ListView.builder(
          itemCount: _productController.products.length,
          itemBuilder: (context, index) {
            final product = _productController.products[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    product.imageUrl.isNotEmpty
                        ? Image.network(
                            product.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 70),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName.isNotEmpty
                                ? product.productName
                                : 'Unnamed Product',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Price: \$${product.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Container(
                                  color: Colors.green,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Gap(10),
                              Text(quantity.toString(),
                                  style: const TextStyle(fontSize: 16)),
                              const Gap(10),
                              GestureDetector(
                                onTap: () async {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Container(
                                  color: Colors.green,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                              ),
                              IconButton(
                                onPressed: () async {
                                  await _addToCart(
                                      context, product.id, quantity);
                                },
                                icon: const Icon(Icons.add_shopping_cart),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
