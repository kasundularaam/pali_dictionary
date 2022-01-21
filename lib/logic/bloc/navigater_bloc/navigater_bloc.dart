import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigater_event.dart';
part 'navigater_state.dart';

class NavigaterBloc extends Bloc<NavigaterEvent, NavigaterState> {
  NavigaterBloc() : super(NavigaterPaliTab()) {
    on<NavigaterEvent>((event, emit) {
      if (event is NavigateToMeaningTab) {
        emit(NavigaterMeaningTab());
      } else {
        emit(NavigaterPaliTab());
      }
    });
  }
}
