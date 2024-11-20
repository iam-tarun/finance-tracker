import 'package:finance_tracker/models/transaction_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([]);
  
  void addTransaction(Transaction transaction) {
    
    state = [...state, transaction];
  }

  void removeTransaction(String id) {
    state = state.where((transaction) => transaction.id != id).toList();
  }

}

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) => TransactionNotifier());

final recentTransactionsProvider = Provider<List<Transaction>>((ref) {
  final transactions = ref.watch(transactionProvider);
  return transactions.length <= 3 ? transactions : transactions.sublist(transactions.length - 3);
});

final totalExpensesProvider = Provider<double>((ref) {
  final transactions = ref.watch(transactionProvider);
  return transactions.map((t) => t.amount).fold(0.0, ((v, t) => v+t));
});