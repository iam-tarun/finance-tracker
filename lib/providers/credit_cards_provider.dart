import 'package:finance_tracker/models/credit_card_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditCardsNotifier extends StateNotifier<List<CreditCard>> {
  CreditCardsNotifier() : super([]);

  void addCreditCard(CreditCard card) {
    state = [...state, card];
  }

  void removeCard(CreditCard card) {
    state = state.where((c) => c.id != card.id).toList();
  }

}

final creditCardsProvider = StateNotifierProvider<CreditCardsNotifier, List<CreditCard>>((ref) => CreditCardsNotifier());