import 'package:uuid/uuid.dart';

class CreditCard {
  
  static const uuid = Uuid();

  String id;
  String? userId;
  final String name;
  String balance;
  final String creditLimit;
  final String interestRate;
  final String dueDate;
  final double rewards;

  CreditCard({
    required this.name,
    required this.balance,
    required this.creditLimit,
    required this.interestRate,
    required this.dueDate,
    required this.rewards,
    this.userId,
    String? id
  }) : id = id ?? uuid.v4();


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'balance': balance,
      'creditLimit': creditLimit,
      'interestRate': interestRate,
      'dueDate': dueDate,
      'rewards': rewards,
      'id': id,
      'userId': userId
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(name: map['name'], balance: map['balance'], creditLimit: map['creditLimit'], interestRate: map['interestRate'], dueDate: map['dueDate'], rewards: map['rewards'], id: map['id'], userId: map['userId']);
  }

}