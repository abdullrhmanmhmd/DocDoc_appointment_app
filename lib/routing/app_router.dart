
import 'package:doc_app_sw/routing/routes.dart';
import 'package:doc_app_sw/ui/onboarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';



// AppRouter handles route generation for the application based on route names.

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
        case Routes.loginScreen:
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
