import 'package:yafta/models/movement_type.dart';

class Category {
  final String name;
  final int amount;
  final MovementType type;
  String? categoryId;

  Category({
    required this.name,
    required this.amount,
    required this.type,
    this.categoryId,
  });

  Map<String, dynamic> toMap({bool withId = false}) {
    Map<String, dynamic> map = {
      'name': name,
      'amount': amount,
      'type': type.toString(),
    };
    if (withId) {
      map['category_id'] = categoryId;
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
    );
  }
}
