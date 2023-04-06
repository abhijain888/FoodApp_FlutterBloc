import '../../auth_value.dart';
import '../../utils/api_const.dart';
import '../../utils/network_api.dart';
import '../../values.dart';

class CategoryDetailScreenDataProvider {
  fetchCategoryData() async {
    try {
      return await NetworkApi.getResponse(
        url: "$homeCategoryListUrl$storeTypeId&lat=28.5355&lng=77.3910",
        headers: {
          "deviceToken": "",
          "deviceType": "",
          "timezone": "Asia/Calcutta",
          "language": "",
          "currentVersion": "",
          "Authorization": authorizationValue,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  fetchOffersData() async {
    try {
      return await NetworkApi.getResponse(
        url:
            "${offersListWithStoreTypeUrl}lat=28.5355&lng=77.3910&storeTypeId=$storeTypeId&type=Home",
        headers: {
          "deviceToken": "",
          "deviceType": "",
          "timezone": "Asia/Calcutta",
          "language": "",
          "currentVersion": "",
          "Authorization": authorizationValue,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  fetchRestaurantListData(String url) async {
    try {
      return await NetworkApi.getResponse(
        url: url,
        headers: {
          "deviceToken": "",
          "deviceType": "",
          "timezone": "Asia/Calcutta",
          "language": "",
          "currentVersion": "",
          "Authorization": authorizationValue,
        },
      );
    } catch (e) {
      print(e);
    }
  }

  fetchFilerLists() async {
    return await NetworkApi.getMultipleRequestsData(
      url: [
        cuisineListUrl + storeTypeId,
        vegNonvegListUrl,
      ],
      headers: {
        "deviceToken": "",
        "deviceType": "",
        "timezone": "Asia/Calcutta",
        "language": "",
        "currentVersion": "",
        "Authorization": authorizationValue,
      },
    );

    // allCuisineList = responses[0]["data"]["cuisineeList"];
    // vegNonvegList = responses[1]["data"]["foodCategoryList"];
    // cuisineList = allCuisineList;
  }
}
