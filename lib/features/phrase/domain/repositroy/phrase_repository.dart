import 'package:wallet/features/phrase/domain/entities/phrase.dart';

abstract interface class PhraseRepository {
  Stream<Phrase> getPhrase();

  Future<String> generatePhrase();
  Future<void> checkPhrase();
  Future<void> importPhrase(String phrase);
}