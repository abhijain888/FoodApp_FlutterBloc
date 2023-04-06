import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/presentation/screens/main_screen_layout.dart';
import '../../business_logic/main_screen_bloc/bloc/home_category_bloc.dart';
import '../../business_logic/main_screen_bloc/bloc/home_offer_bloc.dart';
import '../../business_logic/main_screen_bloc/bloc/home_order_bloc.dart';
import '../../data/repo/mainscreen_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeCategoryBloc(
            mainScreenRepository: context.read<MainScreenRepository>(),
          )..add(HomeCategoryFetchEvent()),
        ),
        BlocProvider(
          create: (_) => HomeOfferBloc(
            mainScreenRepository: context.read<MainScreenRepository>(),
          )..add(HomeOfferFetchEvent()),
        ),
        BlocProvider(
          create: (_) => HomeOrderBloc(
              mainScreenRepository: context.read<MainScreenRepository>())
            ..add(HomeOrderFetchEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: MainScreenLayout(),
        ),
      ),
    );
  }
}
