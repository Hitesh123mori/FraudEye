import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/landing_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/main_layout.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/auth_pages/login_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/auth_pages/register_page.dart';


final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _noAnimationPage(
        MainLayout(child: LandingPage()),
      ),
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _noAnimationPage(
        MainLayout(child: LoginPage()),
      ),
    ),

    GoRoute(
      path: '/register',
      pageBuilder: (context, state) => _noAnimationPage(
        MainLayout(child: RegisterPage()),
      ),
    ),


    ],
);

Page<void> _noAnimationPage(Widget child) {
  return CustomTransitionPage(
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    transitionDuration: Duration.zero,
  );
}
