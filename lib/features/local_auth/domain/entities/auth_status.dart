import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wallet/features/local_auth/domain/entities/local_credentials.dart';

part 'auth_status.freezed.dart';

abstract class LocalAuthStatus {
  const LocalAuthStatus();
}

class LocalAuthStatusUninitialized extends LocalAuthStatus {
  const LocalAuthStatusUninitialized();
}

class LocalAuthStatusSetupRequired extends LocalAuthStatus {
  const LocalAuthStatusSetupRequired();
}

@freezed
class LocalAuthStatusAuthenticated extends LocalAuthStatus with _$LocalAuthStatusAuthenticated {
  const factory LocalAuthStatusAuthenticated({required LocalCredentials credentials}) = _LocalAuthStatusAuthenticated;
}

class LocalAuthStatusInvalidCredentials extends LocalAuthStatus {
  const LocalAuthStatusInvalidCredentials();
}

class LocalAuthStatusUnauthenticated extends LocalAuthStatus {
  const LocalAuthStatusUnauthenticated();
}
