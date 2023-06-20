import 'package:flutter/material.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

class MovementProvider extends ChangeNotifier {
  // FirestoreService instance
  final FirestoreService firestoreService = FirestoreService.instance;

  // add movement
  Future<void> addMovement(String userId, int amount, Category category,
      String description, MovementType type, DateTime date) {
    //add date to movement
    Movement movement = Movement(
      amount: amount,
      description: description,
      category: category,
      type: type,
      date: date,
    );

    // add movement to firestore
    return firestoreService.addMovement(userId, movement);
  }

  // add income
  Future<void> addIncome(
      String userId, int amount, Category category, String description) {
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
