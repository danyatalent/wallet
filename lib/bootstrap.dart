import 'package:flutter/cupertino.dart';
import 'package:wallet/app/app.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/phrase/domain/repositroy/phrase_repository.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

void bootstrap(
    PhraseRepository phraseRepository,
    LocalAuthRepository localAuthRepository,
    WalletRepository walletRepository,
) {
  runApp(App(
    phraseRepository: phraseRepository,
    localAuthRepository: localAuthRepository,
    walletRepository: walletRepository,
  ));
}