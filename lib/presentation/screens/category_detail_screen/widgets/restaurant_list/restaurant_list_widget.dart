import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_bloc/data/models/restaurant_model.dart';
import 'package:food_app_bloc/presentation/screens/category_detail_screen/widgets/restaurant_list/bloc/restaurant_list_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../utils/colors.dart';
import '../../../../../utils/image_assets.dart';
import '../../../../widgets/bottomSheet_footer_widget.dart';
import '../../../../widgets/bottomSheet_header_widget.dart';
import '../../../../widgets/food_item_tile.dart';
import '../../../../widgets/loading_indicator.dart';
import '../../../../widgets/search_box_widget.dart';
import '../../../../widgets/text_icon_btn.dart';

class RestaurantListWidget extends StatefulWidget {
  const RestaurantListWidget({super.key});

  @override
  State<RestaurantListWidget> createState() => _RestaurantListWidgetState();
}

class _RestaurantListWidgetState extends State<RestaurantListWidget> {
  static const _pageSize = 5;

  bool _isFilterApplied = false;

  String cuisineSearch = "";
  List cuisineList = [];
  List allCuisineList = [];
  dynamic searchedCuisineList = [];
  List<String> selectedCuisineList = [];

  String selectedvegNonvegId = "";
  dynamic vegNonvegList = [];

  String ratingsId = "";
  dynamic ratingsFilterList = {
    "heading": "Filter by ratings",
    "items": [
      {
        "id": "",
        "title": "Relevance (Default)",
      },
      {
        "id": "4.5",
        "title": "Ratings 4.5+",
      },
      {
        "id": "4.0",
        "title": "Rating 4.0+",
      },
      {
        "id": "3.5",
        "title": "Ratings 3.5+",
      },
    ]
  };

  String sortById = "";
  dynamic sortByList = {
    "heading": "Sort by",
    "items": [
      {
        "id": "",
        "title": "Relevance (Default)",
      },
      {
        "id": "rating",
        "title": "Rating",
      },
      {
        "id": "lth",
        "title": "Cost: Low to High",
      },
      {
        "id": "htl",
        "title": "Cost: High to Low",
      },
    ]
  };

  int selectedFilterIndex = 0;
  dynamic filterWidgetList;
  late dynamic filterSectionList = [
    "Sort",
    "Cuisines",
    "Ratings",
    "Veg/Non-veg"
  ];

  late final _restaurantListBloc = RestaurantListBloc();

  final PagingController<int, RestaurantModel> _pagingController =
      PagingController<int, RestaurantModel>(firstPageKey: 1);

  @override
  void initState() {
    _restaurantListBloc.add(RestaurantFilterListFetchEvent());
    _pagingController.addPageRequestListener((pageKey) {
      print("paging controller called");
      _restaurantListBloc.add(RestaurantListFetchEvent(
        offset: pageKey,
        limit: _pageSize,
        ratingsId: ratingsId,
        sortById: sortById,
        vegNonvegId: selectedvegNonvegId,
        cuisineList: jsonEncode(selectedCuisineList),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    print("restaurant list widget build");
    return BlocProvider(
      create: (context) => _restaurantListBloc,
      child: Column(
        children: [
          BlocConsumer<RestaurantListBloc, RestaurantListState>(
            listener: (context, state) {
              if (state is RestaurantFilterListLoadedState) {
                cuisineList = allCuisineList = state.cuisineList;
                vegNonvegList = state.vegNonvegList;
              }
            },
            buildWhen: (previous, current) {
              return current is RestaurantFilterListLoadedState;
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    // FILTER
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          enableDrag: false,
                          isDismissible: false,
                          useRootNavigator: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                          ),
                          isScrollControlled: true,
                          // enableDrag: false,
                          context: context,
                          builder: (ctx) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                filterWidgetList = [
                                  sortByWidget(setState),
                                  cuisineFilterWidget(setState),
                                  ratingsFilterWidget(setState),
                                  vegNonvegWidget(setState),
                                ];
                                return Container(
                                  height: size.height * 0.65,
                                  decoration: const BoxDecoration(
                                    color: kScaffoldBackgroundColor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(22),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      BottomSheetHeaderWidget(
                                        title: 'Filter',
                                        onTap: () {
                                          if (!_isFilterApplied) {
                                            setState(() {
                                              sortById = "";
                                              selectedCuisineList = [];
                                              ratingsId = "";
                                              selectedvegNonvegId = "";
                                            });
                                          }

                                          Navigator.of(ctx).pop();
                                        },
                                      ),
                                      const Divider(height: 0),
                                      Expanded(
                                        flex: 11,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: DecoratedBox(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    for (int i = 0;
                                                        i <
                                                            filterSectionList
                                                                .length;
                                                        i++)
                                                      IntrinsicHeight(
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedFilterIndex =
                                                                  i;
                                                            });
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            17.5),
                                                                width: 3,
                                                                color: selectedFilterIndex ==
                                                                        i
                                                                    ? kAccentColor
                                                                    : Colors
                                                                        .transparent,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            20),
                                                                child: Text(
                                                                  filterSectionList[
                                                                      i],
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: selectedFilterIndex ==
                                                                            i
                                                                        ? kAccentColor
                                                                        : Colors
                                                                            .black,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const VerticalDivider(width: 0),
                                            Expanded(
                                              flex: 8,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Scrollbar(
                                                  trackVisibility: true,
                                                  radius:
                                                      const Radius.circular(12),
                                                  child: SingleChildScrollView(
                                                    child: filterWidgetList[
                                                        selectedFilterIndex],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: BottomSheetFooterWidget(
                                            clearFilterCallback: () {
                                              setState(() {
                                                sortById = "";
                                                selectedCuisineList = [];
                                                ratingsId = "";
                                                selectedvegNonvegId = "";
                                                _isFilterApplied = false;
                                              });
                                              _pagingController.refresh();
                                              Navigator.of(ctx).pop();
                                            },
                                            applyBtnCallback: () {
                                              _isFilterApplied = true;

                                              _pagingController.refresh();
                                              Navigator.of(ctx).pop();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: const TextIconBtn(
                        text: 'Filter',
                        icon: filterIcon,
                      ),
                    ),
                    // SORT BY
                    PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: kBoxBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      offset: const Offset(0, 50),
                      itemBuilder: (_) {
                        return [
                          for (var item in sortByList["items"])
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      item["title"],
                                      style: TextStyle(
                                          color: sortById == item["id"]
                                              ? kBlackTextColor
                                              : kLightTextColor),
                                    ),
                                  ),
                                  sortById == item["id"]
                                      ? const Icon(
                                          Icons.radio_button_checked_rounded,
                                          color: kAccentColor,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.radio_button_off_rounded,
                                          color: kLightTextColor,
                                          size: 20,
                                        ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  sortById = item["id"];
                                });
                                _pagingController.refresh();
                              },
                            ),
                        ];
                      },
                      child: const TextIconBtn(
                        text: 'Sort by',
                        icon: downArrowIcon,
                      ),
                    ),
                    // CUISINES
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          useRootNavigator: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(22),
                            ),
                          ),
                          isScrollControlled: true,
                          enableDrag: false,
                          builder: (c) {
                            // List cuisineList = selectedCuisineList;
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Container(
                                  height: size.height * 0.65,
                                  decoration: const BoxDecoration(
                                    color: kScaffoldBackgroundColor,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(22),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      BottomSheetHeaderWidget(
                                        title: 'Cuisine',
                                        onTap: () {
                                          if (!_isFilterApplied) {
                                            setState(() {
                                              cuisineList = allCuisineList;
                                              selectedCuisineList.clear();
                                            });
                                          } else {
                                            setState(() =>
                                                cuisineList = allCuisineList);
                                          }

                                          Navigator.pop(c);
                                        },
                                      ),
                                      const Divider(height: 0),
                                      Expanded(
                                        flex: 6,
                                        child: Column(
                                          children: [
                                            SearchBoxWidget(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 18,
                                                vertical: 8,
                                              ),
                                              hintText: 'Search for cuisines',
                                              border: Border.all(
                                                color: kBoxBorderColor,
                                              ),
                                              onChanged: (value) {
                                                final suggestions =
                                                    allCuisineList
                                                        .where((cuisine) {
                                                  final title = cuisine["title"]
                                                      .toLowerCase();
                                                  final input =
                                                      value.toLowerCase();

                                                  return title.contains(input);
                                                }).toList();

                                                setState(() {
                                                  cuisineList = suggestions;
                                                });
                                              },
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                keyboardDismissBehavior:
                                                    ScrollViewKeyboardDismissBehavior
                                                        .onDrag,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 19),
                                                itemCount: cuisineList.length,
                                                itemBuilder: (c, i) {
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (!selectedCuisineList
                                                            .contains(
                                                                cuisineList[i]
                                                                    ["_id"])) {
                                                          selectedCuisineList
                                                              .add(cuisineList[
                                                                      i]["_id"]
                                                                  .toString());
                                                        } else {
                                                          selectedCuisineList
                                                              .remove(
                                                                  cuisineList[i]
                                                                      ["_id"]);
                                                        }
                                                      });
                                                    },
                                                    child: Row(
                                                      children: [
                                                        selectedCuisineList
                                                                .contains(
                                                                    cuisineList[
                                                                            i]
                                                                        ["_id"])
                                                            ? const Icon(
                                                                Icons
                                                                    .check_box_rounded,
                                                                color:
                                                                    kAccentColor,
                                                                size: 20,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .check_box_outline_blank_rounded,
                                                                color:
                                                                    kLightestTextColor,
                                                                size: 20,
                                                              ),
                                                        const SizedBox(
                                                            width: 14),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            top: 15,
                                                            bottom: 15,
                                                            // right: 3,
                                                          ),
                                                          child: Text(
                                                            cuisineList[i]
                                                                ["title"],
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            softWrap: false,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  kLightestTextColor,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: BottomSheetFooterWidget(
                                            clearFilterCallback: () {
                                              setState(() {
                                                cuisineList = allCuisineList;
                                                _isFilterApplied = false;
                                                selectedCuisineList = [];
                                              });
                                              _pagingController.refresh();
                                              Navigator.of(c).pop();
                                            },
                                            applyBtnCallback: () {
                                              if (selectedCuisineList
                                                  .isNotEmpty) {
                                                cuisineList = allCuisineList;
                                                _isFilterApplied = true;
                                                Navigator.of(context).pop();
                                                _pagingController.refresh();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: const TextIconBtn(
                        text: 'Cuisines',
                        icon: downArrowIcon,
                      ),
                    ),
                    // RATINGS
                    PopupMenuButton(
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(color: kBoxBorderColor),
                        borderRadius: BorderRadius.all(Radius.circular(13)),
                      ),
                      offset: const Offset(0, 50),
                      itemBuilder: (_) {
                        return [
                          for (var item in ratingsFilterList["items"])
                            PopupMenuItem(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Text(
                                      item["title"],
                                      style: TextStyle(
                                          color: ratingsId == item["id"]
                                              ? kBlackTextColor
                                              : kLightTextColor),
                                    ),
                                  ),
                                  ratingsId == item["id"]
                                      ? const Icon(
                                          Icons.radio_button_checked_rounded,
                                          color: kAccentColor,
                                          size: 20,
                                        )
                                      : const Icon(
                                          Icons.radio_button_off_rounded,
                                          color: kLightTextColor,
                                          size: 20,
                                        ),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  ratingsId = item["id"];
                                });
                                _pagingController.refresh();
                              },
                            ),
                        ];
                      },
                      child: const TextIconBtn(
                        text: 'Ratings ',
                        icon: downArrowIcon,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 22),
          BlocBuilder<RestaurantListBloc, RestaurantListState>(
            buildWhen: (previous, current) {
              if (current is RestaurantListLoadedState) {
                return current.pageKey == 1;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is RestaurantListLoadedState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    '${state.noOfRestaurants} Restaurants near you',
                    style: const TextStyle(
                      color: kBlackTextColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  ' Restaurants near you',
                  style: TextStyle(
                    color: kBlackTextColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          BlocListener<RestaurantListBloc, RestaurantListState>(
            listener: (context, state) {
              if (state is RestaurantListLoadedState) {
                final nextPageKey = state.pageKey + 1;

                final isLastPage = state.restaurantList.length < _pageSize;

                isLastPage
                    ? _pagingController.appendLastPage(state.restaurantList)
                    : _pagingController.appendPage(
                        state.restaurantList,
                        nextPageKey,
                      );
              }
              if (state is RestaurantListErrorState) {
                _pagingController.error;
              }
            },
            child: PagedListView<int, RestaurantModel>(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                firstPageProgressIndicatorBuilder: (context) =>
                    const LoadingIndicator(),
                newPageProgressIndicatorBuilder: (context) =>
                    const LoadingIndicator(),
                itemBuilder: (context, item, index) {
                  return FoodItemTile(
                    data: item,
                    likeBtnCallback: () {},
                  );
                },
                noItemsFoundIndicatorBuilder: (context) => const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("No restaurants found"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _restaurantListBloc.close();
    super.dispose();
  }

  Widget vegNonvegWidget(StateSetter setState) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          const Text(
            "Filter by veg/non-veg",
            style: TextStyle(
              color: kLightTextColor,
              fontSize: 12,
            ),
          ),
          for (var item in vegNonvegList)
            InkWell(
              onTap: () {
                setState(() {
                  selectedvegNonvegId = item["_id"];
                });
              },
              child: Row(
                children: [
                  selectedvegNonvegId == item["_id"]
                      ? const Icon(
                          Icons.radio_button_checked_rounded,
                          color: kAccentColor,
                          size: 19,
                        )
                      : const Icon(
                          Icons.radio_button_off_rounded,
                          color: kLightTextColor,
                          size: 19,
                        ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        color: selectedvegNonvegId == item["_id"]
                            ? kBlackTextColor
                            : kLightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      );

  Widget ratingsFilterWidget(StateSetter setState) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            ratingsFilterList["heading"],
            style: const TextStyle(
              color: kLightTextColor,
              fontSize: 12,
            ),
          ),
          for (var item in ratingsFilterList["items"])
            InkWell(
              onTap: () {
                setState(() {
                  ratingsId = item["id"];
                });
              },
              child: Row(
                children: [
                  ratingsId == item["id"]
                      ? const Icon(
                          Icons.radio_button_checked_rounded,
                          color: kAccentColor,
                          size: 19,
                        )
                      : const Icon(
                          Icons.radio_button_off_rounded,
                          color: kLightTextColor,
                          size: 19,
                        ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        color: ratingsId == item["id"]
                            ? kBlackTextColor
                            : kLightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      );

  Widget cuisineFilterWidget(StateSetter setState) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
          const Text(
            "Filter by cuisine",
            style: TextStyle(
              color: kLightTextColor,
              fontSize: 12,
            ),
          ),
          for (var item in allCuisineList)
            InkWell(
              onTap: () {
                setState(() {
                  if (!selectedCuisineList.contains(item["_id"])) {
                    selectedCuisineList.add(item["_id"].toString());
                  } else {
                    selectedCuisineList.remove(item["_id"]);
                  }
                });
              },
              child: Row(
                children: [
                  selectedCuisineList.contains(item["_id"])
                      ? const Icon(
                          Icons.check_box_rounded,
                          color: kAccentColor,
                          size: 20,
                        )
                      : const Icon(
                          Icons.check_box_outline_blank_rounded,
                          color: kLightestTextColor,
                          size: 20,
                        ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        item["title"],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selectedCuisineList.contains(item["_id"])
                              ? kBlackTextColor
                              : kLightestTextColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      );

  Widget sortByWidget(StateSetter setState) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 18),
          Text(
            sortByList["heading"],
            style: const TextStyle(
              color: kLightTextColor,
              fontSize: 12,
            ),
          ),
          for (var item in sortByList["items"])
            InkWell(
              onTap: () {
                setState(() {
                  sortById = item["id"];
                });
              },
              child: Row(
                children: [
                  sortById == item["id"]
                      ? const Icon(
                          Icons.radio_button_checked_rounded,
                          color: kAccentColor,
                          size: 19,
                        )
                      : const Icon(
                          Icons.radio_button_off_rounded,
                          color: kLightTextColor,
                          size: 19,
                        ),
                  const SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        color: sortById == item["id"]
                            ? kBlackTextColor
                            : kLightTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
        ],
      );
}
