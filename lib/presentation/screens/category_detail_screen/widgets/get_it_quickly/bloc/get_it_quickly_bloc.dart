import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/store__offer_model.dart';
import 'package:food_app_bloc/data/repo/category_detailScreen_repository.dart';
import 'package:meta/meta.dart';
part 'get_it_quickly_event.dart';
part 'get_it_quickly_state.dart';

class GetItQuicklyBloc extends Bloc<GetItQuicklyEvent, GetItQuicklyState> {
  final CategoryDetailScreenRepository repository;
  GetItQuicklyBloc({required this.repository}) : super(GetItQuicklyInitial()) {
    on<GetItQuicklyFetchEvent>((event, emit) async {
      emit(GetItQuicklyLoadInProgress());
      try {
        final result = await repository.getOfferList();

        emit(GetItQuicklyLoadSuccess(offersList: result));
      } on Exception {}
    });
  }
}
