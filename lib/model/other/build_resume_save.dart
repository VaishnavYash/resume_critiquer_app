import 'package:json_annotation/json_annotation.dart';
import 'package:resume_critiquer_app/model/build_resume/build_resume_model.dart';

part 'build_resume_save.g.dart';

@JsonSerializable()
class HistoryResumeResponse {
  String? uploadName;
  BuildResumeContent? uploadResponse;

  HistoryResumeResponse({this.uploadName, this.uploadResponse});

  factory HistoryResumeResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResumeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryResumeResponseToJson(this);
}
