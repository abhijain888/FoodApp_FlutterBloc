// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_category_bloc.dart';

@immutable
abstract class HomeCategoryState {}

class HomeCategoryInitial extends HomeCategoryState {}

class HomeCategoryLoadInProgress extends HomeCategoryState {}

class HomeCategoryLoadSuccess extends HomeCategoryState {
  final List<StoreCategory> storeCategoryList;

  HomeCategoryLoadSuccess({required this.storeCategoryList});
}
