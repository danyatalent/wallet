import 'package:wallet/features/phrase/data/phrase/phrase_storage_api.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';

class PhraseRepositoryImpl implements PhraseRepository {
  final PhraseStorageApi _phraseStorageApi;

  PhraseRepositoryImpl(this._phraseStorageApi);

  @override
  Future<void> checkPhrase() {
    return _phraseStorageApi.checkPhrase();
  }

  @override
  Future<String> generatePhrase() {
    return _phraseStorageApi.generatePhrase();
  }

  @override
  Stream<Phrase> getPhrase() {
    return _phraseStorageApi.getPhrase();
  }

  @override
  Future<void> importPhrase(String phrase) {
    return _phraseStorageApi.importPhrase(phrase);
  }
}