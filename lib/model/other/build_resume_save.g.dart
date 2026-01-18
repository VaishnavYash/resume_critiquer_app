// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_resume_save.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResumeResponse _$HistoryResumeResponseFromJson(
        Map<String, dynamic> json) =>
    HistoryResumeResponse(
      uploadName: json['uploadName'] as String?,
      uploadResponse: json['uploadResponse'] == null
          ? null
          : BuildResumeContent.fromJson(
              json['uploadResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HistoryResumeResponseToJson(
        HistoryResumeResponse instance) =>
    <String, dynamic>{
      'uploadName': instance.uploadName,
      'uploadResponse': instance.uploadResponse,
    };
