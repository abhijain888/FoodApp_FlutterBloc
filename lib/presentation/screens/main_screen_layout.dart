import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/business_logic/main_screen_bloc/bloc/home_offer_bloc.dart';
import 'package:food_app_bloc/business_logic/main_screen_bloc/bloc/home_order_bloc.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/category_detail_screen.dart';
import 'package:food_app_bloc/values.dart';
import '../../business_logic/main_screen_bloc/bloc/home_category_bloc.dart';
import '../../utils/colors.dart';
import '../../utils/image_assets.dart';
import '../../utils/text_styles.dart';
import '../../utils/util.dart';
import '../widgets/header_widget.dart';
import '../widgets/offer_banner_widget.dart';
import '../widgets/search_box_widget.dart';
import '../widgets/shimmer_loading.dart';
import '../widgets/skelton_widget.dart';

class MainScreenLayout extends StatelessWidget {
  MainScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            BlocBuilder<HomeCategoryBloc, HomeCategoryState>(
              builder: (context, state) {
                if (state is HomeCategoryLoadInProgress) {
                  return const _UpperLoadingSection();
                } else if (state is HomeCategoryLoadSuccess) {
                  final categoryList = state.storeCategoryList;
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      const HeaderWidget(),
                      GestureDetector(
                        onTap: () {},
                        child: const SearchBoxWidget(
                          enabled: false,
                          hintText: 'Search for food, grocery or more',
                          margin: EdgeInsets.only(top: 15, bottom: 20),
                          backgroundColor: Color(0xffF5F7FB),
                        ),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: categoryList.length < gradientColors.length
                            ? categoryList.length
                            : gradientColors.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () async {
                              storeTypeId = categoryList[index].id;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const CategoryDetailScreen(),
                                ),
                              );
                            },
                            child: CategoryBoxWidget(
                              image: images[index],
                              title: categoryList[index].storeType,
                              color: colors[index],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<HomeOfferBloc, HomeOfferState>(
              builder: (context, state) {
                if (state is HomeOfferLoadInProgress) {
                  return const _LowerLoadingSection();
                } else if (state is HomeOfferSuccess) {
                  final offersList = state.homeOfferList;
                  return (offersList.isEmpty)
                      ? const _EmptyOffersWidget()
                      : ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: offersList.length,
                          itemBuilder: (c, i) {
                            return GestureDetector(
                              onTap: () async {},
                              child: OfferBannerWidget(
                                category:
                                    offersList[i].storeTypeId?.storeType ?? "",
                                perc: offersList[i].offerType == "Flat"
                                    ? "Flat\nSAR ${offersList[i].offerAmount} OFF"
                                    : "Up to\n${offersList[i].offerAmount}% OFF",
                                tagline: "${offersList[i].description}",
                                gradient: _gradientColors[
                                    offersList[i].storeTypeId?.storeType ?? ""],
                              ),
                            );
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 18),
                        );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
        BlocBuilder<HomeOrderBloc, HomeOrderState>(
          buildWhen: (previous, current) => current is HomeOrderSuccess,
          builder: (context, state) {
            if (state is HomeOrderSuccess) {
              final orderList = state.homeOrdersList;
              return orderList.isNotEmpty
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 65,
                        child: Stack(
                          children: [
                            PageView.builder(
                              onPageChanged: (value) {
                                context
                                    .read<HomeOrderBloc>()
                                    .add(HomeOrderIndexEvent(index: value));
                              },
                              itemCount: orderList.length,
                              itemBuilder: (context, index) {
                                var data = orderList[index];
                                return InkWell(
                                  onTap: () async {},
                                  child: Container(
                                    color: kAccentColor,
                                    height: 65,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "View Order In Progress",
                                              style:
                                                  mediumBoldTextStyle.copyWith(
                                                fontSize: 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              "Pick-up at ${dateTimeToDateStringFormat(data.pickupDateTime ?? "")} | ${dateTimeToTimeStringFormat(data.pickupDateTime ?? "")}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        arrowForwardIcon,
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            if (orderList.length > 1)
                              BlocBuilder<HomeOrderBloc, HomeOrderState>(
                                // buildWhen: (previous, current) =>
                                //     previous is HomeOrderIndexState,
                                builder: (context, state) {
                                  if (state is HomeOrderIndexState) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: buildDotIndicatorWidget(
                                          length: orderList.length,
                                          dotIndex: state.index,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              )
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  List images = [
    'assets/images/food-removebg-preview.png',
    'assets/images/food-removebg-preview.png',
    'assets/images/grocery-removebg-preview.png',
    'assets/images/grocery-removebg-preview.png',
    'assets/images/grocery-removebg-preview.png',
    'assets/images/grocery-removebg-preview.png',
  ];

  List colors = [
    const Color(0xffFF9F8B),
    const Color(0xffFFE28B),
    const Color(0xff77DEC0),
    const Color(0xff77DEC0),
    const Color(0xffFF9F8B),
    const Color(0xffFFE28B),
  ];

  final Map _gradientColors = {
    "Food": [
      const Color(0xFFF5CA44),
      const Color(0xFFF87726),
    ],
    "Grocery": [
      const Color(0xFFBCBB4E),
      const Color(0xFF418762),
    ],
    "Meat": [
      const Color(0xFFffb88c),
      const Color(0xFFde6262),
    ],
  };

  List<Map> gradientColors = [
    {
      "color": [
        const Color(0xFFF5CA44),
        const Color(0xFFF87726),
      ]
    },
    {
      "color": [
        const Color(0xFFBCBB4E),
        const Color(0xFF418762),
      ]
    },
    {
      "color": [
        const Color(0xFF6dd5ed),
        const Color(0xFF2193b0),
      ]
    },
    {
      "color": [
        const Color(0xFF734b6d),
        const Color(0xFF42275a),
      ]
    },
    {
      "color": [
        const Color(0xFFffb88c),
        const Color(0xFFde6262),
      ]
    },
  ];

  List<Widget> buildDotIndicatorWidget({
    required int length,
    int dotIndex = 0,
  }) {
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 1,
            vertical: 7,
          ),
          height: 3,
          width: 3,
          decoration: BoxDecoration(
            color: i == dotIndex
                ? Colors.white
                : Colors.grey[200]!.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    return list;
  }
}

class CategoryBoxWidget extends StatelessWidget {
  final String image, title;
  final Color color;

  const CategoryBoxWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5),
          Image.asset(
            image,
            height: 90,
          ),
          Container(
            width: 85,
            height: 35,
            color: Colors.transparent,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                color: Color(0xFF4A4123),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyOffersWidget extends StatelessWidget {
  const _EmptyOffersWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage("assets/images/offerssale.png"),
          height: 220,
          width: 220,
        ),
        Text(
          "No Offers Available",
          style: mediumBoldTextStyle.copyWith(
            fontSize: 16,
            color: kBlackTextColor,
          ),
        ),
      ],
    );
  }
}

class _UpperLoadingSection extends StatelessWidget {
  const _UpperLoadingSection();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Skelton(width: 150),
          const SizedBox(height: 10),
          const Skelton(height: 40),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Expanded(
                child: Skelton(
                  height: 140,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Skelton(
                  height: 140,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Skelton(
                  height: 140,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LowerLoadingSection extends StatelessWidget {
  const _LowerLoadingSection();

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Skelton(height: 160),
            SizedBox(height: 10),
            Skelton(height: 160),
            SizedBox(height: 10),
            Skelton(height: 160),
          ],
        ),
      ),
    );
  }
}
