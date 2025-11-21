import 'package:flutter_test/flutter_test.dart';
import 'package:desktop_plugin/desktop_plugin.dart';
import 'package:desktop_plugin/desktop_plugin_platform_interface.dart';
import 'package:desktop_plugin/desktop_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDesktopPluginPlatform
    with MockPlatformInterfaceMixin
    implements DesktopPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DesktopPluginPlatform initialPlatform = DesktopPluginPlatform.instance;

  test('$MethodChannelDesktopPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDesktopPlugin>());
  });

  test('getPlatformVersion', () async {
    DesktopPlugin desktopPlugin = DesktopPlugin();
    MockDesktopPluginPlatform fakePlatform = MockDesktopPluginPlatform();
    DesktopPluginPlatform.instance = fakePlatform;

    expect(await desktopPlugin.getPlatformVersion(), '42');
  });
}
