part of 'home_order_bloc.dart';

@immutable
abstract class HomeOrderEvent {}

class HomeOrderFetchEvent extends HomeOrderEvent {}

class HomeOrderIndexEvent extends HomeOrderEvent {
  final int index;

  HomeOrderIndexEvent({required this.index});
}
