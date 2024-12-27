part of 'phrase_bloc.dart';

@freezed
class PhraseState with _$PhraseState {
  const factory PhraseState({
    required Phrase phrase,
    required String text,
    @Default(false) bool checkboxValue,
  }) = _PhraseState;
}