import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/solana.dart' as solana;
import 'package:bip39/bip39.dart' as bip39;
import 'package:wallet/features/wallet/domain/entities/wallet.dart';
import 'package:solana/base58.dart';

class SolanaWalletApi {
  final solana.SolanaClient _solanaClient;
  final FlutterSecureStorage _storage;

  late final _walletController = BehaviorSubject<Wallet>.seeded(const Wallet(address: '', balance: '', mnemonic: '', privateKey: ''));

  // todo: make env
  static final rpcUrl = dotenv.env['RPC_DEV_URL'];
  static final wsUrl = dotenv.env['WS_DEV_URL'];
  static final _walletKey = dotenv.env['WALLET_KEY'];

  SolanaWalletApi() :
        _solanaClient = solana.SolanaClient(rpcUrl: Uri.parse(rpcUrl!), websocketUrl: Uri.parse(wsUrl!)),
        _storage = const FlutterSecureStorage();


  Stream<Wallet> getWallet() => _walletController.asBroadcastStream();

  Future update() async {
    var mnemonic = await _storage.read(key: _walletKey!);

    if (mnemonic == null) {
      mnemonic = bip39.generateMnemonic();
      await _storage.write(key: _walletKey!, value: mnemonic);
    }
    
    final keyPair = await solana.Ed25519HDKeyPair.fromMnemonic(mnemonic, account: 0, change: 0);
    final balanceResult = await _solanaClient.rpcClient.getBalance(keyPair.address, commitment: solana.Commitment.confirmed);
    final balance = (balanceResult.value / solana.lamportsPerSol).toString();
    final pk = await _getPk(keyPair);

    _walletController.add(_walletController.value.copyWith(
      address: keyPair.address,
      balance: balance,
      mnemonic: mnemonic,
      privateKey: pk,
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
  
  Future<String> _getPk(solana.Ed25519HDKeyPair pair) async{
    final pk =
      await pair.extract().then((value) => value.bytes).then(base58encode);
    return pk;
  }

}