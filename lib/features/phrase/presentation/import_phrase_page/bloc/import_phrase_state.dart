part of 'import_phrase_bloc.dart';

@freezed
class ImportPhraseState with _$ImportPhraseState {
  const factory ImportPhraseState({
    @Default(['','','','','','','','','','','','']) List<String> words,
    @Default(false) bool isSubmitting,
    @Default(null) String? errorMessage,
    @Default(PhraseSetupRequired()) Phrase phrase,
  }) = _ImportPhraseState;
}