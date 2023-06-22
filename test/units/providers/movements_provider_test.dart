import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import '../../mocks/provider_mocks.dart';

void main() {
  late FirebaseFirestore fakeFirestore;
  late MovementProvider movementProvider;
  late MockAuthProvider authProvider;
  late Category testCategory;
  late Category inexistentCategory;
  late Movement testMovement;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    FirestoreService.test(fakeFirestore);

    authProvider = MockAuthProvider();
    authProvider.login("test@yafta.com", "123456789");
    movementProvider = MovementProvider(authProvider);

    testCategory =
        Category(name: "Test", amount: 1000, type: MovementType.expense);
    inexistentCategory =
        Category(name: "Inexistent", amount: 1000, type: MovementType.expense);

    testMovement = Movement(
        amount: 100,
        category: testCategory,
        description: "Test",
        type: MovementType.expense,
        date: DateTime.now());

    testCategory = await FirestoreService.instance
        .addCategory(authProvider.user!.uid, testCategory);

    await FirestoreService.instance
        .addMovement(authProvider.user!.uid, testMovement);
  });

  test("Add movement test", () async {
    int prevLength = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('movements')
        .get()
        .then((snapshots) => snapshots.docs.length);

    await movementProvider.addMovement(
        100, testCategory, "Test", MovementType.expense, DateTime.now());

    expect(movementProvider.expensesShouldFetch, true);
    int postLength = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('movements')
        .get()
        .then((snapshots) => snapshots.docs.length);
    expect(postLength, prevLength + 1);
  });

  test("Add movement test to inexistent category", () async {
    expect(
        () async => await movementProvider.addMovement(100, inexistentCategory,
            "Test", MovementType.expense, DateTime.now()),
        throwsException);
  });

  test("Delete movement test", () async {
    List<Movement> movements =
        await FirestoreService.instance.getMovements(authProvider.user!.uid);
    int prevLength = movements.length;
    await movementProvider.deleteMovement(movements[0].id!);
    movements =
        await FirestoreService.instance.getMovements(authProvider.user!.uid);
    int postLength = movements.length;
    expect(postLength, prevLength - 1);
  });
}
