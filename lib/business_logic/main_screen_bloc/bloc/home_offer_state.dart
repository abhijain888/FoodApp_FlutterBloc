part of 'home_offer_bloc.dart';

@immutable
abstract class HomeOfferState {}

class HomeOfferInitial extends HomeOfferState {}

class HomeOfferLoadInProgress extends HomeOfferState {}

class HomeOfferSuccess extends HomeOfferState {
  final List<HomeOffer> homeOfferList;

  HomeOfferSuccess({required this.homeOfferList});
}
