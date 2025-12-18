import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../modules/Categories/View/categories_view.dart';
import '../modules/Expenses/View/expenses_screen.dart';
import '../modules/Home/home_screen.dart';
import '../modules/Income/View/income_screen.dart';
import '../modules/MainLayout/main_layout.dart';
import '../modules/Profile/profile_screen.dart';
import '../modules/Splash/splash_screen.dart';
import '../modules/auth/View/auth_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    ///==============>> [Splash]
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const SplashScreen(),
      ),
    ),

    ///==============>> [login]

    GoRoute(
      path: '/${AuthScreen.routerName}',
      name: AuthScreen.routerName,
      pageBuilder: (context, state) => _buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: const AuthScreen(),
      ),
    ),

    ///==============>> [ShellRoute]
    ShellRoute(
      pageBuilder: (context, state, child) {
        return _buildPageWithDefaultTransition(
          context: context,
          state: state,
          child: MainLayout(
            routeName: state.fullPath!,
            child: child,
          ),
        );
      },
      routes: [
        ///==============>> [Home]
        GoRoute(
          path: '/${HomeScreen.routerName}',
          name: HomeScreen.routerName,
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const HomeScreen(),
          ),
        ),

        ///==============>> [Wallet]
        GoRoute(
          path: '/${ExpensesScreen.routerName}',
          name: ExpensesScreen.routerName,
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ExpensesScreen(),
          ),
        ),

        ///==============>> [Profile]
        GoRoute(
          path: '/${ProfileScreen.routerName}',
          name: ProfileScreen.routerName,
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ProfileScreen(),
          ),
        ),

        ///==============>> [categores_Screen]
        GoRoute(
          path: '/${CategoriesScreen.routerName}',
          name: CategoriesScreen.routerName,
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const CategoriesScreen(),
          ),
        ),

        ///==============>> [Income_Screen]
        GoRoute(
          path: '/${IncomeScreen.routerName}',
          name: IncomeScreen.routerName,
          pageBuilder: (context, state) => _buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const IncomeScreen(),
          ),
        ),
      ],
      // redirect: (context, state) async {
      //   // bool isUserSignIn = await SharedPref.getIsLogin() ?? false;
      //   // if ((state.fullPath != LoginScreen.routerName &&
      //   //         state.fullPath != SplashScreen.routerName) &&
      //   //     !isUserSignIn) {
      //   //   return '/${SplashScreen.routerName}';
      //   // }
      // },
    )
  ],
);
GoRouter get router => _router;

///todo create custom transation
CustomTransitionPage _buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<Page>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        transformHitTests: false,
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
