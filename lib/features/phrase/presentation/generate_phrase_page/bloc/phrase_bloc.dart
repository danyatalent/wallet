import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';

part 'phrase_event.dart';
part 'phrase_state.dart';
part 'phrase_bloc.freezed.dart';

class PhraseBloc extends Bloc<PhraseEvent, PhraseState>{
  final PhraseRepository _phraseRepository;

  PhraseBloc(this._phraseRepository)
    : super(const PhraseState(phrase: PhraseSetupRequired(), text: '')) {
    on<_Started>(_onStarted);
    on<_CheckboxChanged>(_onCheckboxChanged);
  }

  Future<void> _onStarted(event, emit) async {
    final text = await _phraseRepository.generatePhrase();

    await emit.forEach(
      _phraseRepository.getPhrase(),
      onData: (phrase) => state.copyWith(phrase: phrase, text: text),
    );
  }

  Future<void> _onCheckboxChanged(event, emit) async {
    emit(state.copyWith(checkboxValue: event.value));
  }
}