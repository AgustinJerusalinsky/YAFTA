import 'package:flutter/material.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';

import '../data/firestore_service.dart';

class CategoryProvider extends ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService.instance;

  // add category
  Future<void> addCategory(
      String userId, String name, int amount, MovementType type) {
    Category category = Category(name: name, amount: amount, type: type);
    return firestoreService.addCategory(userId, category);
  }

  // get categories
  Future<List<Category>> getCategories(String userId) {
    return firestoreService.getCategories(userId);
  }
}
