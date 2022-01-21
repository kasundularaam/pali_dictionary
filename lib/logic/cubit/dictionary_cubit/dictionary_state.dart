part of 'dictionary_cubit.dart';

@immutable
abstract class DictionaryState {}

class DictionaryInitial extends DictionaryState {}

class DictionaryLoading extends DictionaryState {}

class DictionaryLoaded extends DictionaryState {
  final List<WordModel> wordModels;
  DictionaryLoaded({
    required this.wordModels,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DictionaryLoaded &&
        listEquals(other.wordModels, wordModels);
  }

  @override
  int get hashCode => wordModels.hashCode;

  @override
  String toString() => 'DictionaryLoaded(wordModels: $wordModels)';
}

class DictionaryFailed extends DictionaryState {
  final String errorMsg;
  DictionaryFailed({
    required this.errorMsg,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DictionaryFailed && other.errorMsg == errorMsg;
  }

  @override
  int get hashCode => errorMsg.hashCode;

  @override
  String toString() => 'DictionaryFailed(errorMsg: $errorMsg)';
}
