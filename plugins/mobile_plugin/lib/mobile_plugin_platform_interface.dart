import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mobile_plugin_method_channel.dart';

abstract class MobilePluginPlatform extends PlatformInterface {
  /// Constructs a MobilePluginPlatform.
  MobilePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MobilePluginPlatform _instance = MethodChannelMobilePlugin();

  /// The default instance of [MobilePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMobilePlugin].
  static MobilePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MobilePluginPlatform] when
  /// they register themselves.
  static set instance(MobilePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
