import 'package:json_annotation/json_annotation.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_response.dart';

part 'save_data_response.g.dart';

@JsonSerializable()
class HistoryATSResponse {
  String? uploadName;
  FileUploadResponse? uploadResponse;

  HistoryATSResponse({this.uploadName, this.uploadResponse});

  factory HistoryATSResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryATSResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryATSResponseToJson(this);
}
