import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'desktop_plugin_platform_interface.dart';

/// An implementation of [DesktopPluginPlatform] that uses method channels.
class MethodChannelDesktopPlugin extends DesktopPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('desktop_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
