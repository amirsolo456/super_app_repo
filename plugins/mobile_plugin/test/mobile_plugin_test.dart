import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_plugin/mobile_plugin.dart';
import 'package:mobile_plugin/mobile_plugin_platform_interface.dart';
import 'package:mobile_plugin/mobile_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMobilePluginPlatform
    with MockPlatformInterfaceMixin
    implements MobilePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MobilePluginPlatform initialPlatform = MobilePluginPlatform.instance;

  test('$MethodChannelMobilePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMobilePlugin>());
  });

  test('getPlatformVersion', () async {
    MobilePlugin mobilePlugin = MobilePlugin();
    MockMobilePluginPlatform fakePlatform = MockMobilePluginPlatform();
    MobilePluginPlatform.instance = fakePlatform;

    expect(await mobilePlugin.getPlatformVersion(), '42');
  });
}
