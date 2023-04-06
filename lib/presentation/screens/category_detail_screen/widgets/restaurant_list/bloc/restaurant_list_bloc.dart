import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/filter_list_model.dart';
import 'package:food_app_bloc/data/models/restaurant_model.dart';
import 'package:food_app_bloc/data/repo/category_detailScreen_repository.dart';
import 'package:meta/meta.dart';
part 'restaurant_list_event.dart';
part 'restaurant_list_state.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  final CategoryDetailScreenRepository _repository =
      CategoryDetailScreenRepository();
  late List<RestaurantModel> restaurantList = [];

  RestaurantListBloc() : super(RestaurantListInitial()) {
    on<RestaurantFilterListFetchEvent>((event, emit) async {
      final FilterLists filterLists = await _repository.getFilterList();

      emit(RestaurantFilterListLoadedState(
        cuisineList: filterLists.cuisineList,
        vegNonvegList: filterLists.vegNonvegList,
      ));
    });

    on<RestaurantListFetchEvent>((event, emit) async {
      try {
        emit(RestaurantListLoadingState());
        final responseList = await _repository.getRestaurantList(
          pageKey: event.offset,
          pageSize: event.limit,
          ratingId: event.ratingsId,
          sortById: event.sortById,
          vegnonvegId: event.vegNonvegId,
          cuisineList: event.cuisineList,
        );

        emit(RestaurantListLoadedState(
          noOfRestaurants: responseList[0],
          restaurantList: responseList[1],
          pageKey: event.offset,
        ));
      } on Exception {
        emit(RestaurantListErrorState());
      }
    });
  }
}
