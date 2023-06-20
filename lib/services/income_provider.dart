import 'package:flutter/material.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

class IncomeProvider extends ChangeNotifier {
  // FirestoreService instance
  final FirestoreService firestoreService = FirestoreService.instance;

  // add income
  Future<void> addIncome(userId, amount, category, description) {
    //add date to income
    Movement movement = Movement(
      amount: amount,
      category: category,
      type: MovementType.income,
    );

    // add movement to firestore
    return firestoreService.addMovement(userId, movement);
  }

  // get incomes
  Future<List<Movement>> getIncomes(userId) {
    return firestoreService.getMovements(userId, types: [MovementType.income]);
  }
}
