part of 'get_it_quickly_bloc.dart';

@immutable
abstract class GetItQuicklyState {}

class GetItQuicklyInitial extends GetItQuicklyState {}

class GetItQuicklyLoadInProgress extends GetItQuicklyState {}

class GetItQuicklyLoadSuccess extends GetItQuicklyState {
  final List<StoreOfferModel> offersList;

  GetItQuicklyLoadSuccess({required this.offersList});
}
