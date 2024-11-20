class UserProfile {

  final String id;
  final String name;
  final String email;
  final String username;
  final String profilePictureUrl;
  final String currency;
  final bool enable2FA;
  final bool receiveNotifications;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePictureUrl,
    required this.currency,
    required this.enable2FA,
    required this.receiveNotifications
  });

}