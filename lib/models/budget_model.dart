class Budget {
  final String id;
  final String category;
  final String allocatedAmount;
  final String spentAmount;
  final String period;

  Budget({
    required this.id,
    required this.category,
    required this.allocatedAmount,
    required this.spentAmount,
    required this.period
  });
}