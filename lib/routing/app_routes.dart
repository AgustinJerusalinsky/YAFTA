import 'package:go_router/go_router.dart';
import 'package:yafta/main.dart';
import 'package:yafta/screens/auth/signup.dart';

import '../screens/auth/login.dart';
import '../screens/dashboard/home.dart';

class AppRoutes {
  static final home = GoRoute(
    name: "home",
    path: "/",
    routes: [
      login,
      signup,
    ],
    builder: (context, state) => const HomeScreen(),
  );
  static final login = GoRoute(
      name: "login",
      path: "/login",
      builder: (context, state) => const LoginScreen());
  static final signup = GoRoute(
      name: "signup",
      path: "/signup",
      builder: (context, state) => const SignupScreen());
}
