class LoginResponseMode {
  final String? email;
  final String? username;
  final String? phone;
  final String? uid;

  LoginResponseMode({
    required this.email,
    required this.username,
    required this.phone,
    required this.uid,
  });
  factory LoginResponseMode.fomJson(Map<String, dynamic>? data) {
    return LoginResponseMode(
      email: data?['email'],
      username: data?['username'],
      phone: data?['phone'],
      uid: data?['uid'],
    );
  }
}
