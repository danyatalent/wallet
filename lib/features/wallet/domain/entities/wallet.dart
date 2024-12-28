import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet.freezed.dart';

@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String address,
    required String mnemonic,
    required String balance,
    required String privateKey
  }) = _Wallet;
}