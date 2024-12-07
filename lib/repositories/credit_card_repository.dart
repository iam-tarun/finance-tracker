import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final creditCardRepositoryProvider = Provider<FirestoreCreditCardRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreCreditCardRepository(firestore);
});

class FirestoreCreditCardRepository {
  final FirebaseFirestore _firestore;

  FirestoreCreditCardRepository(this._firestore);

  Future<void> createNewCreditCard(CreditCard card) async {
    final data = card.toMap();
    await _firestore.collection('CreditCards').add(data);
  }

  Future<List<CreditCard>> fetchCreditCards(String userId) async {
    final data = await _firestore.collection('CreditCards').where('userId', isEqualTo: userId).get();
    return data.docs.map((c) => CreditCard.fromMap(c.data())).toList();
  }

  Future<void> updateCreditCardBalance(CreditCard card) async {
    final data = await _firestore.collection('CreditCards').where("id", isEqualTo: card.id).limit(1).get();
    if(data.docs.isNotEmpty) {
      final docRef = data.docs.first.reference;
      await docRef.update({"balance": card.balance});
    }
    else {
      print("No document found!");
    }
  }

  Future<void> deleteCreditCard(String id) async {
    await _firestore.collection('CreditCards').doc(id).delete();
  }

}