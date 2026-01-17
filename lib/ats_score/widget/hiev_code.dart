import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_hive.dart';
import 'package:resume_critiquer_app/model/other/save_data_response.dart';

class HiveCode {
  // Save Only One Response
  static Future<void> saveOneResponses(HistoryResponse response) async {
    final box = Hive.box<FileUploadHive>('fileUploadBox');
    box.add(FileUploadHive(jsonEncode(response.toJson())));
  }

  // Insert at a Index
  static Future<void> insertAtIndex(int index, HistoryResponse response) async {
    final box = Hive.box<FileUploadHive>('fileUploadBox');

    if (index >= box.length) {
      await box.add(FileUploadHive(jsonEncode(response.toJson())));
    } else {
      await box.putAt(index, FileUploadHive(jsonEncode(response.toJson())));
    }
  }

  // Save Response
  static Future<void> saveResponses(List<HistoryResponse> responses) async {
    final box = Hive.box<FileUploadHive>('fileUploadBox');

    await box.clear();

    for (final response in responses) {
      box.add(FileUploadHive(jsonEncode(response.toJson())));
    }
  }

  // Read Index-Wise
  static HistoryResponse getResponseAt(int index) {
    final box = Hive.box<FileUploadHive>('fileUploadBox');

    final jsonString = box.getAt(index)!.json;

    return HistoryResponse.fromJson(jsonDecode(jsonString));
  }

  // Get ALL Response
  static List<HistoryResponse> getAllResponses() {
    final box = Hive.box<FileUploadHive>('fileUploadBox');

    return box.values.map((e) {
      return HistoryResponse.fromJson(jsonDecode(e.json));
    }).toList();
  }

  // Delete by Index
  static void deleteByIndex(final index) {
    final box = Hive.box<FileUploadHive>('fileUploadBox');
    box.deleteAt(index);
    return;
  }

  // Update by Index
  static void updateByIndex(final index, final updatedResponse) {
    final box = Hive.box<FileUploadHive>('fileUploadBox');
    box.putAt(index, FileUploadHive(jsonEncode(updatedResponse.toJson())));

    return;
  }
}
