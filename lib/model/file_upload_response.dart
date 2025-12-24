import 'package:json_annotation/json_annotation.dart';

part 'file_upload_response.g.dart';

@JsonSerializable()
class FileUploadResponse {
  @JsonKey(name: 'ats_score')
  int? atsScore;
  String? summary;
  Map<String, Map<String, List<String>>>? analysis;
  FileUploadResponse({this.atsScore, this.summary, this.analysis});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);
}
