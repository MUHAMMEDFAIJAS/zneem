import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/driver model/driver_model.dart';
import '../../services/authentication services/auth_service.dart';
import '../../services/driver service/driver_service.dart';

class DriverListPage extends StatefulWidget {
  const DriverListPage({super.key});

  @override
  DriverListPageState createState() => DriverListPageState();
}

class DriverListPageState extends State<DriverListPage> {
  late Future<List<DriverModel>> _driversFuture;

  @override
  void initState() {
    super.initState();
    _driversFuture = _fetchDrivers();
  }

  Future<List<DriverModel>> _fetchDrivers() async {
    final authService = AuthService();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken') ?? '';

    if (token.isEmpty) {
      throw Exception('User not authenticated');
    }

    final driverService = DriverService();
    return driverService.fetchDrivers(token);
  }

  void _showDriverDialog(DriverModel driver) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Driver'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(driver.driverName),
              Text(driver.driverRoute),
              Text(driver.mobileNumber),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(driver); 
              },
              child: const Text('Select'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    ).then((selectedDriver) {
      if (selectedDriver != null) {
        Navigator.pop(context, selectedDriver);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drivers')),
      body: FutureBuilder<List<DriverModel>>(
        future: _driversFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No drivers found'));
          }

          final drivers = snapshot.data!;
          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              final driver = drivers[index];
              return ListTile(
                title: Text(driver.driverName),
                subtitle: Text(
                    'Route: ${driver.driverRoute}\nPhone: ${driver.mobileNumber}'),
                onTap: () => _showDriverDialog(driver), 
              );
            },
          );
        },
      ),
    );
  }
}
