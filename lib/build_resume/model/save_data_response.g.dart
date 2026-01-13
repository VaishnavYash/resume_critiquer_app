// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponse _$HistoryResponseFromJson(Map<String, dynamic> json) =>
    HistoryResponse(
      uploadName: json['uploadName'] as String?,
      uploadResponse: json['uploadResponse'] == null
          ? null
          : FileUploadResponse.fromJson(
              json['uploadResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoryResponseToJson(HistoryResponse instance) =>
    <String, dynamic>{
      'uploadName': instance.uploadName,
      'uploadResponse': instance.uploadResponse,
    };
