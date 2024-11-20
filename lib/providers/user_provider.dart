import 'package:finance_tracker/models/user_profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final UserProfile  user = UserProfile(id: 'user1', name: 'tarun', email: 'o.taruntejaa@gmail.com', username: 'tarunteja2810', profilePictureUrl: 'url', currency: 'dollar', enable2FA: true, receiveNotifications: true);

final userProvider = StateProvider((ref) => user);