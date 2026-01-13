// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileUploadHiveAdapter extends TypeAdapter<FileUploadHive> {
  @override
  final int typeId = 2;

  @override
  FileUploadHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FileUploadHive(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FileUploadHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.json);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileUploadHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
