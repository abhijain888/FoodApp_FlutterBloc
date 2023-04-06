import 'package:food_app_bloc/auth_value.dart';
import 'package:food_app_bloc/utils/api_const.dart';
import 'package:food_app_bloc/utils/network_api.dart';

class MainScreenDataProvider {
  fetchCategoryData() async {
    try {
      return await NetworkApi.getResponse(
        url: mainCategoryUrl,
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
        url: "${offersListUrl}lat=28.5355&lng=77.3910&type=Home",
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

  fetchOrdersData() async {
    try {
      return await NetworkApi.getResponse(
        url: checkOrderProgressUrl,
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

  getAllData() async {
    try {
      return await NetworkApi.getMultipleRequestsData(
        url: [
          mainCategoryUrl,
          "${offersListUrl}lat=28.5355&lng=77.3910&type=Home",
          checkOrderProgressUrl,
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
    } on Exception catch (e) {
      print(e);
    }
  }
}
