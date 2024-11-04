import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:zneempharmacy/views/checkout%20page/chekout_page.dart';
import '../../model/address model/address_model.dart';
import '../../model/cart model/cart_model.dart';
import '../../services/cart services/cart_services.dart';

class CartScreen extends StatefulWidget {
  final AddressModel? selectedAddress;
  const CartScreen({super.key, this.selectedAddress});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late Future<CartModel> cartItems;

  @override
  void initState() {
    super.initState();
    if (widget.selectedAddress != null) {
      cartItems = CartServices().fetchCart(widget.selectedAddress!.phoneNumber);
    } else {
      log('error on selecting address');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${widget.selectedAddress?.addresseeName ?? "Your Cart"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            _buildCartSummary(),
            const Gap(20),
            Expanded(
              child: FutureBuilder<CartModel>(
                future: cartItems,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return const Center(
                        child: Text('Error fetching cart data'));
                  }
                  final items = snapshot.data!.items;
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return _buildCartItem(item);
                    },
                  );
                },
              ),
            ),
            _buildCheckoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary() {
    return FutureBuilder<CartModel>(
      future: cartItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return const Center(child: Text('Error fetching cart'));
        }

        final cart = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cart Items',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text('Total')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Review your selections before checkout',
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  'AED: \$${cart.totalPrice}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
              )),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.productName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const Gap(20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        'AED: \$${item.price}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Gap(10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              '4.8',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                      const Gap(15),
                      GestureDetector(
                        onTap: () async {
                          final newQuantity = item.quantity + 1 - item.quantity;
                          final result = await CartServices().updateQuantity(
                              cartItemId: item.id,
                              phoneNumber: widget.selectedAddress!.phoneNumber,
                              quantity: newQuantity);
                          log(result);
                          if (result.contains('successfully')) {
                            setState(() {
                              cartItems = CartServices().fetchCart(
                                  widget.selectedAddress!.phoneNumber);
                            });
                          } else {
                            log("Failed to update quantity: $result");
                          }
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
                      Text('${item.quantity}'),
                      const Gap(10),
                      GestureDetector(
                        onTap: () async {
                          if (item.quantity > 1) {
                            final result = await CartServices().reduceQuantity(
                              cartItemId: item.id,
                              phoneNumber: widget.selectedAddress!.phoneNumber,
                            );

                            log(result);
                            if (result.contains('successfully')) {
                              setState(() {
                                cartItems = CartServices().fetchCart(
                                    widget.selectedAddress!.phoneNumber);
                              });
                            } else {
                              log("Failed to reduce quantity: $result");
                            }
                          } else {
                            log("Quantity cannot be less than 1");
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
                      IconButton(
                        onPressed: () async {
                          final result = await CartServices().deletecartitem(
                            itemId: item.id,
                            phoneNumber: widget.selectedAddress!.phoneNumber,
                          );
                          log(result);
                          setState(() {
                            cartItems = CartServices()
                                .fetchCart(widget.selectedAddress!.phoneNumber);
                          });
                        },
                        icon: const Icon(
                          Icons.delete_sharp,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return ElevatedButton(
      onPressed: () async {
        if (widget.selectedAddress != null) {
          final cartData = await cartItems;
          final totalPrice = cartData.totalPrice;
          final totalItems = cartData.items.length;

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                totalPrice: totalPrice,
                totalitems: totalItems,
                selectedAddress: widget.selectedAddress!,
                cartdetails: cartData,
              ),
            ),
          );
        } else {
          log("No address selected for checkout");
        }
      },
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(390, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.green[400],
      ),
      child: const Text(
        'Checkout',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }
}
