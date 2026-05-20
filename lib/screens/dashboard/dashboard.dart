import 'package:flutter/material.dart';
import 'home_dashboard.dart';
import '../transactions/transactions_page.dart';
import '../accounts/accounts_page.dart';
import '../search/search_page.dart';
import '../reports/reports_page.dart';
import '../settings/settings_page.dart';
import '../starting/language/app_language.dart';
import '../../widgets/appbar.dart';

class DashboardMainScreen extends StatefulWidget {
  final String businessName;
  const DashboardMainScreen({super.key, required this.businessName});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  int _currentIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  void _selectTab(int index) {
    if (index == _currentIndex) {
      _navigatorKeys[index].currentState?.popUntil((r) => r.isFirst);
    } else {
      setState(() => _currentIndex = index);
    }
  }

  Widget _buildOffstageNavigator(int index, Widget child) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (_) => MaterialPageRoute(builder: (_) => child),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final NavigatorState currentNav =
        _navigatorKeys[_currentIndex].currentState!;
    if (currentNav.canPop()) {
      currentNav.pop();
      return false;
    }
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final strings = appLanguageController.strings;
    final tabTitles = [
      strings.homeTabTitle,
      strings.transactionsTabTitle,
      strings.accountsTabTitle,
      appLanguageController.tr('Reports'),
      strings.settingsTabTitle,
    ];

    final pages = [
      HomeDashboard(businessName: widget.businessName),
      const TransactionsPage(),
      const AccountsPage(),
      const ReportsPage(),
      const SettingsPage(),
    ];

    // WillPopScope is deprecated in newer Flutter SDKs in favor of PopScope.
    // Keep using WillPopScope here to preserve the familiar onWillPop
    // behavior for nested navigators and add an ignore for the deprecation.
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(
          title: tabTitles[_currentIndex],
          showTitle: true,
          actions: _currentIndex == 0
              ? [
                  IconButton(
                    tooltip: appLanguageController.tr('Search'),
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (_) => const SearchPage(),
                        ),
                      );
                    },
                  ),
                ]
              : null,
        ),
        body: Stack(
          children: List.generate(
            pages.length,
            (i) => _buildOffstageNavigator(i, pages[i]),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _selectTab,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.onSurface.withAlpha((0.6 * 255).round()),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: strings.homeTabTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.swap_horiz),
              label: strings.transactionsTabTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_balance),
              label: strings.accountsTabTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.assessment),
              label: appLanguageController.tr('Reports'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: strings.settingsTabTitle,
            ),
          ],
        ),
      ),
    );
  }
}
