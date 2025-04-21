import 'package:flutter/material.dart';
import 'package:travelactivity/core/router/route_names.dart';
import 'package:travelactivity/presentation/features/home/home_screen.dart';
import 'package:travelactivity/presentation/features/misc/not_found.dart';
import 'package:travelactivity/presentation/features/onboarding/splash.dart';

final GlobalKey<NavigatorState> kAppNavigatorKey = GlobalKey<NavigatorState>();

class KAppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.defaultRoute:
        return _getPageRoute(
          viewToShow: const SplashScreen(),
          settings: settings,
        );
      case Routes.homeRoute:
        return _getPageRoute(
          viewToShow: const HomeScreen(),
          settings: settings,
        );
      default:
        return _getPageRoute(
          viewToShow: const NotFoundRoute(),
          settings: settings,
        );
    }
  }

  static PageRoute _getPageRoute({
    required Widget viewToShow,
    required RouteSettings settings,
    bool fullscreenDialog = false,
    PageTransitionType? transitionType,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (transitionType == null) {
      // Use the original MaterialPageRoute when no transition is specified
      return MaterialPageRoute(
        builder: (_) => viewToShow,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    // Use PageRouteBuilder for custom transitions
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => viewToShow,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case PageTransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case PageTransitionType.rightToLeft:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case PageTransitionType.bottomToTop:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          // Add more transition types as needed
        }
      },
    );
  }

  static T? _getArgumentsAs<T>(RouteSettings settings) {
    if (settings.arguments != null && settings.arguments is T) {
      final T arguments = settings.arguments as T;
      return arguments;
    } else {
      return null;
    }
  }
}

enum PageTransitionType { fade, rightToLeft, bottomToTop }
