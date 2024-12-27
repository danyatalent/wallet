import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';

part 'import_phrase_event.dart';
part 'import_phrase_state.dart';
part 'import_phrase_bloc.freezed.dart';

class ImportPhraseBloc extends Bloc<ImportPhraseEvent, ImportPhraseState> {
  final PhraseRepository _phraseRepository;

  ImportPhraseBloc(this._phraseRepository) : super(const ImportPhraseState()) {
    on<_Started>(_onStarted);
    on<_UpdateWord>(_onUpdateWord);
    on<_Submit>(_onSubmit);
  }

  // void _onStarted(_Started event, Emitter<ImportPhraseState> emit) {}

  Future<void> _onStarted(event, emit) async {
    await emit.forEach(_phraseRepository.getPhrase(),
        onData: (phrase) {
          emit(state.copyWith(phrase: phrase));
        }
    );
  }

  void _onUpdateWord(_UpdateWord event, Emitter<ImportPhraseState> emit) {
    final words = List<String>.from(state.words);
    words[event.index] = event.word;
    emit(state.copyWith(words: words));
  }

  void _onSubmit(_Submit event, Emitter<ImportPhraseState> emit) {
    emit(state.copyWith(isSubmitting: true));
    final phrase = state.words.join(' ');
    _phraseRepository.importPhrase(phrase);
  }
}