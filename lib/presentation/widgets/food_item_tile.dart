import 'package:flutter/material.dart';
import '../../data/models/restaurant_model.dart';
import '../../utils/colors.dart';
import '../../utils/image_assets.dart';
import '../../utils/text_styles.dart';
import 'rounded_image_widget.dart';
import 'star_rating_widget.dart';

class FoodItemTile extends StatefulWidget {
  final RestaurantModel data;
  final void Function()? likeBtnCallback;
  final Function()? func;
  const FoodItemTile({
    Key? key,
    required this.data,
    this.func,
    this.likeBtnCallback,
  }) : super(key: key);

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  late bool _isFav;

  @override
  void initState() {
    _isFav = widget.data.favourite ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18, bottom: 18),
      padding: const EdgeInsets.only(left: 18, top: 18, bottom: 18, right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: kBoxBorderColor),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Row(
        children: [
          RoundedImageWidget(
            image: widget.data.image ?? "",
            height: 120,
            width: 98,
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StarRatingWidget(
                      rating: widget.data.rating?.toStringAsFixed(1) ?? "0.0",
                    ),
                    //FAVORITES ICON
                    InkWell(
                      onTap: () async {},
                      child: Icon(
                        _isFav
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 24,
                        color: kFavoriteColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  widget.data.branchName ?? "",
                  style: mediumBoldTextStyle.copyWith(
                    fontSize: 16,
                    color: kBlackTextColor,
                  ),
                ),
                const SizedBox(height: 1),
                if (widget.data.cuisinee?.isNotEmpty ?? false)
                  SizedBox(
                    width: 190,
                    child: Wrap(
                      children: buildCuisineeListWidget(
                        widget.data.cuisinee ?? [],
                      ),
                    ),
                  ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        locationIcon,
                        const SizedBox(width: 3),
                        (widget.data.offer != null)
                            ? Text(
                                widget.data.fullAddress!.length < 12
                                    ? "${widget.data.fullAddress}"
                                    : "${widget.data.fullAddress?.substring(0, 9)}...",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: kLightTextColor,
                                ),
                              )
                            : Text(
                                widget.data.fullAddress!.length < 12
                                    ? "${widget.data.fullAddress}"
                                    : "${widget.data.fullAddress?.substring(0, 19)}...",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: kLightTextColor,
                                ),
                              ),
                        SizedBox(
                          width: 60,
                          child: Text(
                            ' | ${widget.data.dictance?.toStringAsFixed(2)} km',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: kLightTextColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    if (widget.data.offer != null &&
                        widget.data.offer?.offerType ==
                            "Percentage") //${widget.data["offer"]["offer_percentage"]}
                      Row(
                        children: [
                          offersIcon,
                          const SizedBox(width: 2),
                          Text(
                            '${widget.data.offer?.offerAmount?.toStringAsFixed(1)}% OFF',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: kAccentColor,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildCuisineeListWidget(List<Cuisinee> cuisineList) {
    List<Widget> list = [];
    List<Cuisinee> parseList = [];
    for (var item in cuisineList) {
      if (parseList.length < 3) {
        if (item.isActive ?? false) {
          parseList.add(item);
        }
      } else {
        break;
      }
    }
    for (int i = 0; i < parseList.length; i++) {
      list.add(
        Text(
          (i == parseList.length - 1)
              ? "${parseList[i].title}"
              : "${parseList[i].title} | ",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: lightTextStyle.copyWith(
            fontSize: 12,
            color: kLightestTextColor,
          ),
        ),
      );
    }
    return list;
  }
}
