import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wallet/features/local_auth/domain/entities/auth_status.dart';
import 'package:wallet/features/local_auth/domain/entities/local_credentials.dart';


class SecureStorageApi {
  final FlutterSecureStorage _storage;
  static const _pinKey = 'user_pin';
  
  final _statusController = BehaviorSubject<LocalAuthStatus>.seeded(const LocalAuthStatusUninitialized());

  SecureStorageApi() : _storage = const FlutterSecureStorage() {
    _initializeStatus();
  }

  void _initializeStatus() async {
    final pinCode = await getPin();
    if (pinCode == null) {
      _statusController.add(const LocalAuthStatusSetupRequired());
    } else {
      _statusController.add(const LocalAuthStatusUnauthenticated());
    }
  }

  Stream<LocalAuthStatus> getStatus() => _statusController.asBroadcastStream();

  Future<void> setPin(LocalCredentials credentials) async {
    await _storage.write(key: _pinKey, value: credentials.pinCode);
    _statusController.add(const LocalAuthStatusUnauthenticated());
  }

  Future<void> verifyPin(LocalCredentials credentials) async {
    final storedPin = await getPin();
    if (storedPin == credentials.pinCode) {
      _statusController.add(LocalAuthStatusAuthenticated(credentials: credentials));
    } else {
      _statusController.add(const LocalAuthStatusInvalidCredentials());
    }
  }

  Future<void> changePin(LocalCredentials oldCredentials, LocalCredentials newCredentials) async {
    final storedPin = await getPin();
    if (storedPin == oldCredentials.pinCode) {
      await setPin(newCredentials);
    } else {
      _statusController.add(const LocalAuthStatusInvalidCredentials());
    }
  }

  Future<String?> getPin() async {
    return await _storage.read(key: _pinKey);
  }

  Future<void> close() async {
    await _statusController.close();
  }
}

