import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SafeArea(
        child: Center(
          child: Text(
            'Welcome to ${AppStrings.appName}! This is the dashboard.',
          ),
        ),
      ),
    );
  }
}
