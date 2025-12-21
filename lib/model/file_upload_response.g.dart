// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      atsScore: json['ats_score'] as int?,
      summary: json['summary'] as String?,
      analysis:
          (json['analysis'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList(),
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'ats_score': instance.atsScore,
      'summary': instance.summary,
      'analysis': instance.analysis,
    };
