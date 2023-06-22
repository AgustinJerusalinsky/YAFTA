import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yafta/data/firestore_service.dart';
import 'package:yafta/models/category.dart';
import 'package:yafta/models/movement_type.dart';
import 'package:yafta/services/movement_provider.dart';
import 'package:yafta/services/budget_provider.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import '../../mocks/provider_mocks.dart';

void main() {
  late FirebaseFirestore fakeFirestore;
  late MockMovementsProvider movementProvider;
  late MockAuthProvider authProvider;
  late BudgetProvider budgetProvider;
  late Category category;
  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    FirestoreService.test(fakeFirestore);

    authProvider = MockAuthProvider();
    authProvider.login("test@yafta.com", "123456789");
    movementProvider = MockMovementsProvider();
    budgetProvider = BudgetProvider(authProvider, movementProvider);
    category = Category(name: "Test", amount: 123, type: MovementType.expense);

    fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .add(category.toMap());
  });

  test("Add category test", () async {
    final prevCategories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) =>
            snapshots.docs.map((e) => Category.fromMap(e.data())));

    expect(prevCategories.length, 1);

    await budgetProvider.addCategory("Test", 123, MovementType.expense);

    final categories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) =>
            snapshots.docs.map((e) => Category.fromMap(e.data())));

    expect(categories.length, prevCategories.length + 1);
    expect(categories.first.name, "Test");
  });

  test("Remove category", () async {
    final prevCategories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) => snapshots.docs.map((e) {
              final category = Category.fromMap(e.data());
              category.categoryId = e.id;
              return category;
            }));

    expect(prevCategories.length, 1);

    await budgetProvider.deleteCategory(prevCategories.first.categoryId!);

    final categories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) =>
            snapshots.docs.map((e) => Category.fromMap(e.data())));

    expect(categories.length, prevCategories.length - 1);
  });

  test("Update category", () async {
    final prevCategories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) => snapshots.docs.map((e) {
              final category = Category.fromMap(e.data());
              category.categoryId = e.id;
              return category;
            }));

    expect(prevCategories.length, 1);

    await budgetProvider.updateCategory(
        prevCategories.first.categoryId!, "New name", 456);

    final categories = await fakeFirestore
        .collection('users')
        .doc(authProvider.user!.uid)
        .collection('categories')
        .get()
        .then((snapshots) =>
            snapshots.docs.map((e) => Category.fromMap(e.data())));

    expect(categories.length, prevCategories.length);
    expect(categories.first.name, "New name");
    expect(categories.first.amount, 456);
  });
}
