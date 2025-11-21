import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'desktop_plugin_method_channel.dart';

abstract class DesktopPluginPlatform extends PlatformInterface {
  /// Constructs a DesktopPluginPlatform.
  DesktopPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static DesktopPluginPlatform _instance = MethodChannelDesktopPlugin();

  /// The default instance of [DesktopPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelDesktopPlugin].
  static DesktopPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DesktopPluginPlatform] when
  /// they register themselves.
  static set instance(DesktopPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
