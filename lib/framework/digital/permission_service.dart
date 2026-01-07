import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  static Future<bool> requestStoragePermission() async {
    PermissionStatus status;

    if (await Permission.storage.isGranted) {
      return true;
    }

    status = await Permission.storage.request();

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return false;
  }
}
