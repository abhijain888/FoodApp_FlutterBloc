import 'package:food_app_bloc/data/data_providers/mainscreen_data_provider.dart';
import 'package:food_app_bloc/data/models/check_home_order.dart';
import 'package:food_app_bloc/data/models/home_offer.dart';
import 'package:food_app_bloc/data/models/store_category.dart';

class MainScreenRepository {
  final MainScreenDataProvider _mainScreenDataProvider =
      MainScreenDataProvider();

  // late final List categoryResponseList;
  // late final List offerResponseList;
  // late final List orderProgressData;

  Future<List<StoreCategory>> getCategoryList() async {
    final response = await _mainScreenDataProvider.fetchCategoryData();
    final List resultList = response["data"]["items"];

    return resultList.map((e) => StoreCategory.fromMap(e)).toList();

    //  categoryResponseList = responses[0]["data"]["items"];
    //  offerResponseList = responses[1]["data"]["offer"];
    //  orderProgressData = responses[2]["data"];

    // final result = [
    //   categoryResponseList.map((e) => StoreCategory.fromMap(e)).toList(),
    //   offerResponseList.map((e) => HomeOffer.fromJson(e)).toList(),
    //   orderProgressData.map((e) => CheckHomeOrder.fromJson(e)).toList(),
    // ];

    // return result;
  }

  Future<List<HomeOffer>> getOffersList() async {
    final response = await _mainScreenDataProvider.fetchOffersData();
    final List resultList = response["data"]["offer"] ?? [];

    return resultList.map((e) => HomeOffer.fromJson(e)).toList();
  }

  Future<List<CheckHomeOrder>> getOrdersList() async {
    final response = await _mainScreenDataProvider.fetchOrdersData();
    final List resultList = await response["data"];

    return resultList.map((e) => CheckHomeOrder.fromJson(e)).toList();
  }

  // Future<List> getOffersOrderData() async {
  //   final responses = await _mainScreenDataProvider.getAllData();
  //   final List offerResponseList = responses[0]["data"]["offer"];
  //   final List orderProgressData = responses[1]["data"];
  //   final result = [
  //     offerResponseList.map((e) => HomeOffer.fromJson(e)).toList(),
  //     orderProgressData.map((e) => CheckHomeOrder.fromJson(e)).toList(),
  //   ];
  //   return result;
  // }
}
