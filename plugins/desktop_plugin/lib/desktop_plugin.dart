
import 'desktop_plugin_platform_interface.dart';

class DesktopPlugin {
  Future<String?> getPlatformVersion() {
    return DesktopPluginPlatform.instance.getPlatformVersion();
  }
}
