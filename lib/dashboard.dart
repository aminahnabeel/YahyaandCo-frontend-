import 'package:flutter/material.dart';
import 'pages/home_dashboard.dart';
import 'pages/transactions_page.dart';
import 'pages/accounts_page.dart';
import 'pages/ledger_accounts_page.dart';
import 'pages/settings_page.dart';
import 'widgets/appbar.dart';

class DashboardMainScreen extends StatefulWidget {
  final String businessName;
  const DashboardMainScreen({super.key, required this.businessName});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  int _currentIndex = 0;
    static const List<String> _tabTitles = [
    'Home',
    'Transactions',
    'Accounts',
    'Ledger',
    'Settings',
  ];
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
    final pages = [
      HomeDashboard(businessName: widget.businessName),
      const TransactionsPage(),
      const AccountsPage(),
      const LedgerAccountsPage(),
      const SettingsPage(),
    ];

    // WillPopScope is deprecated in newer Flutter SDKs in favor of PopScope.
    // Keep using WillPopScope here to preserve the familiar onWillPop
    // behavior for nested navigators and add an ignore for the deprecation.
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: CustomAppBar(title: _tabTitles[_currentIndex], showTitle: true),
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
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance),
              label: 'Accounts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Ledger',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
