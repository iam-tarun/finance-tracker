import 'package:finance_tracker/models/transaction_model.dart';
import 'package:finance_tracker/providers/credit_cards_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/repositories/transaction_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TransactionNotifier extends AsyncNotifier<List<Transaction>> {
  @override
  Future<List<Transaction>> build() async {
    final userState = ref.watch(userProvider);
    if (userState is! AsyncData || userState.value == null) {
      return [];
    }
    final userId = userState.value!.id;
    final repo = ref.read(transactionRepositoryProvider);
    return await repo.fetchTransaction(userId);
  }

  Future<void> addTransaction(Transaction transaction) async {
    final userId = ref.read(userProvider.notifier).userId;
    if (userId == null) {
      throw Exception('User ID not available.');
    }

    // Update credit card balance
    final card = ref.read(creditCardsProvider.notifier).fetchCardById(transaction.cardId);
    if (card == null) {
      throw Exception('Card not found for ID: ${transaction.cardId}');
    }
    card.balance = (double.parse(card.balance) + transaction.amount).toString();
    await ref.read(creditCardsProvider.notifier).updateCreditCard(card);

    // Add transaction
    transaction.userId = userId;
    final repo = ref.read(transactionRepositoryProvider);
    await repo.addTransaction(transaction);
    await fetchTransactions(); // Refresh transactions
  }

  Future<void> fetchTransactions() async {
    final userId = ref.read(userProvider.notifier).userId;
    if (userId == null) {
      throw Exception('User ID not available.');
    }
    final repo = ref.read(transactionRepositoryProvider);
    state = AsyncData(await repo.fetchTransaction(userId));
  }
}

final transactionProvider = AsyncNotifierProvider<TransactionNotifier, List<Transaction>>(() => TransactionNotifier());

final recentTransactionsProvider = Provider<List<Transaction>>((ref) {
  final transactions = ref.watch(transactionProvider);
  if (transactions is AsyncError || transactions.value == null) {
    return [];
  }
  return transactions.value!.length <= 3
      ? transactions.value!
      : transactions.value!.sublist(transactions.value!.length - 3);
});

final totalExpensesProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionProvider);
  if (transactions is AsyncError || transactions.value == null) {
    return 0.0;
  }
  return transactions.value!.map((t) => t.amount).fold(0.0, ((v, t) => v + t));
});
