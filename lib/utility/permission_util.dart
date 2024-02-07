import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static Future<void> requestCameraPermission() async {
    const permission = Permission.camera;
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  static Future<bool> checkCameraPermissionStatus() async {
    const permission = Permission.camera;
    return await permission.status.isGranted;
  }
}
