#include "include/desktop_plugin/desktop_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "desktop_plugin.h"

void DesktopPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  desktop_plugin::DesktopPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
