// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      atsScore: (json['ats_score'] as num?)?.toInt(),
      summary: json['summary'] as String?,
      analysis: (json['analysis'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as Map<String, dynamic>).map(
            (k, e) => MapEntry(
              k,
              CardMainContent.fromJson(e as Map<String, dynamic>),
            ),
          ),
        ),
      ),
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{
      'ats_score': instance.atsScore,
      'summary': instance.summary,
      'analysis': instance.analysis,
    };

CardMainContent _$CardMainContentFromJson(Map<String, dynamic> json) =>
    CardMainContent(
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
      whyThisMatter: json['whyThisMatter'] as String?,
    );

Map<String, dynamic> _$CardMainContentToJson(CardMainContent instance) =>
    <String, dynamic>{
      'data': instance.data,
      'whyThisMatter': instance.whyThisMatter,
    };
