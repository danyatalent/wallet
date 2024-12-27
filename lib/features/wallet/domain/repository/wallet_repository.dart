import 'package:wallet/features/wallet/domain/entities/wallet.dart';

abstract interface class WalletRepository {
  Stream<Wallet> getWallet();

  Future update();

  Future<void> sendTransaction(String toAddress, double amount);
}