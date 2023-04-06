import 'package:food_app_bloc/data/data_providers/category_detailscreen_provider.dart';
import 'package:food_app_bloc/data/models/cuisine_model.dart';
import 'package:food_app_bloc/data/models/filter_list_model.dart';

import '../../values.dart';
import '../models/restaurant_model.dart';
import '../models/store__offer_model.dart';

class CategoryDetailScreenRepository {
  final CategoryDetailScreenDataProvider _dataProvider =
      CategoryDetailScreenDataProvider();

  Future<List<CuisineModel>> getCuisineList() async {
    final response = await _dataProvider.fetchCategoryData();

    final List resultList = response["data"]["categegoryItems"];
    return resultList.map((e) => CuisineModel.fromJson(e)).toList();
  }

  Future<List<StoreOfferModel>> getOfferList() async {
    final response = await _dataProvider.fetchOffersData();

    final List resultList = response["data"]["offer"];
    return resultList.map((e) => StoreOfferModel.fromJson(e)).toList();
  }

  Future getRestaurantList({
    required int pageKey,
    required int pageSize,
    required String ratingId,
    required String sortById,
    required String vegnonvegId,
    required String cuisineList,
  }) async {
    var requiredUrl =
        "home/get-restaurant?lat=28.5355&lng=77.3910&&storeTypeId=$storeTypeId&page=$pageKey&perPage=$pageSize";
    var url1 =
        ratingId.isEmpty ? requiredUrl : "$requiredUrl&filterRating=$ratingId";
    var url2 = sortById.isEmpty ? url1 : "$url1&sorting=$sortById";
    var url3 = vegnonvegId.isEmpty ? url2 : "$url2&veg_type=$vegnonvegId";
    var finalUrl = cuisineList.isEmpty ? url3 : "$url3&cuisineeId=$cuisineList";

    final response = await _dataProvider.fetchRestaurantListData(finalUrl);

    final List result = response["data"]["categegoryItems"];

    final String noOfRestaurants = response["data"]["Total"].toString();
    final List<RestaurantModel> restaurantList =
        result.map((e) => RestaurantModel.fromJson(e)).toList();

    return [
      noOfRestaurants,
      restaurantList,
    ];
  }

  Future<FilterLists> getFilterList() async {
    final response = await _dataProvider.fetchFilerLists();

    final cuisineList = response[0]["data"]["cuisineeList"];
    final vegNonvegList = response[1]["data"]["foodCategoryList"];

    return FilterLists(
      cuisineList: cuisineList,
      vegNonvegList: vegNonvegList,
    );
  }
}
