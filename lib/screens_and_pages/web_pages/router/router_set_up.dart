import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/landing_page.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/langing_page/main_layout.dart';
import 'package:hack_nu_thon_6/screens_and_pages//web_pages/temp_page_dart.dart';


final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _noAnimationPage(
        MainLayout(child: LandingPage()),
      ),
    ),
    GoRoute(
      path: '/firstpage',
      pageBuilder: (context, state) => _noAnimationPage(
        const MainLayout(child: TempPageDart()),
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
