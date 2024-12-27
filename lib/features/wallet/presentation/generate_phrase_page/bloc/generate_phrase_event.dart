part of 'generate_phrase_bloc.dart';

@freezed
class GeneratePhraseEvent with _$GeneratePhraseEvent {
  const factory GeneratePhraseEvent.started() = _Started;
}