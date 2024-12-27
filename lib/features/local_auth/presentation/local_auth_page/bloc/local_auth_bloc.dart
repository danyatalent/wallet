import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet/features/local_auth/domain/entities/auth_status.dart';
import 'package:wallet/features/local_auth/domain/entities/local_credentials.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_auth_state.dart';
part 'local_auth_event.dart';
part 'local_auth_bloc.freezed.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  final LocalAuthRepository _localAuthRepository;

  LocalAuthBloc(this._localAuthRepository)
    : super(const LocalAuthState(status: BlocLocalAuthStatus.initial, pinCode: '')) {
    on<LocalAuthEventSubscriptionRequested>(_onLocalAuthEventSubscriptionRequested);
    on<LocalAuthEventPinChanged>(_onLocalAuthEventPinChanged);
    on<LocalAuthEventPinSetup>(_onLocalAuthEventPinSetup);
    on<LocalAuthEventVerify>(_onLocalAuthEventLogIn);
    on<LocalAuthEventPinVerify>(_onLocalAuthEventPinVerify);
  }


  Future<void> _onLocalAuthEventSubscriptionRequested(
      LocalAuthEventSubscriptionRequested event, Emitter<LocalAuthState> emit) async {
    await emit.forEach(_localAuthRepository.getStatus(),
        onData: _onLocalAuthEventSubscriptionRequestedData,
        onError: (_, __) => state.copyWith(status: BlocLocalAuthStatus.failure));
  }

  LocalAuthState _onLocalAuthEventSubscriptionRequestedData(LocalAuthStatus authStatus) {
    if (authStatus is LocalAuthStatusAuthenticated) {
      return state.copyWith(status: BlocLocalAuthStatus.authenticated);
    }

    if (authStatus is LocalAuthStatusSetupRequired) {
      return state.copyWith(status: BlocLocalAuthStatus.setupRequired);
    }

    if (authStatus is LocalAuthStatusInvalidCredentials) {
      return state.copyWith(status: BlocLocalAuthStatus.wrongCredentials);
    }

    return state;
  }

  Future<void> _onLocalAuthEventPinChanged(
      LocalAuthEventPinChanged event, Emitter<LocalAuthState> emit) async {
    emit(state.copyWith(pinCode: event.pinCode));
  }

  Future<void> _onLocalAuthEventLogIn(
      LocalAuthEventVerify event, Emitter<LocalAuthState> emit) async {
    emit(state.copyWith(status: BlocLocalAuthStatus.loading));
    _localAuthRepository.verifyPin(LocalCredentials(pinCode: state.pinCode));
  }
  
  Future<void> _onLocalAuthEventPinSetup(
      LocalAuthEventPinSetup event, Emitter<LocalAuthState> emit) async {
    _localAuthRepository.setPin(LocalCredentials(pinCode: state.pinCode));
    emit(state.copyWith(status: BlocLocalAuthStatus.settingUp));
  }
  
  Future<void> _onLocalAuthEventPinVerify(
      LocalAuthEventPinVerify event, Emitter<LocalAuthState> emit) async {
    final pinSubmited = await _localAuthRepository.getPin();
    if (pinSubmited != state.pinCode) {
      emit(state.copyWith(status: BlocLocalAuthStatus.wrongCredentials));
    }
    emit(state.copyWith(status: BlocLocalAuthStatus.pinVerified));
    print('Pin verified');
  }

}
