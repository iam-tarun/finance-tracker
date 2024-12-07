import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/transaction_model.dart' as t;
import 'package:finance_tracker/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirestoreTransactionRepository {
  final FirebaseFirestore _firestore;

  FirestoreTransactionRepository(this._firestore);


  Future<void> addTransaction(t.Transaction transaction) async {
    await _firestore.collection('Transactions').add(transaction.toMap());
  }

  Future<List<t.Transaction>> fetchTransaction(String userId) async {
    final data = await _firestore.collection('Transactions').where('userId', isEqualTo: userId).get();
    return data.docs.map((d) => t.Transaction.fromMap(d.data())).toList();
  }

}

final transactionRepositoryProvider = Provider<FirestoreTransactionRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreTransactionRepository(firestore);
});