part of 'local_auth_bloc.dart';

abstract class LocalAuthEvent {
  const LocalAuthEvent();
}

class LocalAuthEventSubscriptionRequested extends LocalAuthEvent {
  const LocalAuthEventSubscriptionRequested();
}

@Freezed(equal: false)
class LocalAuthEventPinChanged extends LocalAuthEvent
    with EquatableMixin, _$LocalAuthEventPinChanged {
  const LocalAuthEventPinChanged._();

  const factory LocalAuthEventPinChanged({required String pinCode}) = _LocalAuthEventPinChanged;

  @override
  List<Object?> get props => [pinCode];
}

class LocalAuthEventVerify extends LocalAuthEvent {
  const LocalAuthEventVerify();
}

class LocalAuthEventPinSetup extends LocalAuthEvent {
  const LocalAuthEventPinSetup();
}

class LocalAuthEventPinVerify extends LocalAuthEvent {
  const LocalAuthEventPinVerify();
}