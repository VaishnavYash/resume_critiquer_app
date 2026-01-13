import 'package:json_annotation/json_annotation.dart';
import 'package:resume_critiquer_app/build_resume/model/file_upload_response.dart';

part 'save_data_response.g.dart';

@JsonSerializable()
class HistoryResponse{

  String? uploadName;
  FileUploadResponse? uploadResponse;

  HistoryResponse({
    this.uploadName,
    this.uploadResponse,
  });
  
  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);

}