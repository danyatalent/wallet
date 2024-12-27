part of 'phrase_bloc.dart';

@freezed
class PhraseEvent with _$PhraseEvent {
  const factory PhraseEvent.started() = _Started;
  const factory PhraseEvent.checkboxChanged({required bool value}) = _CheckboxChanged;
}