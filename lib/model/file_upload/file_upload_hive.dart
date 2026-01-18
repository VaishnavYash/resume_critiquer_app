import 'package:hive/hive.dart';

part 'file_upload_hive.g.dart';

@HiveType(typeId: 2)
class FileUploadATSHive extends HiveObject {
  @HiveField(0)
  final String json;

  FileUploadATSHive(this.json);
}
