import 'package:yafta/models/movement_type.dart';

class Category {
  final String name;
  final double amount;
  final MovementType type;
  String? categoryId;
  final DateTime? creationDate;

  Category({
    required this.name,
    required this.amount,
    required this.type,
    this.categoryId,
    this.creationDate,
  });

  Map<String, dynamic> toMap({bool withId = false, bool create = false}) {
    Map<String, dynamic> map = {
      'name': name,
      'amount': amount,
      'type': type.toString(),
    };
    if (withId) {
      map['category_id'] = categoryId;
    }
    if (create) {
      map['creation_date'] = DateTime.now();
    }
    return map;
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      amount: map['amount'],
      type: MovementType.values.firstWhere(
        (element) => element.toString() == map['type'],
      ),
      categoryId: map['category_id'],
      creationDate: map['creation_date']?.toDate(),
    );
  }
}
