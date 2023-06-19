import 'movement_type.dart';

class Movement {
  final String userId;
  final int amount;
  final String category;
  final MovementType type;
  DateTime? date;

  Movement({
    required this.userId,
    required this.amount,
    required this.category,
    required this.type,
    this.date,
  });

  //add toMap and fromMap methods
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'amount': amount,
      'category': category,
      'type': type.toString(),
      'date': date,
    };
  }

  factory Movement.fromMap(Map<String, dynamic> map) {
    return Movement(
      userId: map['user_id'],
      amount: map['amount'],
      category: map['category'],
      type: MovementType.values.firstWhere((e) => e.toString() == map['type']),
      date: map['date'],
    );
  }
}
