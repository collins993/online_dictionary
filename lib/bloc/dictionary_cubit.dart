import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_dictionary/model/word_response.dart';
import 'package:online_dictionary/repo/word_repository.dart';

class DictionaryCubit extends Cubit<DictionaryState>{
  final WordRepository _repository;

  DictionaryCubit(this._repository) : super(NoWordSearchedState());

  final queryController = TextEditingController();

  Future getWordSearched() async {
    emit(WordSearchingState());

    try {
      final words = await _repository.getWordFromDictionary(
          queryController.text);
      if (words == null) {
        emit(ErrorState("There is some issue"));
      }
      else {
        print(words.toString());
        emit(WordSearchedState(words));
        emit(NoWordSearchedState());
      }
    } on Exception catch (e) {
      print(e);
      emit(ErrorState(e.toString()));
    }
  }

}

abstract class DictionaryState {

}

class NoWordSearchedState extends DictionaryState{

}

class WordSearchingState extends DictionaryState{

}

class WordSearchedState extends DictionaryState{
  final List<WordResponse> words;

  WordSearchedState(this.words);
}

class ErrorState extends DictionaryState{
  final message;

  ErrorState(this.message);
}