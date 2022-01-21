part of 'navigater_bloc.dart';

@immutable
abstract class NavigaterEvent {}

class NavigateToPaliTab extends NavigaterEvent {}

class NavigateToMeaningTab extends NavigaterEvent {}
