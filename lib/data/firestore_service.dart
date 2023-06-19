import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yafta/models/movement.dart';
import 'package:logging/logging.dart';

final log = Logger('ExampleLogger');

//singleton class
class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirestoreService? _instance;
  static FirestoreService get instance {
    _instance ??= FirestoreService();
    return _instance!;
  }

  Future<void> addMovement(Movement movement) {
    //add date to movement
    movement.date = DateTime.now();

    // add movement to firestore
    return firestore
        .collection('movements')
        .add(movement.toMap())
        .then((value) => log.info("Movement Added"))
        .catchError((error) => log.warning("Failed to add movement: $error"));
  }
}
