class SignupRequestModel {
  final String username;
  final String phone;
  final String email;
  final String uid;

  SignupRequestModel({
    required this.username,
    required this.phone,
    required this.email,
    required this.uid,
  });
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "phone": phone,
      "email": email,
      "uid": uid,
    };
  }
}
