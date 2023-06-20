import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/movement_type.dart';

enum EventType { add_expense, add_income, new_budget, signup_email }

extension EventName on EventType {
  String get name {
    switch (this) {
      case EventType.add_expense:
        return 'add_expense';
      case EventType.add_income:
        return 'add_income';
      case EventType.new_budget:
        return 'new_budget';
      case EventType.signup_email:
        return 'signup_email';
    }
  }
}

class AnalyticsHandler {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static Future<void> logMovement(
      {required final MovementType movementType,
      required final double value}) async {
    await _analytics.logEvent(
      name: movementType == MovementType.expense
          ? EventType.add_expense.name
          : EventType.add_income.name,
      parameters: <String, dynamic>{
        'value': value,
      },
    );
  }

  static Future<void> logNewBudget(
      {required final String budgetName,
      required final String budgetAmount}) async {
    await _analytics.logEvent(
      name: EventType.new_budget.name,
      parameters: <String, dynamic>{
        'budget_name': budgetName,
        'budget_amount': budgetAmount,
      },
    );
  }

  static Future<void> logSignup() async {
    await _analytics.logSignUp(signUpMethod: 'email');
  }
}
