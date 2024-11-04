// driver_model.dart

class DriverModel {
  final int id;
  final String driverName;
  final int pharmacyId;
  final String location;
  final String emiratesName;
  final String driverRoute;
  final String vehicleNumber;
  final String mobileNumber;

  DriverModel({
    required this.id,
    required this.driverName,
    required this.pharmacyId,
    required this.location,
    required this.emiratesName,
    required this.driverRoute,
    required this.vehicleNumber,
    required this.mobileNumber,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'],
      driverName: json['driver_name'],
      pharmacyId: json['pharmacy_id'],
      location: json['location'],
      emiratesName: json['emirates_name'],
      driverRoute: json['driver_route'],
      vehicleNumber: json['vehicle_number'],
      mobileNumber: json['mobile_number'],
    );
  }
}
