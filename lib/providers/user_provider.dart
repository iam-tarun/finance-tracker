import 'package:finance_tracker/models/user_profile_model.dart';
import 'package:finance_tracker/providers/auth_provider.dart';
import 'package:finance_tracker/repositories/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = AsyncNotifierProvider<UserNotifier, UserProfile?>(() => UserNotifier(),);

class UserNotifier extends AsyncNotifier<UserProfile?>{

  @override
  Future<UserProfile?> build() async {
    try {
      final auth_repo = ref.read(authRepositoryProvider);
      final repo = ref.read(userRepositoryProvider);
      final email = auth_repo.getLoggedInUserEmail();
      if (email != null) {
        return await repo.getUser(email);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }

    return null;
  }


  Future<void> getUser(String email) async {
    try {
      state = AsyncLoading();
      final repo = ref.read(userRepositoryProvider);
      final user = await repo.getUser(email);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }

  }

  Future<void> addUser(UserProfile user) async {
    try {
      final repo = ref.read(userRepositoryProvider);
      await repo.addUser(user);
      state = AsyncData(user);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
    
  }

  get userId {
    return state.value?.id;
  }


}