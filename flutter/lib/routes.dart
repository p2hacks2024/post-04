import 'package:epsilon_app/main.dart';
import 'package:epsilon_app/view/developer_page.dart';
import 'package:epsilon_app/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(navigatorKey: navigatorKey, routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const Splash();
      }),
  GoRoute(path: '/home', builder: (context, state) => const MyHomePage(title: 'Home')),
  GoRoute(path: '/developer', builder: (context, state) => const DeveloperPage()),
]);
