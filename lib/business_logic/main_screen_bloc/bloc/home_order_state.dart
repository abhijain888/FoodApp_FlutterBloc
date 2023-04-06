part of 'home_order_bloc.dart';

@immutable
abstract class HomeOrderState {}

class HomeOrderInitial extends HomeOrderState {}

class HomeOrderSuccess extends HomeOrderState {
  final List<CheckHomeOrder> homeOrdersList;

  HomeOrderSuccess({required this.homeOrdersList});
}

class HomeOrderIndexState extends HomeOrderState {
  final int index;

  HomeOrderIndexState({required this.index});
}
