import 'package:wallet/features/local_auth/domain/entities/local_credentials.dart';
import '../entities/auth_status.dart';

abstract interface class LocalAuthRepository {
  Stream<LocalAuthStatus> getStatus();

  Future<void> setPin(LocalCredentials credentials);
  Future<void> verifyPin(LocalCredentials credentials);
  Future<void> changePin(LocalCredentials oldCredentials, LocalCredentials newCredentials);
  Future<String?> getPin();
}
