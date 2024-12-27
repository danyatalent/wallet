import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';
part 'welcome_bloc.freezed.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final PhraseRepository _phraseRepository;

  WelcomeBloc(this._phraseRepository)
      : super(const WelcomeState(phrase: PhraseUninitialized())) {
    on<WelcomeEvent>(_onWelcomeEvent);
  }

  Future<void> _onWelcomeEvent(
      WelcomeEvent event, Emitter<WelcomeState> emit) async {

    _phraseRepository.checkPhrase();

    await emit.forEach(
      _phraseRepository.getPhrase(),
      onData: (phrase) => state.copyWith(phrase: phrase),
    );
  }
}