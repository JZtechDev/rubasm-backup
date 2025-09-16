import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ruba_sm/features/onboardning/bloc/onboarding_bloc.dart';
import 'package:ruba_sm/features/onboardning/screens/onboarding_screen.dart';
import 'package:ruba_sm/main.dart';

Page<dynamic> buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  if (!kIsWeb && Platform.isIOS) {
    return CupertinoPage<T>(
      key: state.pageKey,
      child: child,
      title: '',
      fullscreenDialog: false,
    );
  } else {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        );
      },
      maintainState: true,
      opaque: true,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routerNeglect: true,
  navigatorKey: navigatorKey,

  errorBuilder: (context, state) => SafeArea(
    child: Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: const Center(child: Text('ERROR')),
    ),
  ),
  routes: [
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => buildPageWithDefaultTransition(
        context: context,
        state: state,
        child: BlocProvider(
          create: (context) => OnboardingBloc(),
          child: OnboardingScreen(),
        ),
      ),
    ),
  ],
);
