class LoginResponseModel {
  final String? email;
  final String? username;
  final String? phone;
  final String? uid;

  LoginResponseModel({
    required this.email,
    required this.username,
    required this.phone,
    required this.uid,
  });
  factory LoginResponseModel.fomJson(Map<String, dynamic>? data) {
    return LoginResponseModel(
      email: data?['email'],
      username: data?['username'],
      phone: data?['phone'],
      uid: data?['uid'],
    );
  }
}
