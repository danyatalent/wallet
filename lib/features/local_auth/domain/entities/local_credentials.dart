import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_credentials.freezed.dart';

@freezed
class LocalCredentials with _$LocalCredentials {
  const factory LocalCredentials({required String pinCode}) = _LocalCredentials;
}