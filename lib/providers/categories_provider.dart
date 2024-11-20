import 'package:finance_tracker/models/category_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesNotifier extends StateNotifier<List<Category>> {
  CategoriesNotifier() : super([]);

  void addCategory(Category category) {
    state = [...state, category];
  }

  void removeCategory(Category category) {
    state = state.where((c) => c.id != category.id).toList();
  }

}

final categoriesProvider = StateNotifierProvider<CategoriesNotifier, List<Category>>((ref) => CategoriesNotifier());