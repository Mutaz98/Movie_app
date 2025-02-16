// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequestTokenModelImpl _$$RequestTokenModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RequestTokenModelImpl(
      requestToken: json['request_token'] as String,
      success: json['success'] as bool,
      expiresAt: json['expires_at'] as String,
    );

Map<String, dynamic> _$$RequestTokenModelImplToJson(
        _$RequestTokenModelImpl instance) =>
    <String, dynamic>{
      'request_token': instance.requestToken,
      'success': instance.success,
      'expires_at': instance.expiresAt,
    };
