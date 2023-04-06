import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/data/repo/category_detailScreen_repository.dart';
import 'package:food_app_bloc/presentation/screens/main_screen.dart';
import 'package:get_it/get_it.dart';
import 'data/repo/mainscreen_repository.dart';

final getIt = GetIt.instance;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => MainScreenRepository(),
        ),
        RepositoryProvider(
          create: (_) => CategoryDetailScreenRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: RepositoryProvider(
          create: (context) => MainScreenRepository(),
          child: const MainScreen(),
        ),
      ),
    );
  }
}
