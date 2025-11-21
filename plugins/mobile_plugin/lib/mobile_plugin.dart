
import 'mobile_plugin_platform_interface.dart';

class MobilePlugin {
  Future<String?> getPlatformVersion() {
    return MobilePluginPlatform.instance.getPlatformVersion();
  }
}
