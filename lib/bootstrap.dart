import 'package:flutter/cupertino.dart';
import 'package:wallet/app/app.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

void bootstrap(
 LocalAuthRepository localAuthRepository,
    WalletRepository walletRepository,
) {
  runApp(App(
    localAuthRepository: localAuthRepository,
    walletRepository: walletRepository,
  ));
}