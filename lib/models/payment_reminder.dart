enum PaymentReminderStatus { pending, completed }

class PaymentReminder {
  PaymentReminder({
    required this.id,
    required this.title,
    required this.account,
    required this.amount,
    required this.isDebit,
    required this.paymentMethod,
    required this.transactionDate,
    required this.dueDate,
    required this.status,
    required this.notes,
  });

  final String id;
  final String title;
  final String account;
  final double amount;
  final bool isDebit;
  final String paymentMethod;
  final DateTime transactionDate;
  final DateTime dueDate;
  final PaymentReminderStatus status;
  final String notes;

  bool get isOverdue =>
      status == PaymentReminderStatus.pending && _isBeforeToday(dueDate);

  bool get isPending =>
      status == PaymentReminderStatus.pending && !isOverdue;

  bool get isCompleted => status == PaymentReminderStatus.completed;

  String get amountLabel {
    final sign = isDebit ? '-' : '+';
    final rounded = amount % 1 == 0
        ? amount.toStringAsFixed(0)
        : amount.toStringAsFixed(2);
    return '$sign₹$rounded';
  }

  String get statusLabel {
    if (isCompleted) return 'Completed';
    if (isOverdue) return 'Overdue';
    return 'Pending';
  }

  PaymentReminder copyWith({
    String? id,
    String? title,
    String? account,
    double? amount,
    bool? isDebit,
    String? paymentMethod,
    DateTime? transactionDate,
    DateTime? dueDate,
    PaymentReminderStatus? status,
    String? notes,
  }) {
    return PaymentReminder(
      id: id ?? this.id,
      title: title ?? this.title,
      account: account ?? this.account,
      amount: amount ?? this.amount,
      isDebit: isDebit ?? this.isDebit,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionDate: transactionDate ?? this.transactionDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'account': account,
      'amount': amount,
      'type': isDebit ? 'debit' : 'credit',
      'paymentMethod': paymentMethod,
      'date': transactionDate.toIso8601String(),
      'dueDate': dueDate.toIso8601String(),
      'status': status.name,
      'notes': notes,
    };
  }

  factory PaymentReminder.fromMap(Map<String, dynamic> data) {
    final rawAmount = data['amount'];
    final parsedAmount = rawAmount is num
        ? rawAmount.toDouble()
        : double.tryParse(rawAmount.toString().replaceAll(',', '')) ?? 0;
    return PaymentReminder(
      id: data['id']?.toString() ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      title: data['title']?.toString() ?? '',
      account: data['account']?.toString() ?? 'Main Bank Account',
      amount: parsedAmount,
      isDebit: (data['type']?.toString() ?? 'debit') == 'debit',
      paymentMethod: data['paymentMethod']?.toString() ?? 'Cash',
      transactionDate: _parseDate(data['date']) ?? DateTime.now(),
      dueDate: _parseDate(data['dueDate']) ??
          _parseDate(data['date']) ??
          DateTime.now(),
      status: _statusFromValue(data['status']),
      notes: data['notes']?.toString() ?? '',
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.tryParse(value.toString());
  }

  static PaymentReminderStatus _statusFromValue(dynamic value) {
    final raw = value?.toString().toLowerCase();
    if (raw == 'completed') return PaymentReminderStatus.completed;
    return PaymentReminderStatus.pending;
  }

  static bool _isBeforeToday(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);
    return compareDate.isBefore(today);
  }
}