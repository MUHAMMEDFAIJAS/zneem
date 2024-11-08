class AuthModel {
  String? pharmacyName;
  int? pharmacyId;
  String? email;
  String? password;

  AuthModel({
    this.pharmacyName,
    int? pharmacyId,
    this.email,
    this.password,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    pharmacyName = json['Pharmacy Name '];
    pharmacyId = json['pharmacistID'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Pharmacy Name ': pharmacyName,
      'pharmacistID': pharmacyId,
      'email': email,
      'password': password,
    };
  }
}
