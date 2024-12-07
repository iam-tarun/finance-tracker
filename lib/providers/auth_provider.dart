import 'package:finance_tracker/providers/categories_provider.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/providers/transaction_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final authStateProvider = StreamProvider.autoDispose<User?>((ref) {

  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return firebaseAuth.authStateChanges();

});


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  return AuthRepository(firebaseAuth);
});

class AuthRepository {

  final FirebaseAuth _auth;

  AuthRepository(this._auth);

  Future<String?> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException  catch (e) {
      return e.message;
    }
  }

  Future<String?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut(WidgetRef ref) async {
    await _auth.signOut();
    ref.invalidate(authStateProvider);
    ref.invalidate(creditCardsProvider);
    ref.invalidate(transactionProvider);
    ref.invalidate(categoriesProvider);
    ref.invalidate(userProvider);
  }

  Future<void> refreshUserToken() async {
    await _auth.currentUser?.getIdToken(true);
  }

  String? getLoggedInUserEmail() {
    final user = _auth.currentUser;
    return user?.email;
  }

}

