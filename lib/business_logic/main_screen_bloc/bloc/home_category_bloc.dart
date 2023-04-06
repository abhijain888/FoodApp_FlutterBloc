import 'package:bloc/bloc.dart';
import 'package:food_app_bloc/data/models/store_category.dart';
import 'package:food_app_bloc/data/repo/mainscreen_repository.dart';
import 'package:meta/meta.dart';
part 'home_category_event.dart';
part 'home_category_state.dart';

class HomeCategoryBloc extends Bloc<HomeCategoryEvent, HomeCategoryState> {
  final MainScreenRepository mainScreenRepository;
  HomeCategoryBloc({required this.mainScreenRepository})
      : super(HomeCategoryInitial()) {
    on<HomeCategoryFetchEvent>((event, emit) async {
      emit(HomeCategoryLoadInProgress());
      try {
        final categoryList = await mainScreenRepository.getCategoryList();
        emit(HomeCategoryLoadSuccess(storeCategoryList: categoryList));
      } on Exception {}
    });
  }
}
