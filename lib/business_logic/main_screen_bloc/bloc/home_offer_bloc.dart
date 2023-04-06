import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/home_offer.dart';
import 'package:food_app_bloc/data/repo/mainscreen_repository.dart';
import 'package:meta/meta.dart';
part 'home_offer_event.dart';
part 'home_offer_state.dart';

class HomeOfferBloc extends Bloc<HomeOfferEvent, HomeOfferState> {
  final MainScreenRepository mainScreenRepository;
  HomeOfferBloc({required this.mainScreenRepository})
      : super(HomeOfferInitial()) {
    on<HomeOfferFetchEvent>((event, emit) async {
      emit(HomeOfferLoadInProgress());
      final offerList = await mainScreenRepository.getOffersList();

      emit(HomeOfferSuccess(homeOfferList: offerList));
    });
  }
}
