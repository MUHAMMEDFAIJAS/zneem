import 'package:flutter/material.dart';
import '../../model/order model/order_model.dart';
import '../../services/order service/order_service.dart';

class OrderScreen extends StatefulWidget {
  final String phoneNumber;

  const OrderScreen({super.key, required this.phoneNumber});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late Future<List<OrderModel>> _ordersFuture;
  final OrderService _orderService = OrderService();

  @override
  void initState() {
    super.initState();
    _ordersFuture = _orderService.fetchAllOrders(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found.'));
          }

          final orders = snapshot.data!;
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              String itemNames =
                  order.items.map((item) => item.productName).join(', ');

              return ListTile(
                // title: Text('Order ID: ${order.id}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items: $itemNames'),
                    Text('Total: AED ${order.totalAmount.toStringAsFixed(2)}'),
                  ],
                ),
                trailing: Text('Status: ${order.status}'),
              );
            },
          );
        },
      ),
    );
  }
}
