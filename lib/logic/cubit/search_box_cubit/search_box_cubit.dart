import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_box_state.dart';

class SearchBoxCubit extends Cubit<SearchBoxState> {
  SearchBoxCubit() : super(SearchBoxSearch());
  void showSearchBtn() {
    emit(SearchBoxSearch());
  }

  void showCloseBtn() {
    emit(SearchBoxClose());
  }
}
