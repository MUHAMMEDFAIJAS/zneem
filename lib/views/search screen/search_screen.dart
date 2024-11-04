import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zneempharmacy/services/cart%20services/cart_services.dart';
import '../../controller/cart_controller.dart';
import '../../model/address model/address_model.dart';
import '../../services/product service/product_service.dart';
import '../../model/product model/product_model.dart';

class SearchScreen extends StatefulWidget {
  final AddressModel? selectedAddress;
  const SearchScreen({super.key, this.selectedAddress});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductService _productService = ProductService();
  final CartServices cartservice = CartServices();
  final StreamController<String> _searchStreamController =
      StreamController<String>();
  final CartController cartController = Get.put(CartController());

  AddressModel? selectedAddress;
  @override
  void initState() {
    super.initState();
    selectedAddress = widget.selectedAddress;
    _searchController.addListener(() {
      _searchStreamController.add(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchStreamController.close();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for products',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _searchStreamController.stream
            .asyncMap(_productService.searchProducts),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch search results'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found'));
          } else {
            final searchResults = snapshot.data!;
            return ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final product = searchResults[index];
                return _buildProductCard(product);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildProductCard(ProductModel product) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            overflow: TextOverflow.ellipsis)),
                    Text('Rs ${product.price}',
                        style: TextStyle(color: Colors.grey[600])),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            color: Colors.green,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Gap(10),
                        Text('${"item.quantity"}'),
                        const Gap(10),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            color: Colors.green,
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () => _addToCart(context, product.id),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToCart(BuildContext context, int productId) async {
    if (selectedAddress != null) {
      await cartController.addToCart(
        productId,
        selectedAddress!.phoneNumber,
        selectedAddress!,
      );
      cartservice.addToCart(
        productId: productId,
        phoneNumber: selectedAddress!.phoneNumber,
        address: selectedAddress!,
      );

      Get.snackbar(
        'Cart',
        'Product added to cart!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        'Error',
        'Please select an address before adding to cart.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
