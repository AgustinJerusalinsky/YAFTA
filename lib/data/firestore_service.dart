import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/exceptions/category_exists_exception.dart';
import 'package:yafta/models/movement.dart';
import 'package:logging/logging.dart';
import 'package:yafta/models/movement_type.dart';

final log = Logger('Logger');

//singleton class
class FirestoreService {
  late FirebaseFirestore firestore;

  FirestoreService() {
    firestore = FirebaseFirestore.instance;
  }

  FirestoreService.test(this.firestore) {
    _instance = this;
  }

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
        .add(movement.toMap(create: true))
        .then((value) => log.info("Movement Added"))
        .catchError((error) => log.warning("Failed to add movement: $error"));
  }

  Future<void> deleteMovement(String userId, String movementId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .doc(movementId)
        .delete()
        .then((value) => log.info("Movement Deleted"))
        .catchError(
            (error) => log.warning("Failed to delete movement: $error"));
  }

  Future<void> deleteAllMovementsFromCategory(
      String userId, String categoryId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .where('category.category_id', isEqualTo: categoryId)
        .get()
        .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        })
        .then((value) => log.info("Movements Deleted"))
        .catchError(
            (error) => log.warning("Failed to delete movements: $error"));
  }

  Movement movementFromDocument(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    Movement m = Movement.fromMap(document.data());
    m.id = document.id;
    return m;
  }

  // get movements from user
  Future<List<Movement>> getMovements(String userId,
      {List<MovementType>? types = MovementType.values}) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .where('type', whereIn: types!.map((e) => e.toString()).toList())
        .orderBy("date", descending: true)
        .orderBy("creation_date", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => movementFromDocument(document))
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
        .orderBy("date", descending: true)
        .orderBy("creation_date", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => movementFromDocument(document))
            .toList());
  }

  //get movements today
  Future<List<Movement>> getMovementsWeek(String userId,
      {List<MovementType>? types = MovementType.values}) {
    DateTime now = DateTime.now();
    return firestore
        .collection('users')
        .doc(userId)
        .collection('movements')
        .where('type', whereIn: types!.map((e) => e.toString()).toList())
        .where('date',
            isGreaterThanOrEqualTo: DateTime(now.year, now.month, now.day - 7))
        .orderBy("date", descending: true)
        .orderBy("creation_date", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => movementFromDocument(document))
            .toList());
  }

  Future<Category> addCategory(String userId, Category category) async {
    // check if category already exists for user

    var categoryExists = await firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .where('name', isEqualTo: category.name)
        .where('type', isEqualTo: category.type.toString())
        .get();

    if (categoryExists.docs.isNotEmpty) {
      log.warning("Category already exists");
      throw CategoryAlreadyExistsException("Category already exists");
    }

    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .add(category.toMap(create: true))
        .then((value) {
          log.info("Category Added");
          return value.get();
        })
        .then((value) => categoryFromDocument(value))
        .catchError((error) {
          log.warning("Failed to add category: $error");
          throw error;
        });
  }

  Future<void> deleteCategory(String userId, String categoryId) async {
    await deleteAllMovementsFromCategory(userId, categoryId);
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete()
        .then((value) => log.info("Category Deleted"))
        .catchError(
            (error) => log.warning("Failed to delete category: $error"));
  }

  Category categoryFromDocument(
      DocumentSnapshot<Map<String, dynamic>> document) {
    Category c = Category.fromMap(document.data()!);
    c.categoryId = document.id;
    return c;
  }

  // get categories from user
  Future<List<Category>> getCategories(String userId) {
    return firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .orderBy("creation_date", descending: true)
        .get()
        .then((snapshot) => snapshot.docs
            .map((document) => categoryFromDocument(document))
            .toList());
  }

  Future<void> updateCategory(
      uid, String categoryId, String name, double amount) async {
    //update category
    await firestore
        .collection('users')
        .doc(uid)
        .collection('categories')
        .doc(categoryId)
        .update({'name': name, 'amount': amount})
        .then((value) => log.info("Category Updated"))
        .catchError(
            (error) => log.warning("Failed to update category: $error"));

    //update category in movements
    return firestore
        .collection('users')
        .doc(uid)
        .collection('movements')
        .where('category.category_id', isEqualTo: categoryId)
        .get()
        .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.update({'category.name': name});
          }
        })
        .then((value) => log.info("Category Updated"))
        .catchError(
            (error) => log.warning("Failed to update category: $error"));
  }
}
