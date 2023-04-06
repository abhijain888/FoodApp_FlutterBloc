import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainScreenBloc() : super(MainScreenInitial()) {
    on<MainScreenFetchEvent>((event, emit) {
      emit(MainScreenLoadingState());
    });

    on<MainScreenLoadedNotifyEvent>((event, emit) {
      emit(MainScreenLoadedState());
    });
  }
}
