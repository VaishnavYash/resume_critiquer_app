import 'package:hive/hive.dart';

part 'file_upload_hive.g.dart';

@HiveType(typeId: 2)
class FileUploadHive extends HiveObject {
  @HiveField(0)
  final String json; // Full JSON as String

  FileUploadHive(this.json);
}
