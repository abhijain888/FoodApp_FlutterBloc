part of 'main_screen_bloc.dart';

@immutable
abstract class MainScreenEvent {}

class MainScreenFetchEvent extends MainScreenEvent {}

class MainScreenLoadedNotifyEvent extends MainScreenEvent {}
