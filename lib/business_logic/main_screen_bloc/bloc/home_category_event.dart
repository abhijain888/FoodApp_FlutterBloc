part of 'home_category_bloc.dart';

@immutable
abstract class HomeCategoryEvent {}

class HomeCategoryFetchEvent extends HomeCategoryEvent {}

class MainScreenFetchOfferOrder extends HomeCategoryEvent {}
