
class PharmacyModel {
  final int id;
  final String pharmacyName;
  final int addressId;

  PharmacyModel({
    required this.id,
    required this.pharmacyName,
    required this.addressId,
  });

  factory PharmacyModel.fromJson(Map<String, dynamic> json) {
    return PharmacyModel(
      id: json['id'],
      pharmacyName: json['pharmacy_name'],
      addressId: json['address_id'],
    );
  }

 @override
  String toString() {
    return 'Pharmacy: $pharmacyName, ID: $id, Address ID: $addressId';
  }
}
