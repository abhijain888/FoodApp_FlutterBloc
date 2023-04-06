part of 'restaurant_list_bloc.dart';

@immutable
abstract class RestaurantListEvent {}

class RestaurantFilterListFetchEvent extends RestaurantListEvent {}

class RestaurantLikeEvent extends RestaurantListEvent {}

class RestaurantListFetchEvent extends RestaurantListEvent {
  final String ratingsId;
  final String sortById;
  final String vegNonvegId;
  final String cuisineList;
  final int offset;
  final int limit;

  RestaurantListFetchEvent({
    required this.ratingsId,
    required this.sortById,
    required this.vegNonvegId,
    required this.cuisineList,
    required this.offset,
    required this.limit,
  });
}
