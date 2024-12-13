import 'package:epsilon_app/main.dart';
import 'package:epsilon_app/developer_page/usb_serial_example.dart';
import 'package:epsilon_app/developer_page/developer_page.dart';
import 'package:epsilon_app/view/play_charge_page.dart';
import 'package:epsilon_app/view/play_connected_page.dart';
import 'package:epsilon_app/view/play_flash_page.dart';
import 'package:epsilon_app/view/play_page.dart';
import 'package:epsilon_app/view/display_qr.dart';
import 'package:epsilon_app/view/load_qr.dart';
import 'package:epsilon_app/view/splash.dart';
import 'package:epsilon_app/developer_page/storage_example.dart';
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
  GoRoute(path: '/play', builder: (context, state) => PlayPage()),
  GoRoute(path: '/play/connected', builder: (context, state) => ConnectedPage()),
  GoRoute(path: '/play/charge', builder: (context, state) => const ChargePage()),
  GoRoute(
      path: '/play/flash/:color',
      builder: (context, GoRouterState state) {
        Color color = Color(int.parse(state.pathParameters['color'] ?? '0xFF000000'));
        debugPrint('color: $color');
        return PlayFlashPage(color: color);
      }),
  GoRoute(path: '/developer', builder: (context, state) => const DeveloperPage()),
  GoRoute(path: '/usb_serial_example', builder: (context, state) => const UsbSerialSample(title: 'usb sample')),
  GoRoute(path: '/developer/storage_example', builder: (context, state) => const StorageExample()),
  GoRoute(path: '/developer/display_qr', builder: (context, state) => const DisplayQr()),
  GoRoute(path: '/developer/load_qr', builder: (context, state) => const LoadQr(),)
]);
