import 'package:wallet/features/local_auth/data/local-auth/secure_storage_api.dart';
import 'package:wallet/features/local_auth/domain/entities/auth_status.dart';
import 'package:wallet/features/local_auth/domain/entities/local_credentials.dart';
import 'package:wallet/features/local_auth/domain/repository/local_auth_repository.dart';

class LocalAuthRepositoryImpl implements LocalAuthRepository {
  final SecureStorageApi _secureStorageApi;

  LocalAuthRepositoryImpl(this._secureStorageApi);

  @override
  Future<void> changePin(LocalCredentials oldCredentials, LocalCredentials newCredentials) {
    return _secureStorageApi.changePin(oldCredentials, newCredentials);
  }

  @override
  Stream<LocalAuthStatus> getStatus() {
    return _secureStorageApi.getStatus();
  }

  @override
  Future<void> setPin(LocalCredentials credentials) {
    return _secureStorageApi.setPin(credentials);
  }

  @override
  Future<void> verifyPin(LocalCredentials credentials) {
    return _secureStorageApi.verifyPin(credentials);
  }

  @override
  Future<String?> getPin() {
    return _secureStorageApi.getPin();
  }

}