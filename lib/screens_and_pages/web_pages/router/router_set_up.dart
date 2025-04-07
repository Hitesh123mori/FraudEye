import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/landing_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/main_layout.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/auth_pages/login_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/auth_pages/register_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/admin_user_home_pages/admin_dashboard.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/bank_user_home_pages/bank_user_home.dart';
import 'package:hack_nu_thon_6/screens_and_pages/web_pages/home_pages/normal_user_home_pages/normal_user_home.dart';


final GoRouter router = GoRouter(
  initialLocation: '/login',
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

    GoRoute(
      path: '/home-user',
      pageBuilder: (context, state) => _noAnimationPage(
          NormalUserHome(),
      ),
    ),

    GoRoute(
      path: '/home-bank',
      pageBuilder: (context, state) => _noAnimationPage(
        BankUserHome(),
      ),
    ),

    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => _noAnimationPage(
        AdminDashboard(),
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
