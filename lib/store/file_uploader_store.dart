import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:resume_critiquer_app/api/multipart_api.dart';
import 'package:resume_critiquer_app/model/file_upload_response.dart';

part 'file_uploader_store.g.dart';

class FileUploaderStore = FileUploaderBaseStore with _$FileUploaderStore;

abstract class FileUploaderBaseStore with Store {
  @observable
  bool isLoading = false;

  @observable
  PlatformFile? file;

  @observable
  ObservableFuture<FileUploadResponse>? uploadedFile;

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
  Future<FileUploadResponse> uploadFileApi(
    String jobTextField,
    String companyTextField,
  ) async {
    if (file == null || file!.path == null) {
      throw Exception("No file selected");
    }

    final response = await MultipartApi().fileUploadMultipart(
      file: File(file!.path!),
      jobTtile: jobTextField,
      company: companyTextField,
    );

    if (response.summary == null) {
      return ObservableFuture.error(response);
    } else {
      return uploadedFile = ObservableFuture.value(response);
    }
  }
}
