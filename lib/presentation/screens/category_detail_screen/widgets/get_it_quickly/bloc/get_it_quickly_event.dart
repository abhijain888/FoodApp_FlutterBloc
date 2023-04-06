part of 'get_it_quickly_bloc.dart';

@immutable
abstract class GetItQuicklyEvent {}

class GetItQuicklyInitialEvent extends GetItQuicklyEvent {}

class GetItQuicklyFetchEvent extends GetItQuicklyEvent {}
