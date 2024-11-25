import 'package:finance_tracker/models/category_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/repositories/category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = AsyncNotifierProvider<CategoriesNotifier, List<Category>>(() => CategoriesNotifier(),);


class CategoriesNotifier extends AsyncNotifier<List<Category>> {
  
  @override
  Future<List<Category>> build() async{
    
      final userState = ref.watch(userProvider);

    
      final userId = userState.value!.id;
      final repo = ref.read(categoryRepositoryProvider);
      return await repo.fetchCategories(userId);
    
  }

  Future<void> fetchCategories() async {
    try {
      final userId = ref.read(userProvider.notifier).userId;
      final repo = ref.read(categoryRepositoryProvider);
      final categories = await repo.fetchCategories(userId);
      state = AsyncData(categories);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> createCategory(Category category) async {
    try {
      final userId = ref.read(userProvider.notifier).userId;
      final repo = ref.read(categoryRepositoryProvider);
      category.userId = userId.toString();
      await repo.addCategory(category);
      await fetchCategories();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
