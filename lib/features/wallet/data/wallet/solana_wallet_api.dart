import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart' as solana;
import 'package:bip39/bip39.dart' as bip39;
import 'package:wallet/features/wallet/domain/entities/wallet.dart';
import 'package:solana/base58.dart';

class SolanaWalletApi {
  final solana.SolanaClient _solanaClient;
  final FlutterSecureStorage _storage;

  late final _walletController = BehaviorSubject<Wallet>.seeded(const Wallet(address: '', balance: '', mnemonic: ''));

  // todo: make env
  static const rpcUrl = 'https://api.devnet.solana.com';
  static const wsUrl = 'wss://api.devnet.solana.com';
  static const _walletKey = 'private_key';

  SolanaWalletApi() :
        _solanaClient = solana.SolanaClient(rpcUrl: Uri.parse(rpcUrl), websocketUrl: Uri.parse(wsUrl)),
        _storage = const FlutterSecureStorage();


  Stream<Wallet> getWallet() => _walletController.asBroadcastStream();

  Future update() async {
    var mnemonic = await _storage.read(key: _walletKey);
    print('from storage $mnemonic');
    if (mnemonic == null) {
      print('null');
      mnemonic = bip39.generateMnemonic();
      await _storage.write(key: _walletKey, value: mnemonic);
    }
    
    final keyPair = await solana.Ed25519HDKeyPair.fromMnemonic(mnemonic);
    final balanceResult = await _solanaClient.rpcClient.getBalance(keyPair.address, commitment: solana.Commitment.confirmed);
    final balance = (balanceResult.value / solana.lamportsPerSol).toString();

    _walletController.add(_walletController.value.copyWith(
      address: keyPair.address,
      balance: balance,
      mnemonic: mnemonic,
    ));
  }
  
  Future<void> sendTransaction(String toAddress, double amount) async {
    final destinationAddress = solana.Ed25519HDPublicKey.fromBase58(toAddress);

    final lampAmount = (amount * solana.lamportsPerSol).toInt();

    final wallet = await solana.Ed25519HDKeyPair.fromMnemonic(
        _walletController.value.mnemonic);

    final instruction = solana.SystemInstruction.transfer(
        fundingAccount: wallet.publicKey,
        recipientAccount: destinationAddress,
        lamports: lampAmount,
    );

    final message = solana.Message(
      instructions: [instruction],
    );

    final _ = await _solanaClient.sendAndConfirmTransaction(
        message: message,
        signers: [wallet],
        commitment: solana.Commitment.confirmed,
    );

    await update();
  }

  Future<void> requestFunds() async {
    _solanaClient.requestAirdrop(
        address: solana.Ed25519HDPublicKey.fromBase58(_walletController.value.address),
        lamports: 2 * solana.lamportsPerSol
    );
  }
  
  Future<void> getPk() async {
    final pk = await _storage.read(key: _walletKey);
    _walletController.add(_walletController.value.copyWith(mnemonic: pk!));
  }
}