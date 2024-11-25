import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider<FirestoreCategoryRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreCategoryRepository(firestore);
});

class FirestoreCategoryRepository {
  final FirebaseFirestore _firestore;

  FirestoreCategoryRepository(this._firestore);

  Future<void> addCategory(Category category) async {
    await _firestore.collection('Categories').add(category.toMap());
  }

  Future<List<Category>> fetchCategories(String userId) async {
    final data = await _firestore.collection('Categories').where('userId', isEqualTo: userId).get();
    if (data.docs.isNotEmpty) {
      return data.docs.map((c) => Category.fromMap(c.data())).toList();
    }
    else {
      return [];
    }
  }

  Future<void> deleteCategory(String id) async {
    await _firestore.collection('Categories').doc(id).delete();
  }

}