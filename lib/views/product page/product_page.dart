// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../controller/product_controller.dart';
// import '../details page/details_page.dart';

// class ProductPage extends StatelessWidget {
//   final int categoryId;
//   final ProductController _productController = Get.put(ProductController());

//   ProductPage({Key? key, required this.categoryId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     _productController.fetchProducts(categoryId);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products in Category $categoryId'),
//       ),
//       body: Obx(() {
//         if (_productController.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (_productController.errorMessage.isNotEmpty) {
//           return Center(child: Text(_productController.errorMessage.value));
//         } else if (_productController.products.isEmpty) {
//           return const Center(child: Text('No products found.'));
//         }

//         return ListView.builder(
//           itemCount: _productController.products.length,
//           itemBuilder: (context, index) {
//             final product = _productController.products[index];
//             return GestureDetector(
//               onTap: () {
//                 Get.to(() => DetailsPage(
//                       productId: product.id,
//                       categoryName: product.productName,
//                       description: product.description,
//                       imageUrl: product.imageUrl,
//                       companyId: product.companyId,
//                     ));
//               },
//               child: Card(
//                 elevation: 4,
//                 margin: const EdgeInsets.all(8.0),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product Image
//                       product.imageUrl.isNotEmpty
//                           ? Image.network(
//                               product.imageUrl,
//                               width: 100,
//                               height: 100,
//                               fit: BoxFit.cover,
//                             )
//                           : const Icon(
//                               Icons.image_not_supported,
//                               size: 100,
//                             ),
//                       const SizedBox(width: 16.0),
//                       // Product Details
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               product.productName.isNotEmpty
//                                   ? product.productName
//                                   : 'Unnamed Product',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Text(
//                               product.description,
//                               style: const TextStyle(color: Colors.grey),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 8.0),
//                             Text(
//                               'Price: \$${product.price.toStringAsFixed(2)}',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black),
//                             ),
//                             const SizedBox(height: 8.0),
//                             Text(
//                               'Company ID: ${product.companyId}',
//                               style: const TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

// converted to listview

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../controller/address_controller.dart';
import '../../controller/cart_controller.dart';
import '../../controller/product_controller.dart';
import '../../model/address model/address_model.dart';
import '../../model/cart model/cart_model.dart';
import '../../services/cart services/cart_services.dart';

class ProductPage extends StatefulWidget {
  final int categoryId;
  final AddressModel selectedAddress;
  final int productId;

  ProductPage(
      {Key? key,
      required this.categoryId,
      required this.selectedAddress,
      required this.productId})
      : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final AddressController addressController = Get.put(AddressController());
  final ProductController _productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  late Future<CartModel> cartItems;
  final CartServices cartservice = CartServices();

  @override
  void initState() {
    super.initState();
    cartItems = CartServices().fetchCart(widget.selectedAddress.phoneNumber);
    _productController.fetchProducts(widget.categoryId);
  }

  Future<void> _addToCart(BuildContext context, int productid) async {
    try {
      await cartController.addToCart(
        widget.productId,
        widget.selectedAddress.phoneNumber,
        widget.selectedAddress,
      );
      cartservice.addToCart(
          productId: productid,
          phoneNumber: widget.selectedAddress.phoneNumber,
          address: widget.selectedAddress);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to cart successfully!')),
      );

      setState(() {
        cartItems =
            CartServices().fetchCart(widget.selectedAddress.phoneNumber);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add to cart: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        : const Icon(
                            Icons.image_not_supported,
                            size: 70,
                          ),
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
                          const SizedBox(height: 8.0),
                          Text(
                            'Company ID: ${product.companyId}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Gap(20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('AED: \$${product.price}'),
                              const Gap(10),
                              GestureDetector(
                                onTap: () async {
                        
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
                              const Text('quantity'),
                              const Gap(10),
                              GestureDetector(
                                onTap: () async {
                                 
                                },
                                child: Container(
                                  color: Colors.green,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                         
                       
                              const Gap(20),
                              IconButton(
                                  onPressed: () async {
                                    await _addToCart(context, product.id);
                                    
                        
                                  },
                                  icon: Icon(Icons.add_shopping_cart)),

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
