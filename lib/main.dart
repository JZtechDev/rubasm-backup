import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruba_sm/config/routes/go_routes.dart';
import 'package:ruba_sm/features/onboardning/bloc/onboarding_bloc.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return RepositoryProvider(
          create: (context) => null,
          child: MultiBlocProvider(
            providers: [BlocProvider(create: (context) => OnboardingBloc())],
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1),
                boldText: false,
                highContrast: false,
                invertColors: false,
              ),
              child: MaterialApp.router(
                title: 'Ruba Sm',
                debugShowCheckedModeBanner: false,
                routerConfig: router,

                locale: const Locale('en'),
              ),
            ),
          ),
        );
      },
    );
  }
}
