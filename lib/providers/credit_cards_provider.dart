import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/repositories/credit_card_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardsNotifier extends AsyncNotifier<List<CreditCard>> {
  
  @override
  Future<List<CreditCard>> build() async{
        final userState = ref.watch(userProvider);
        final userId = userState.value!.id;
        final repo = ref.read(creditCardRepositoryProvider);
        return  await repo.fetchCreditCards(userId);
  }


  Future<void> addCreditCard(CreditCard card) async{
    final userId = ref.read(userProvider.notifier).userId;
    card.userId = userId.toString();
    final repo = ref.read(creditCardRepositoryProvider);
    await repo.createNewCreditCard(card);
    await fetchCreditCards();
  }

  CreditCard? fetchCardById(String id) {
    if (state is AsyncData<List<CreditCard>>) {
      return state.value!.firstWhere((card) => card.id == id, orElse: () => null as CreditCard,);
    }
    return null;
  }

  Future<void> updateCreditCard(CreditCard card) async {
    final repo = ref.read(creditCardRepositoryProvider);
    await repo.updateCreditCardBalance(card);
    await fetchCreditCards();
  }

  Future<void> fetchCreditCards() async {
    final userId = ref.read(userProvider.notifier).userId;
    final repo = ref.read(creditCardRepositoryProvider);
    state = AsyncData(await repo.fetchCreditCards(userId));
  }

  Future<void> removeCard(String cardId) async {
    final repo = ref.read(creditCardRepositoryProvider);
    await repo.deleteCreditCard(cardId);
    await fetchCreditCards();
  }

}

final creditCardsProvider = AsyncNotifierProvider<CreditCardsNotifier, List<CreditCard>>(() => CreditCardsNotifier());