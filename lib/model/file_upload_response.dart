class FileUploadResponse {
  String? message;
  FileUploadResponse({this.message});

  FileUploadResponse.fromJson(Map<String, dynamic> json, this.message) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
