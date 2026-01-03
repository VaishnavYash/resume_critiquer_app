import 'package:json_annotation/json_annotation.dart';

part 'file_upload_response.g.dart';

@JsonSerializable()
class FileUploadResponse {
  @JsonKey(name: 'ats_score')
  int? atsScore;
  String? summary;
  Map<String, Map<String, CardMainContent>>? analysis;
  FileUploadResponse({this.atsScore, this.summary, this.analysis});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);
}

@JsonSerializable()
class CardMainContent {
  @JsonKey(name: "data")
  List<String>? data;
  @JsonKey(name: "whyThisMatter")
  String? whyThisMatter;

  CardMainContent({this.data, this.whyThisMatter});

  factory CardMainContent.fromJson(Map<String, dynamic> json) =>
      _$CardMainContentFromJson(json);

  Map<String, dynamic> toJson() => _$CardMainContentToJson(this);
}
