import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:pali_dictionary/data/models/word_model.dart';
import 'package:pali_dictionary/data/sqlite/database_helper.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  DictionaryCubit() : super(DictionaryInitial());

  Future<void> getAllWords({required bool isSanskrit}) async {
    try {
      emit(DictionaryLoading());
      List<WordModel> wordModels =
          await DatabaseHelper.instance.getAllWords(isSanskrit: isSanskrit);
      emit(DictionaryLoaded(wordModels: wordModels));
    } catch (e) {
      emit(DictionaryFailed(errorMsg: e.toString()));
    }
  }

  Future<void> searchWord(
      {required String searchText, required bool isSanskrit}) async {
    try {
      emit(DictionaryLoading());
      List<WordModel> wordModels = await DatabaseHelper.instance
          .searchWord(searchText: searchText, isSanskrit: isSanskrit);
      emit(DictionaryLoaded(wordModels: wordModels));
    } catch (e) {
      emit(DictionaryFailed(errorMsg: e.toString()));
    }
  }
}
