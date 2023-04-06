import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/get_it_quickly/bloc/get_it_quickly_bloc.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/get_it_quickly/get_it_quickly_widget.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/on_your_mind/bloc/on_your_mind_bloc.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/restaurant_list/restaurant_list_widget.dart';
import '../../../data/repo/category_detailScreen_repository.dart';
import '../../widgets/shimmer_loading.dart';
import '../../widgets/skelton_widget.dart';
import 'widgets/on_your_mind/on_your_mind_widget.dart';

class CategoryDetailScreen extends StatelessWidget {
  const CategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetItQuicklyBloc(
            repository: context.read<CategoryDetailScreenRepository>(),
          )..add(GetItQuicklyFetchEvent()),
        ),
        BlocProvider(
          create: (context) => OnYourMindBloc(
            repository: context.read<CategoryDetailScreenRepository>(),
          )..add(OnYourMindFetchEvent()),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: const [
              GetItQuicklyWidget(),
              OnYourMindWidget(),
              RestaurantListWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Skelton(
                    width: 150,
                  ),
                  const SizedBox(height: 5),
                  const Skelton(
                    height: 40,
                  ),
                  const SizedBox(height: 10),
                  const Skelton(
                    width: 130,
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    child: Row(
                      children: const [
                        Skelton(
                          height: 140,
                          width: 120,
                        ),
                        SizedBox(width: 10),
                        Skelton(
                          height: 140,
                          width: 120,
                        ),
                        SizedBox(width: 10),
                        Skelton(
                          height: 140,
                          width: 120,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
