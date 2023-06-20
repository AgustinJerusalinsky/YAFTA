import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:logging/logging.dart';
import 'package:yafta/models/movement_type.dart';

final log = Logger('ExampleLogger');

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
    //add date to movement
    movement.date = DateTime.now();

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

  Future<void> addCategory(String userId, Category category) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .add(category.toMap())
        .then((value) => log.info("Category Added"))
        .catchError((error) => log.warning("Failed to add category: $error"));
  }

  // get categories from user
  Future<List<Category>> getCategories(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => Category.fromMap(document.data()))
            .toList());
  }
}
