import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_token_model.freezed.dart';
part 'request_token_model.g.dart';

@freezed
class RequestTokenModel with _$RequestTokenModel {
  factory RequestTokenModel({
    @JsonKey(name: 'request_token') required String requestToken,
    @JsonKey(name: 'success') required bool success,
    @JsonKey(name: 'expires_at') required String expiresAt,
  }) = _RequestTokenModel;

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RequestTokenModelFromJson(json);
}
