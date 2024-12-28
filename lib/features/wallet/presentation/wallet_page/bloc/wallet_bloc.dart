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
      : super(const WalletState(wallet: Wallet(address: '', balance: '', mnemonic: ''))) {
    on<_Started>(_onStarted);
    on<_RequestFunds>(_onRequestFunds);
    on<_Refresh>(_onRefresh);
    on<_GetPk>(_onGetPk);

    // Запускаем таймер при инициализации блока
    _startUpdateTimer();
  }

  Future<void> _onStarted(
      _Started event, Emitter<WalletState> emit) async {
    await _updateWallet(emit);
  }

  Future<void> _onRequestFunds(
      _RequestFunds event, Emitter<WalletState> emit) async {
    await _walletRepository.requestFunds();
  }

  Future<void> _onRefresh(
      _Refresh event, Emitter<WalletState> emit) async {
    await _updateWallet(emit);
  }

  Future<void> _updateWallet(Emitter<WalletState> emit) async {
    _walletRepository.update();

    print(state.wallet.mnemonic);
    await emit.forEach(
      _walletRepository.getWallet(),
      onData: (wallet) => state.copyWith(wallet: wallet),
    );
  }

  void _startUpdateTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      add(const WalletEvent.refresh());
    });
  }

  Future<void> _onGetPk(
      _GetPk event, Emitter<WalletState> emit) async {
    await _walletRepository.getPk();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
