part of 'import_phrase_bloc.dart';

@freezed
class ImportPhraseEvent with _$ImportPhraseEvent {
  const factory ImportPhraseEvent.updateWord({
    required String word,
    required int index,
  }) = _UpdateWord;
  const factory ImportPhraseEvent.submit() = _Submit;
  const factory ImportPhraseEvent.setError({
    required String message,
  }) = _SetError;
  const factory ImportPhraseEvent.started() = _Started;
  const factory ImportPhraseEvent.privateKeyChanged({required String privateKey}) = _PrivateKeyChanged;
}