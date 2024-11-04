class AddressModel {
   int? adressid;
  final String addresseeName;
  final String buildingNameOrNumber;
  final String streetNameOrNumber;
  final String areaOrNeighborhood;
  final String city;
  final String emirate;
  final String postalCode;
  final String poBox;
  final String country;
  final String phoneNumber;

  AddressModel({
     this.adressid,
    required this.addresseeName,
    required this.buildingNameOrNumber,
    required this.streetNameOrNumber,
    required this.areaOrNeighborhood,
    required this.city,
    required this.emirate,
    required this.postalCode,
    required this.poBox,
    required this.country,
    required this.phoneNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      adressid: json['id'],
      addresseeName: json['addressee_name'],
      buildingNameOrNumber: json['building_name_or_number'],
      streetNameOrNumber: json['street_name_or_number'],
      areaOrNeighborhood: json['area_or_neighborhood'],
      city: json['city'],
      emirate: json['emirate'],
      postalCode: json['postal_code'],
      poBox: json['po_box'],
      country: json['country'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id':adressid,
      'addressee_name': addresseeName,
      'building_name_or_number': buildingNameOrNumber,
      'street_name_or_number': streetNameOrNumber,
      'area_or_neighborhood': areaOrNeighborhood,
      'city': city,
      'emirate': emirate,
      'postal_code': postalCode,
      'po_box': poBox,
      'country': country,
      'phone_number': phoneNumber,
    };
  }
}
