#ifndef FLUTTER_PLUGIN_DESKTOP_PLUGIN_H_
#define FLUTTER_PLUGIN_DESKTOP_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace desktop_plugin {

class DesktopPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DesktopPlugin();

  virtual ~DesktopPlugin();

  // Disallow copy and assign.
  DesktopPlugin(const DesktopPlugin&) = delete;
  DesktopPlugin& operator=(const DesktopPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace desktop_plugin

#endif  // FLUTTER_PLUGIN_DESKTOP_PLUGIN_H_
