import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pali_dictionary/logic/bloc/navigater_bloc/navigater_bloc.dart';
import 'package:pali_dictionary/presentation/screens/landing_screen.dart';

import '../../core/exceptions/route_exception.dart';
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  static const String landingScreen = '/';
  static const String homeScreen = '/homeScreen';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case landingScreen:
        return MaterialPageRoute(
          builder: (_) => const LandingScreen(),
        );
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => NavigaterBloc(),
            child: const HomeScreen(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
