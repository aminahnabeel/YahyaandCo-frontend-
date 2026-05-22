import 'package:flutter/material.dart';

import '../models/payment_reminder.dart';

class WorkspaceAccountSummary {
  const WorkspaceAccountSummary({
    required this.name,
    required this.type,
    required this.amount,
    required this.positive,
  });

  final String name;
  final String type;
  final String amount;
  final bool positive;
}

class WorkspaceReportSummary {
  const WorkspaceReportSummary({
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;
  final String value;
}

class BusinessMetrics {
  const BusinessMetrics({
    required this.totalBalance,
    required this.cashInHand,
    required this.receivables,
    required this.payables,
  });

  final String totalBalance;
  final String cashInHand;
  final String receivables;
  final String payables;
}

class BusinessWorkspaceData {
  const BusinessWorkspaceData({
    required this.id,
    required this.name,
    required this.type,
    required this.shortCode,
    required this.accentColor,
    required this.metrics,
    required this.accounts,
    required this.reminders,
    required this.reports,
  });

  final String id;
  final String name;
  final String type;
  final String shortCode;
  final Color accentColor;
  final BusinessMetrics metrics;
  final List<WorkspaceAccountSummary> accounts;
  final List<PaymentReminder> reminders;
  final List<WorkspaceReportSummary> reports;

  List<PaymentReminder> get recentTransactions => reminders.take(4).toList();

  BusinessWorkspaceData copyWith({
    String? id,
    String? name,
    String? type,
    String? shortCode,
    Color? accentColor,
    BusinessMetrics? metrics,
    List<WorkspaceAccountSummary>? accounts,
    List<PaymentReminder>? reminders,
    List<WorkspaceReportSummary>? reports,
  }) {
    return BusinessWorkspaceData(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      shortCode: shortCode ?? this.shortCode,
      accentColor: accentColor ?? this.accentColor,
      metrics: metrics ?? this.metrics,
      accounts: accounts ?? this.accounts,
      reminders: reminders ?? this.reminders,
      reports: reports ?? this.reports,
    );
  }

  static BusinessWorkspaceData create({
    required String id,
    required String name,
    required String type,
    required int seed,
  }) {
    final colors = [
      Colors.indigo,
      Colors.teal,
      Colors.green,
      Colors.deepOrange,
      Colors.blueGrey,
      Colors.cyan,
    ];
    final accentColor = colors[seed % colors.length];
    final shortCode = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();

    return BusinessWorkspaceData(
      id: id,
      name: name,
      type: type,
      shortCode: shortCode,
      accentColor: accentColor,
      metrics: BusinessMetrics(
        totalBalance: '₹${(480000 + seed * 82500).toString()}',
        cashInHand: '₹${(38000 + seed * 7100).toString()}',
        receivables: '₹${(98000 + seed * 5400).toString()}',
        payables: '₹${(62000 + seed * 4300).toString()}',
      ),
      accounts: [
        WorkspaceAccountSummary(
          name: 'Main Bank Account',
          type: 'Bank',
          amount: '₹${(215000 + seed * 8000).toString()}',
          positive: true,
        ),
        WorkspaceAccountSummary(
          name: 'Cash in Hand',
          type: 'Cash',
          amount: '₹${(38000 + seed * 1300).toString()}',
          positive: true,
        ),
        WorkspaceAccountSummary(
          name: 'Customer Accounts',
          type: 'Receivable',
          amount: '₹${(87000 + seed * 6200).toString()}',
          positive: true,
        ),
        WorkspaceAccountSummary(
          name: 'Supplier Accounts',
          type: 'Payable',
          amount: '-₹${(56000 + seed * 4900).toString()}',
          positive: false,
        ),
      ],
      reminders: _buildReminders(seed, name),
      reports: _buildReports(seed, name),
    );
  }

  static List<PaymentReminder> _buildReminders(int seed, String businessName) {
    final now = DateTime.now();
    final safeName = businessName.split(' ').first;
    return [
      PaymentReminder(
        id: '$seed-a',
        title: '$safeName Office Rent',
        account: 'Main Bank Account',
        amount: 14500 + seed * 900,
        isDebit: true,
        paymentMethod: 'Bank Transfer',
        transactionDate: now.subtract(Duration(days: seed + 1)),
        dueDate: now.subtract(Duration(days: seed.isEven ? 1 : 2)),
        status: PaymentReminderStatus.pending,
        notes: 'Monthly rent for the main workspace',
      ),
      PaymentReminder(
        id: '$seed-b',
        title: '$safeName Client Payment',
        account: 'Cash in Hand',
        amount: 42000 + seed * 1800,
        isDebit: false,
        paymentMethod: 'Cash',
        transactionDate: now.subtract(Duration(days: seed)),
        dueDate: now.add(Duration(days: seed + 1)),
        status: PaymentReminderStatus.completed,
        notes: 'Payment received from a regular customer',
      ),
      PaymentReminder(
        id: '$seed-c',
        title: '$safeName Utilities',
        account: 'Main Bank Account',
        amount: 3200 + seed * 250,
        isDebit: true,
        paymentMethod: 'Digital Wallet',
        transactionDate: now.subtract(Duration(days: seed)),
        dueDate: now.add(Duration(days: seed)),
        status: PaymentReminderStatus.pending,
        notes: 'Utilities and internet charges',
      ),
      PaymentReminder(
        id: '$seed-d',
        title: '$safeName Stock Purchase',
        account: 'Supplier Accounts',
        amount: 18200 + seed * 2100,
        isDebit: true,
        paymentMethod: 'Bank Transfer',
        transactionDate: now,
        dueDate: now.add(Duration(days: seed + 4)),
        status: seed.isEven
            ? PaymentReminderStatus.completed
            : PaymentReminderStatus.pending,
        notes: 'Inventory for the coming week',
      ),
    ];
  }

  static List<WorkspaceReportSummary> _buildReports(int seed, String name) {
    final subtitle = name.split(' ').first;
    return [
      WorkspaceReportSummary(
        title: 'Ledger',
        description: '$subtitle account-wise entries and running balance',
        icon: Icons.book,
        iconColor: Colors.deepOrange,
        value: '₹${(980000 + seed * 118000).toString()}',
      ),
      WorkspaceReportSummary(
        title: 'Trial Balance',
        description: '$subtitle debit and credit summary snapshot',
        icon: Icons.balance,
        iconColor: Colors.orange,
        value: 'Balanced',
      ),
      WorkspaceReportSummary(
        title: 'Cash Book',
        description: '$subtitle cash inflows and outflows',
        icon: Icons.monetization_on,
        iconColor: Colors.amber,
        value: '₹${(286000 + seed * 24000).toString()}',
      ),
      WorkspaceReportSummary(
        title: 'Profit & Loss',
        description: '$subtitle revenue versus expenses overview',
        icon: Icons.trending_up,
        iconColor: Colors.teal,
        value: '${24 + seed * 3}% margin',
      ),
      WorkspaceReportSummary(
        title: 'Balance Sheet',
        description: '$subtitle assets, liabilities, and equity snapshot',
        icon: Icons.assessment,
        iconColor: Colors.purple,
        value: 'Healthy',
      ),
    ];
  }
}

class BusinessWorkspaceState {
  const BusinessWorkspaceState({
    required this.businesses,
    required this.selectedBusinessId,
  });

  final List<BusinessWorkspaceData> businesses;
  final String selectedBusinessId;

  BusinessWorkspaceData get selectedBusiness => businesses.firstWhere(
        (business) => business.id == selectedBusinessId,
        orElse: () => businesses.isEmpty
            ? BusinessWorkspaceData.create(
                id: 'fallback',
                name: 'Business',
                type: 'General',
                seed: 0,
              )
            : businesses.first,
      );

  BusinessWorkspaceState copyWith({
    List<BusinessWorkspaceData>? businesses,
    String? selectedBusinessId,
  }) {
    return BusinessWorkspaceState(
      businesses: businesses ?? this.businesses,
      selectedBusinessId: selectedBusinessId ?? this.selectedBusinessId,
    );
  }
}

class BusinessWorkspaceController extends ValueNotifier<BusinessWorkspaceState> {
  BusinessWorkspaceController._() : super(_buildInitialState());

  static final BusinessWorkspaceController instance =
      BusinessWorkspaceController._();

  BusinessWorkspaceData get selectedBusiness => value.selectedBusiness;

  List<BusinessWorkspaceData> get businesses => value.businesses;

  void selectBusiness(String businessId) {
    if (value.selectedBusinessId == businessId) return;
    if (!value.businesses.any((business) => business.id == businessId)) return;
    value = value.copyWith(selectedBusinessId: businessId);
  }

  void addBusiness({required String name, required String type}) {
    final id = '${name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-')}-${DateTime.now().microsecondsSinceEpoch}';
    final nextBusiness = BusinessWorkspaceData.create(
      id: id,
      name: name,
      type: type,
      seed: value.businesses.length + 1,
    );
    value = value.copyWith(
      businesses: [...value.businesses, nextBusiness],
      selectedBusinessId: nextBusiness.id,
    );
  }

  void removeBusiness(String businessId) {
    if (value.businesses.length <= 1) return;
    final updatedBusinesses = value.businesses
        .where((business) => business.id != businessId)
        .toList();
    final selectedId = value.selectedBusinessId == businessId
        ? updatedBusinesses.first.id
        : value.selectedBusinessId;
    value = value.copyWith(
      businesses: updatedBusinesses,
      selectedBusinessId: selectedId,
    );
  }

  void upsertReminder(PaymentReminder reminder) {
    final business = selectedBusiness;
    final reminders = [...business.reminders];
    final index = reminders.indexWhere((item) => item.id == reminder.id);
    if (index == -1) {
      reminders.insert(0, reminder);
    } else {
      reminders[index] = reminder;
    }
    _replaceSelectedBusiness(business.copyWith(reminders: reminders));
  }

  void deleteReminder(String reminderId) {
    final business = selectedBusiness;
    final reminders = business.reminders
        .where((reminder) => reminder.id != reminderId)
        .toList();
    _replaceSelectedBusiness(business.copyWith(reminders: reminders));
  }

  void toggleReminderCompletion(String reminderId, bool completed) {
    final business = selectedBusiness;
    final reminders = business.reminders.map((reminder) {
      if (reminder.id != reminderId) return reminder;
      return reminder.copyWith(
        status: completed
            ? PaymentReminderStatus.completed
            : PaymentReminderStatus.pending,
      );
    }).toList();
    _replaceSelectedBusiness(business.copyWith(reminders: reminders));
  }

  void _replaceSelectedBusiness(BusinessWorkspaceData replacement) {
    final updatedBusinesses = value.businesses.map((business) {
      if (business.id != replacement.id) return business;
      return replacement;
    }).toList();
    value = value.copyWith(businesses: updatedBusinesses);
  }
}

BusinessWorkspaceState _buildInitialState() {
  final businesses = [
    BusinessWorkspaceData.create(
      id: 'acme-corporation',
      name: 'Acme Corporation',
      type: 'Service Business',
      seed: 1,
    ),
    BusinessWorkspaceData.create(
      id: 'tech-solutions-ltd',
      name: 'Tech Solutions Ltd',
      type: 'Tech Business',
      seed: 2,
    ),
    BusinessWorkspaceData.create(
      id: 'green-enterprises',
      name: 'Green Enterprises',
      type: 'Trading Business',
      seed: 3,
    ),
    BusinessWorkspaceData.create(
      id: 'baba-grocers',
      name: 'Baba Grocers',
      type: 'Retail Business',
      seed: 4,
    ),
    BusinessWorkspaceData.create(
      id: 'yahya-traders',
      name: 'Yahya Traders',
      type: 'Wholesale Business',
      seed: 5,
    ),
  ];
  return BusinessWorkspaceState(
    businesses: businesses,
    selectedBusinessId: businesses.first.id,
  );
}

final businessWorkspaceController = BusinessWorkspaceController.instance;