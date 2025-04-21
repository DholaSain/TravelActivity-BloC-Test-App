import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelactivity/core/database/database.dart';
import 'package:travelactivity/data/repositories/activity/activity_repo.dart';
import 'package:travelactivity/data/repositories/mock-data/mock_data_service.dart';
import 'package:travelactivity/data/repositories/network_client/request_client.dart';
import 'package:travelactivity/core/router/route_names.dart';
import 'package:travelactivity/core/router/router.dart';
import 'package:travelactivity/presentation/blocs/activity-bloc/activity_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DatabaseHelper>(
          create: (context) => DatabaseHelper(),
        ),
        RepositoryProvider<RequestClient>(create: (context) => RequestClient()),
        RepositoryProvider<ActivityRepository>(
          create:
              (context) => ActivityRepository(
                dbHelper: context.read<DatabaseHelper>(),
                requestClient: context.read<RequestClient>(),
              ),
        ),
        RepositoryProvider<MockDataService>(
          create:
              (context) => MockDataService(context.read<ActivityRepository>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ActivityBloc>(
            create:
                (context) => ActivityBloc(
                  repository: context.read<ActivityRepository>(),
                  mockDataService: context.read<MockDataService>(),
                )..add(const LoadActivities()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travel App',
          theme: ThemeData(
            colorSchemeSeed: Color(0xffFBB428),
            scaffoldBackgroundColor: Color(0xffFFF8DC),
            appBarTheme: AppBarTheme(backgroundColor: Color(0xffFFF8DC)),
          ),
          themeMode: ThemeMode.light,
          initialRoute: Routes.homeRoute,
          navigatorKey: kAppNavigatorKey,
          onGenerateRoute: KAppRouter.generateRoute,
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) {
                    return GestureDetector(
                      onTap:
                          () => FocusManager.instance.primaryFocus?.unfocus(),
                      child: child ?? const SizedBox.shrink(),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
