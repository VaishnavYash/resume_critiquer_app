import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:resume_critiquer_app/model/file_upload/file_upload_hive.dart';
import 'package:resume_critiquer_app/model/other/build_resume_save.dart';

class HiveBuildResume {
  // Save Only One Response
  static Future<void> saveOneResponses(HistoryResumeResponse response) async {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');
    box.add(FileUploadATSHive(jsonEncode(response.toJson())));
  }

  // Insert at a Index
  static Future<void> insertAtIndex(
    int index,
    HistoryResumeResponse response,
  ) async {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');

    if (index >= box.length) {
      await box.add(FileUploadATSHive(jsonEncode(response.toJson())));
    } else {
      await box.putAt(index, FileUploadATSHive(jsonEncode(response.toJson())));
    }
  }

  // Save Response
  static Future<void> saveResponses(
    List<HistoryResumeResponse> responses,
  ) async {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');

    await box.clear();

    for (final response in responses) {
      box.add(FileUploadATSHive(jsonEncode(response.toJson())));
    }
  }

  // Read Index-Wise
  static HistoryResumeResponse getResponseAt(int index) {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');

    final jsonString = box.getAt(index)!.json;

    return HistoryResumeResponse.fromJson(jsonDecode(jsonString));
  }

  // Get ALL Response
  static List<HistoryResumeResponse> getAllResponses() {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');

    return box.values.map((e) {
      return HistoryResumeResponse.fromJson(jsonDecode(e.json));
    }).toList();
  }

  // Delete by Index
  static void deleteByIndex(final index) {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');
    box.deleteAt(index);
    return;
  }

  // Update by Index
  static void updateByIndex(final index, final updatedResponse) {
    final box = Hive.box<FileUploadATSHive>('newResumeBox');
    box.putAt(index, FileUploadATSHive(jsonEncode(updatedResponse.toJson())));

    return;
  }
}
