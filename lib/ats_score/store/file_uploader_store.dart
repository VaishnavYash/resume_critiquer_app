import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:resume_critiquer_app/ats_score/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/file_response_error.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';

part 'file_uploader_store.g.dart';

class FileUploaderStore = FileUploaderBaseStore with _$FileUploaderStore;

abstract class FileUploaderBaseStore with Store {
  @observable
  bool isLoading = false;

  @observable
  PlatformFile? file;

  @observable
  ObservableFuture<FileUploadStatus>? uploadedFileResponse;

  @observable
  bool isFileUploaded = false;
  @action
  Future<void> uploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      file = result.files.first;
      isFileUploaded = true;
    } else {
      isFileUploaded = false;
    }
  }

  @action
  Future<FileUploadStatus> uploadFileApi(
    String jobTextField,
  ) async {
    if (file == null || file!.path == null) {
      throw ApiException(
        code: 'NO_FILE',
        message: 'Please select a file first',
      );
    }

    final response = await MultipartApi().fileUploadMultipart(
      file: File(file!.path!),
      jobTtile: jobTextField,
    );

    uploadedFileResponse = ObservableFuture.value(response);
    return response;
  }
}
