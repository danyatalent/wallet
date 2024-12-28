part of 'wallet_bloc.dart';

@freezed
class WalletEvent with _$WalletEvent {
  const factory WalletEvent.started() = _Started;
  const factory WalletEvent.refresh() = _Refresh;
  const factory WalletEvent.requestFunds() = _RequestFunds;
  const factory WalletEvent.getPk() = _GetPk;
}