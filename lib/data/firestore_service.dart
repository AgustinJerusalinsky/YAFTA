import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:logging/logging.dart';
import 'package:yafta/models/movement_type.dart';

final log = Logger('Logger');

//singleton class
class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirestoreService? _instance;
  static FirestoreService get instance {
    _instance ??= FirestoreService();
    return _instance!;
  }

  // add a movement
  Future<void> addMovement(String userId, Movement movement) {
    // add movement to firestore
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .add(movement.toMap())
        .then((value) => log.info("Movement Added"))
        .catchError((error) => log.warning("Failed to add movement: $error"));
  }

  // get movements from user
  Future<List<Movement>> getMovements(String userId,
      {List<MovementType>? types = MovementType.values}) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .where('type', whereIn: types!.map((e) => e.toString()).toList())
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Movement.fromMap(document.data()))
            .toList());
  }

  // get movements from user month to date
  Future<List<Movement>> getMovementsMTD(String userId,
      {List<MovementType>? types = MovementType.values}) {
    DateTime now = DateTime.now();
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .where('type', whereIn: types!.map((e) => e.toString()).toList())
        .where('date', isGreaterThanOrEqualTo: DateTime(now.year, now.month))
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Movement.fromMap(document.data()))
            .toList());
  }

  Future<void> addCategory(String userId, Category category) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .add(category.toMap())
        .then((value) => log.info("Category Added"))
        .catchError((error) => log.warning("Failed to add category: $error"));
  }

  Category categoryFromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    Category c = Category.fromMap(document.data());
    c.categoryId = document.id;
    return c;
  }

  // get categories from user
  Future<List<Category>> getCategories(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => categoryFromDocument(document))
            .toList());
  }
}
