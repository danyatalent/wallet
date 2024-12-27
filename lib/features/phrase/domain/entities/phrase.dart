import 'package:freezed_annotation/freezed_annotation.dart';

part 'phrase.freezed.dart';

abstract class Phrase {
  const Phrase();
}

class PhraseUninitialized extends Phrase {
  const PhraseUninitialized();
}

class PhraseSetupRequired extends Phrase {
  const PhraseSetupRequired();
}

@freezed
class PhraseSetted extends Phrase with _$PhraseSetted {
  const factory PhraseSetted({required String mnemonicPhrase}) = _PhraseSetted;
}