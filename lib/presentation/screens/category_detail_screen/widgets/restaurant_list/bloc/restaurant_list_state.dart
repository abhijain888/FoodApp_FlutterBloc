part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListState {}

class RestaurantListInitial extends RestaurantListState {}

class RestaurantListLoadingState extends RestaurantListState {}

class RestaurantFilterListLoadedState extends RestaurantListState {
  final List cuisineList;
  final List vegNonvegList;

  RestaurantFilterListLoadedState({
    required this.cuisineList,
    required this.vegNonvegList,
  });
}

class RestaurantListLoadedState extends RestaurantListState {
  final List<RestaurantModel> restaurantList;
  final String noOfRestaurants;
  final int pageKey;

  RestaurantListLoadedState({
    required this.pageKey,
    required this.restaurantList,
    required this.noOfRestaurants,
  });
}

class RestaurantListErrorState extends RestaurantListState {}
