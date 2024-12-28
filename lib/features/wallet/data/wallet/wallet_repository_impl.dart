import 'package:wallet/features/wallet/data/wallet/solana_wallet_api.dart';
import 'package:wallet/features/wallet/domain/entities/wallet.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final SolanaWalletApi _solanaWalletApi;

  WalletRepositoryImpl(this._solanaWalletApi);

  @override
  Future update() {
    return _solanaWalletApi.update();
  }

  @override
  Stream<Wallet> getWallet() {
    return _solanaWalletApi.getWallet();
  }

  @override
  Future<void> sendTransaction(String toAddress, double amount) {
    return _solanaWalletApi.sendTransaction(toAddress, amount);
  }

  @override
  Future<void> requestFunds() {
    return _solanaWalletApi.requestFunds();
  }

  @override
  Future<void> getPk() {
    return _solanaWalletApi.getPk();
  }
}