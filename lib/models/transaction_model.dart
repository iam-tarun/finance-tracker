class Transaction {
  
  Transaction({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.cardId,
    required this.description,
    required this.date,
    required this.amount,
  });

  final String id;
  final String userId;
  final String categoryId;
  final String cardId;
  final String description;
  final String date;
  final num amount;

}