part of 'local_auth_bloc.dart';

enum BlocLocalAuthStatus {
  initial,
  setupRequired,
  authenticated,
  unauthenticated,
  wrongCredentials,
  loading,
  failure,
  settingUp,
  pinVerified,
}

@Freezed(equal: false)
class LocalAuthState with EquatableMixin, _$LocalAuthState {
  const LocalAuthState._();

  const factory LocalAuthState(
      {required BlocLocalAuthStatus status,
      required String pinCode}) = _LocalAuthState;

  @override
  List<Object?> get props => [status, pinCode];
}