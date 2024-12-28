import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/features/phrase/domain/entities/phrase.dart';
import 'package:bip39/bip39.dart' as bip39;


class PhraseStorageApi {
  final FlutterSecureStorage _storage;
  static const _walletKey = 'private_key';

  final _phraseController = BehaviorSubject<Phrase>.seeded(const PhraseUninitialized());

  PhraseStorageApi() : _storage = const FlutterSecureStorage() {
    checkPhrase();
  }

  Stream<Phrase> getPhrase() => _phraseController.asBroadcastStream();

  Future<void> checkPhrase() async {
    final phrase = await _storage.read(key: _walletKey);
    if (phrase == null) {
      _phraseController.add(const PhraseSetupRequired());
    } else {
      _phraseController.add(const PhraseSetted());
    }
  }

  Future<String> generatePhrase() async {
    final phrase = bip39.generateMnemonic();
    await _storage.write(key: _walletKey, value: phrase);

    _phraseController.add(const PhraseSetting());
    return phrase;
  }

  Future<void> importPhrase(String phrase) async {
    await _storage.write(key: _walletKey, value: phrase);
    _phraseController.add(const PhraseSetting());
  }
}