import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/check_home_order.dart';
import 'package:food_app_bloc/data/repo/mainscreen_repository.dart';
import 'package:meta/meta.dart';
part 'home_order_event.dart';
part 'home_order_state.dart';

class HomeOrderBloc extends Bloc<HomeOrderEvent, HomeOrderState> {
  final MainScreenRepository mainScreenRepository;
  HomeOrderBloc({required this.mainScreenRepository})
      : super(HomeOrderInitial()) {
    on<HomeOrderFetchEvent>((event, emit) async {
      final homeOrdersList = await mainScreenRepository.getOrdersList();
      emit(HomeOrderSuccess(homeOrdersList: homeOrdersList));
      add(HomeOrderIndexEvent(index: 0));
    });

    on<HomeOrderIndexEvent>((event, emit) {
      emit(HomeOrderIndexState(index: event.index));
    });
  }
}
