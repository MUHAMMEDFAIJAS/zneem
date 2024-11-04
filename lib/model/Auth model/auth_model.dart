class AuthModel {
  String? name;
  int? pharmacyid;
  String? email;
  String? password;

  AuthModel({
    this.name,
    this.email,
    this.password,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    pharmacyid = json['pharmacy_id'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'pharmacy_id':pharmacyid,
      'email': email,
      'password': password,
    };
  }
}
