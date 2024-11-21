import 'package:firebase_auth/firebase_auth.dart';

Future<void> signInWithEmail(String email, String password) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signUpWithEmail(String email, String password) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
