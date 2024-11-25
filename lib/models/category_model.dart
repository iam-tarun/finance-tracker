import 'package:uuid/uuid.dart';

class Category {
  static const uuid = Uuid();
  String id;
  String? userId;
  final String name;
  final String iconPath;

  Category({
    required this.name,
    required this.iconPath,
    this.userId,
    String? id,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'iconPath': iconPath
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      userId: map['userId'],
      name: map['name'],
      iconPath: map['iconPath']
    );
  }
}