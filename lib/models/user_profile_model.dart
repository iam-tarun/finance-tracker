import 'package:uuid/uuid.dart';

class UserProfile {
  static const uuid = Uuid();
  String id;
  final String name;
  final String email;
  final String username;
  final String profilePictureUrl;
  final String currency;
  final bool enable2FA;
  final bool receiveNotifications;

  UserProfile({
    required this.name,
    required this.email,
    required this.username,
    required this.profilePictureUrl,
    required this.currency,
    required this.enable2FA,
    required this.receiveNotifications,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'name': name,
      'email': email,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'currency': currency,
      'enable2FA': enable2FA,
      'receiveNotifications': receiveNotifications
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['userId'],
      name: map['name'],
      email: map['email'],
      username: map['username'],
      profilePictureUrl: map['profilePictureUrl'],
      currency: map['currency'],
      enable2FA: map['enable2FA'],
      receiveNotifications: map['receiveNotifications']
    );
  }

}