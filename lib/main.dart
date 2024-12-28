import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:wallet/bootstrap.dart';
import 'package:wallet/features/local_auth/data/local-auth/local_auth_repository_impl.dart';
import 'package:wallet/features/local_auth/data/local-auth/secure_storage_api.dart';
import 'package:wallet/features/phrase/data/phrase/phrase_repositry_impl.dart';
import 'package:wallet/features/phrase/data/phrase/phrase_storage_api.dart';
import 'package:wallet/features/wallet/data/wallet/solana_wallet_api.dart';
import 'package:wallet/features/wallet/data/wallet/wallet_repository_impl.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  dotenv.load();

  final phraseStorageApi = PhraseStorageApi();
  final phraseRepository = PhraseRepositoryImpl(phraseStorageApi);

  final secureStorageApi = SecureStorageApi();
  final localAuthRepository = LocalAuthRepositoryImpl(secureStorageApi);

  final solanaWalletApi = SolanaWalletApi();
  final walletRepository = WalletRepositoryImpl(solanaWalletApi);

  bootstrap(phraseRepository, localAuthRepository, walletRepository);
}
