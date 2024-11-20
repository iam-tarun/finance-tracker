class CreditCard {
  
  final String id;
  final String userId;
  final String name;
  final String balance;
  final String creditLimit;
  final String interestRate;
  final String dueDate;
  final double rewards;

  CreditCard({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.creditLimit,
    required this.interestRate,
    required this.dueDate,
    required this.rewards
  });
}