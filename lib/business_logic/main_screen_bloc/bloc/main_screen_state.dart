part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}

class MainScreenLoadingState extends MainScreenState {}

class MainScreenLoadedState extends MainScreenState {}
