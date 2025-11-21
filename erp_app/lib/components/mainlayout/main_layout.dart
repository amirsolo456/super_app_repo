import 'dart:async';

import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';
import 'package:services_package/page_cache_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../pages/home/dashboard/dashboard.dart';
import '../../pages/lists/com/person/person_list_page.dart';
import '../../pages/profile/profile.dart';
import '../lists/list_appbar.dart';

class MainLayoutPage extends StatefulWidget {
  const MainLayoutPage({super.key});

  @override
  State<MainLayoutPage> createState() => _MainLayoutPageState();
}

class _MainLayoutPageState extends State<MainLayoutPage> {
  NavButtonTabBarMode _selectedTab = NavButtonTabBarMode.dashboardTabMode;

  late final Widget accountIcon = _paddedIcon('assets/images/account.png');
  late final Widget activeAccountIcon = _paddedIcon(
    'assets/images/activeaccount.png',
  );

  late final Widget defaultIcon = _paddedIcon('assets/images/defaults.png');
  late final Widget activeDefaultIcon = _paddedIcon(
    'assets/images/activedefaults.png',
  );

  late final Widget menuIcon = _paddedIcon('assets/images/menu.png');
  late final Widget activeMenuIcon = _paddedIcon(
    'assets/images/activemenu.png',
  );

  late final Widget openedIcon = _paddedIcon('assets/images/opened.png');
  late final Widget activeOpenedIcon = _paddedIcon(
    'assets/images/activeopened.png',
  );

  late final Widget newIcon = _paddedIcon('assets/images/new.png');
  late final Widget activeNewIcon = _paddedIcon('assets/images/activenew.png');

  final Map<int, Widget> _pageCache = {};
  late final PageCacheManager _cacheManager = PageCacheManager(
    maxAge: const Duration(minutes: 5),
  );

  final Map<int, bool> _showSkeleton = {};
  final Map<int, Timer> _skeletonTimers = {};
  static double size = 40;
  static double topPadding = 10;

  Widget _getPage(int index) {
    if (_pageCache.containsKey(index)) {
      _showSkeleton[index] = _showSkeleton[index] ?? false;

      return Skeletonizer(
        enabled: _showSkeleton[index] ?? false,
        child: _pageCache[index]!,
      );
    }
    final rawPage = _cacheManager.getOrCreate(index, () {
      switch (index) {
        case -1:
          return const DashboardPage();
        case 0:
          return const PersonListPage(refreshData: true);
        case 4:
          return const ProfilePage(refreshData: true);
        default:
          return Center(child: Text("صفحه ${index + 1}"));
      }
    });
    _pageCache[index] = rawPage;
    _showSkeleton[index] = true;
    _skeletonTimers[index]?.cancel();
    _skeletonTimers[index] = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() {
        _showSkeleton[index] = false;
      });
    });
    return Skeletonizer(enabled: true, child: rawPage);
  }

  Widget _paddedIcon(String assetPath) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Image.asset(assetPath, width: size, height: size),
    );
  }

  void _onItemTapped(NavButtonTabBarMode tab) {
    setState(() {
      _selectedTab = tab;
      _cacheManager.cleanCacheExcept(tab.value);
    });
  }

  PreferredSizeWidget _getAppBar(NavButtonTabBarMode tab) {
    switch (tab) {
      case NavButtonTabBarMode.menuTabMode:
        return ListAppBar(mode: AppBarsMode.erpApplicationMode);
      case NavButtonTabBarMode.profileTabMode:
        return ListAppBar(mode: AppBarsMode.defaultMode);
      case NavButtonTabBarMode.dashboardTabMode:
      default:
        return ListAppBar(mode: AppBarsMode.defaultMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabs = NavButtonTabBarMode.values;
    final currentIndex = tabs.indexOf(_selectedTab);

    return Scaffold(
      appBar: _getAppBar(_selectedTab),
      body: IndexedStack(
        index: _selectedTab.value,
        children: List.generate(
          5,
          (i) => i == _selectedTab.value ? _getPage(i) : const SizedBox(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: currentIndex,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            iconSize: 50,
            elevation: 0,
            onTap: (index) {
              if (index >= 0 && index < tabs.length) {
                _onItemTapped(tabs[index]);
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: menuIcon,
                activeIcon: activeMenuIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: newIcon,
                activeIcon: activeNewIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: openedIcon,
                activeIcon: activeOpenedIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: defaultIcon,
                activeIcon: activeDefaultIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: accountIcon,
                activeIcon: activeAccountIcon,
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /*  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(_selectedTab),
      body: IndexedStack(
        index: _selectedTab.value,
        alignment: Alignment.center,
        children: List.generate(
          5,
          (i) => i == _selectedTab.value
              ? _getPage(i)
              : _pageCache[i] ?? const SizedBox(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _selectedTab.value,
            enableFeedback: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            iconSize: 50,
            elevation: 0,
            onTap: (index) => _onItemTapped(NavButtonTabBarMode.values[index]),
            items: [
              BottomNavigationBarItem(
                icon: menuIcon,
                activeIcon: activeMenuIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: newIcon,
                activeIcon: activeNewIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: openedIcon,
                activeIcon: activeOpenedIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: defaultIcon,
                activeIcon: activeDefaultIcon,
                label: '',
              ),
              BottomNavigationBarItem(
                icon: accountIcon,
                activeIcon: activeAccountIcon,
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }*/
}
