// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_your_mind_bloc.dart';

@immutable
abstract class OnYourMindState {}

class OnYourMindInitial extends OnYourMindState {}

class OnYourMindLoadInProgress extends OnYourMindState {}

class OnYourMindLoadSuccess extends OnYourMindState {
  final List<CuisineModel> cuisineList;

  OnYourMindLoadSuccess({required this.cuisineList});
}
