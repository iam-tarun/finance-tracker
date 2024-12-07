import 'package:uuid/uuid.dart';

class Transaction {
  
  Transaction({
    required this.categoryId,
    required this.cardId,
    required this.description,
    required this.date,
    required this.amount,
    this.userId,
    String? id
  }) : id = id ?? uuid.v4();

  static const uuid = Uuid();

  String id;
  String? userId;
  final String categoryId;
  final String cardId;
  final String description;
  final String date;
  final num amount;

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'categoryId': categoryId,
      'cardId': cardId,
      'date': date,
      'amount': amount,
      'id': id,
      'userId': userId
    };
  }

  factory Transaction.fromMap(Map<String, dynamic>  map) {
    return Transaction(
      categoryId: map['categoryId'],
      cardId: map['cardId'],
      description: map['description'],
      date: map['date'],
      amount: map['amount'],
      userId: map['userId'],
      id: map['id']
    );
  }

}