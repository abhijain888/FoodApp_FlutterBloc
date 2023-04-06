import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/store__offer_model.dart';
import '../../../../../utils/colors.dart';
import '../../../../widgets/header_widget.dart';
import '../../../../widgets/rectangle_offer_image.dart';
import '../../../../widgets/search_box_widget.dart';
import '../../../../widgets/shimmer_loading.dart';
import '../../../../widgets/skelton_widget.dart';
import 'bloc/get_it_quickly_bloc.dart';

class GetItQuicklyWidget extends StatelessWidget {
  const GetItQuicklyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetItQuicklyBloc, GetItQuicklyState>(
      builder: (context, state) {
        if (state is GetItQuicklyLoadInProgress) {
          return const _LoadingSection();
        } else if (state is GetItQuicklyLoadSuccess) {
          final getItList = state.offersList;
          return Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderWidget(),
                    GestureDetector(
                      onTap: () {},
                      child: const SearchBoxWidget(
                        enabled: false,
                        hintText: 'Search for restaurant, items or more',
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                        backgroundColor: Color(0xffF5F7FB),
                      ),
                    ),
                  ],
                ),
              ),
              //OFFERS LIST
              if (getItList.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        'Get it quickly',
                        style: TextStyle(
                          color: kBlackTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      height: 145,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        children: offersList(getItList),
                      ),
                    ),
                  ],
                ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  List<Widget> offersList(List<StoreOfferModel> offerList) {
    List<Widget> list = [];

    for (var offer in offerList) {
      list.add(
        RectangleOfferImage(
          image: offer.image ?? "",
          offer: offer.offerAmount.toString(),
          uptoValue: offer.minimumAmount?.toStringAsFixed(2) ?? "",
          offerType: offer.offerAmount?.toStringAsFixed(2) ?? "",
        ),
      );
    }

    return list;
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
