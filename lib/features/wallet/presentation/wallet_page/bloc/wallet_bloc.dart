import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/wallet/domain/entities/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';
part 'wallet_bloc.freezed.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _walletRepository;
  Timer? _timer;

  WalletBloc(this._walletRepository)
    : super(const WalletState(wallet: Wallet(address: '', mnemonic: '', balance: ''))) {
    on<WalletEvent>(_onWalletEvent);
  }

  Future<void> _onWalletEvent(
      WalletEvent event, Emitter<WalletState> emit) async {
      _walletRepository.update();

      await emit.forEach(
        _walletRepository.getWallet(),
        onData: (wallet) => state.copyWith(wallet: wallet!),
      );
      if (event is _Started) {
        _startUpdateTimer(emit);
      }
  }

  void _startUpdateTimer(Emitter<WalletState> emit) {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      _walletRepository.update();
      await emit.forEach(
          _walletRepository.getWallet(),
          onData: (wallet) => state.copyWith(wallet: wallet),
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }}