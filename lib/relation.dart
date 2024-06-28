class LoginResponse {
  final String id;
  final String message;
  final bool isAuthenticated;
  final String username;
  final String email;
  final String userId;
  final bool emailConfirmed;
  final List<String> roles;
  final String token;
  final DateTime expiresOn;
  final String? imageUrl;

  LoginResponse({
    required this.id,
    required this.message,
    required this.isAuthenticated,
    required this.username,
    required this.email,
    required this.userId,
    required this.emailConfirmed,
    required this.roles,
    required this.token,
    required this.expiresOn,
    this.imageUrl,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    var values;
    return LoginResponse(
      id: json['id'],
      message: json['message'],
      isAuthenticated: json['isAuthenticated'],
      username: json['username'],
      email: json['email'],
      userId: json['userId'],
      emailConfirmed: json['emailConfirmed'],
      roles: List<String>.from(json['roles']['$values']),
      token: json['token'],
      expiresOn: DateTime.parse(json['expiresOn']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_typing_uninitialized_variables
    var values;
    // ignore: prefer_typing_uninitialized_variables
    var $id;
    return {
      'id': id,
      'message': message,
      'isAuthenticated': isAuthenticated,
      'username': username,
      'email': email,
      'userId': userId,
      'emailConfirmed': emailConfirmed,
      'roles': {
        $id: '2',
        '$values': roles,
      },
      'token': token,
      'expiresOn': expiresOn.toIso8601String(),
      'imageUrl': imageUrl,
    };
  }
}