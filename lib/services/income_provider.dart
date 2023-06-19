import 'package:flutter/material.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

class IncomeProvider extends ChangeNotifier {
  // FirestoreService instance
  final FirestoreService firestoreService = FirestoreService.instance;

  // add movement
  Future<void> addIncome(userId, amount, category) {
    //add date to movement
    Movement movement = Movement(
      userId: userId,
      amount: amount,
      category: category,
      type: MovementType.income,
    );

    // add movement to firestore
    return firestoreService.addMovement(movement);
  }
}
