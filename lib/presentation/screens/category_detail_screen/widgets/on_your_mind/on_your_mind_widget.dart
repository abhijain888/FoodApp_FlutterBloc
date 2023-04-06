import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/on_your_mind/bloc/on_your_mind_bloc.dart';

import '../../../../../utils/colors.dart';
import '../../../../widgets/shimmer_loading.dart';
import '../../../../widgets/skelton_widget.dart';
import 'category_grid.dart';

class OnYourMindWidget extends StatelessWidget {
  const OnYourMindWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnYourMindBloc, OnYourMindState>(
      builder: (context, state) {
        if (state is OnYourMindLoadInProgress) {
          return const _LoadingSection();
        } else if (state is OnYourMindLoadSuccess) {
          final cuisineList = state.cuisineList;
          return (cuisineList.isNotEmpty)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'What’s on your mind',
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CategoryGrid(
                      data: cuisineList,
                      funcCallback: () {
                        print("food main screeeen callback");
                      },
                    ),
                  ],
                )
              : const SizedBox.shrink();
        } else {
          return const SizedBox.shrink();
        }
      },
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
                  const Skelton(width: 140),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 4; i++)
                        const Skelton(
                          height: 60,
                          width: 60,
                        ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < 4; i++)
                        const Skelton(
                          height: 60,
                          width: 60,
                        ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Skelton(width: 140),
                  const SizedBox(height: 8),
                  const Skelton(height: 120),
                  const SizedBox(height: 10),
                  const Skelton(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
