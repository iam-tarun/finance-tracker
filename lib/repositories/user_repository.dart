import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/user_profile_model.dart';
import 'package:finance_tracker/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<FirestoreUserRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreUserRepository(firestore);
});

class FirestoreUserRepository {
  final FirebaseFirestore _firestore;

  FirestoreUserRepository(this._firestore);

  // create new User
  Future<void> addUser(UserProfile user) async {

    await _firestore.collection('users')
      .add(user.toMap());
  }

  // getUser
  Future<UserProfile> getUser(String email) async {
    final data = await _firestore.collection('users').where("email", isEqualTo: email).get();
    if (data.docs.length == 1) {
      return UserProfile.fromMap(data.docs[0].data());
    } else {
      throw Exception('User not found');
    }
  }

}