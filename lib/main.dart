import 'package:flutter/material.dart';
import 'package:wallet/bootstrap.dart';
import 'package:wallet/features/local_auth/data/local-auth/local_auth_repository_impl.dart';
import 'package:wallet/features/local_auth/data/local-auth/secure_storage_api.dart';
import 'package:wallet/features/wallet/data/wallet/solana_wallet_api.dart';
import 'package:wallet/features/wallet/data/wallet/wallet_repository_impl.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorageApi = SecureStorageApi();
  final localAuthRepository = LocalAuthRepositoryImpl(secureStorageApi);

  final solanaWalletApi = SolanaWalletApi();
  final walletRepository = WalletRepositoryImpl(solanaWalletApi);

  bootstrap(localAuthRepository, walletRepository);
}
