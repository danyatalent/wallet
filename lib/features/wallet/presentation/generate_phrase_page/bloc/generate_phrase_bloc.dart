import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/wallet/domain/entities/wallet.dart';
import 'package:wallet/features/wallet/domain/repository/wallet_repository.dart';

part 'generate_phrase_event.dart';
part 'generate_phrase_state.dart';
part 'generate_phrase_bloc.freezed.dart';

class GeneratePhraseBloc extends Bloc<GeneratePhraseEvent, GeneratePhraseState> {
  final WalletRepository _walletRepository;

  GeneratePhraseBloc(this._walletRepository)
      : super(const GeneratePhraseState(wallet: Wallet(address: '', mnemonic: '', balance: ''))) {
    on<GeneratePhraseEvent>(_onGeneratePhraseEvent);
  }

  Future<void> _onGeneratePhraseEvent(
      GeneratePhraseEvent event, Emitter<GeneratePhraseState> emit) async {
    _walletRepository.update();

    await emit.forEach(
      _walletRepository.getWallet(),
      onData: (wallet) => state.copyWith(wallet: wallet),
    );
  }
}