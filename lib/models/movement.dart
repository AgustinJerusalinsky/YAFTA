import 'package:yafta/models/category.dart';

import 'movement_type.dart';

class Movement {
  final double amount;
  final Category category;
  final MovementType type;
  String description;
  DateTime? date;
  String? id;
  DateTime? creationDate;

  Movement({
    required this.amount,
    required this.category,
    required this.type,
    this.description = '',
    this.date,
    this.id,
    this.creationDate,
  });

  //add toMap and fromMap methods
  Map<String, dynamic> toMap({bool create = false}) {
    Map<String, dynamic> map = {
      'amount': amount,
      'category': category.toMap(withId: true),
      'type': type.toString(),
      'description': description,
      'date': date,
    };
    if (create) {
      map['creation_date'] = DateTime.now();
    }
    return map;
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      amount: map['amount'],
      description: map['description'],
      category: Category.fromMap(map['category']),
      type: MovementType.values.firstWhere((e) => e.toString() == map['type']),
      date: map['date']?.toDate(),
      creationDate: map['creation_date']?.toDate(),
    );
  }
}
