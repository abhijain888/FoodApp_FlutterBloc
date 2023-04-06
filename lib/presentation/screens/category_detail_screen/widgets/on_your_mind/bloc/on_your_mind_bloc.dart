import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/cuisine_model.dart';
import 'package:food_app_bloc/data/repo/category_detailScreen_repository.dart';
import 'package:meta/meta.dart';

part 'on_your_mind_event.dart';
part 'on_your_mind_state.dart';

class OnYourMindBloc extends Bloc<OnYourMindEvent, OnYourMindState> {
  final CategoryDetailScreenRepository repository;
  OnYourMindBloc({required this.repository}) : super(OnYourMindInitial()) {
    on<OnYourMindFetchEvent>((event, emit) async {
      emit(OnYourMindLoadInProgress());

      final cuisineList = await repository.getCuisineList();
      emit(OnYourMindLoadSuccess(cuisineList: cuisineList));
    });
  }
}
