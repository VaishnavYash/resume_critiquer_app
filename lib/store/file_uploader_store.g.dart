// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_uploader_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FileUploaderStore on FileUploaderBaseStore, Store {
  late final _$isLoadingAtom = Atom(
    name: 'FileUploaderBaseStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fileAtom = Atom(
    name: 'FileUploaderBaseStore.file',
    context: context,
  );

  @override
  PlatformFile? get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(PlatformFile? value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  late final _$uploadedFileResponseAtom = Atom(
    name: 'FileUploaderBaseStore.uploadedFileResponse',
    context: context,
  );

  @override
  ObservableFuture<FileUploadStatus>? get uploadedFileResponse {
    _$uploadedFileResponseAtom.reportRead();
    return super.uploadedFileResponse;
  }

  @override
  set uploadedFileResponse(ObservableFuture<FileUploadStatus>? value) {
    _$uploadedFileResponseAtom.reportWrite(
      value,
      super.uploadedFileResponse,
      () {
        super.uploadedFileResponse = value;
      },
    );
  }

  late final _$isFileUploadedAtom = Atom(
    name: 'FileUploaderBaseStore.isFileUploaded',
    context: context,
  );

  @override
  bool get isFileUploaded {
    _$isFileUploadedAtom.reportRead();
    return super.isFileUploaded;
  }

  @override
  set isFileUploaded(bool value) {
    _$isFileUploadedAtom.reportWrite(value, super.isFileUploaded, () {
      super.isFileUploaded = value;
    });
  }

  late final _$uploadFileAsyncAction = AsyncAction(
    'FileUploaderBaseStore.uploadFile',
    context: context,
  );

  @override
  Future<void> uploadFile() {
    return _$uploadFileAsyncAction.run(() => super.uploadFile());
  }

  late final _$uploadFileApiAsyncAction = AsyncAction(
    'FileUploaderBaseStore.uploadFileApi',
    context: context,
  );

  @override
  Future<FileUploadStatus> uploadFileApi(
    String jobTextField,
    String companyTextField,
  ) {
    return _$uploadFileApiAsyncAction.run(
      () => super.uploadFileApi(jobTextField, companyTextField),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
file: ${file},
uploadedFileResponse: ${uploadedFileResponse},
isFileUploaded: ${isFileUploaded}
    ''';
  }
}
