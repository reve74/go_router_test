import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_actual/model/user_model.dart';
import 'package:go_router_actual/screen/1_screen.dart';
import 'package:go_router_actual/screen/2_screen.dart';
import 'package:go_router_actual/screen/3_screen.dart';
import 'package:go_router_actual/screen/error_screen.dart';
import 'package:go_router_actual/screen/home_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authStateProvider = AuthNotifier(ref: ref);

  return GoRouter(
    initialLocation: '/',
    errorBuilder: (context, state) {
      return ErrorScreen(
        error: state.error.toString(),
      );
    },
    // redirect
    // refresh
    routes: authStateProvider._routes,
  );
});

class AuthNotifier extends ChangeNotifier {
  final Ref ref;

  AuthNotifier({
    required this.ref,
  }) {
    ref.listen<UserModel?>(
      userProvider,
      (previous, next) {
        if(previous != next) {
          notifyListeners();
        }
      },
    );
  }

  List<GoRoute> get _routes => [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeScreen(),
          routes: [
            GoRoute(
              path: 'one',
              builder: (context, state) => OneScreen(),
              routes: [
                GoRoute(
                  path: 'two',
                  builder: (context, state) => TwoScreen(),
                  routes: [
                    // http:// ..../one/two/three
                    GoRoute(
                      path: 'three',
                      name: ThreeScreen.routeName,
                      builder: (context, state) => ThreeScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ];
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserModel?>(
  (ref) => UserStateNotifier(),
);

// 로그인한 상태면 UserModel 인스턴스 상태로 넣어주기
// 로그아웃 상태면 null 상태로 넣어주
class UserStateNotifier extends StateNotifier<UserModel?> {
  UserStateNotifier() : super(null);

  login({
    required String name,
  }) {
    state = UserModel(name: name);
  }

  logout() {
    state = null;
  }
}
