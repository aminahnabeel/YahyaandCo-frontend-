import 'package:flutter/material.dart';

import '../../models/payment_reminder.dart';
import '../../state/business_workspace_controller.dart';

export '../../models/payment_reminder.dart';

final ValueNotifier<List<PaymentReminder>> paymentReminderController =
    ValueNotifier<List<PaymentReminder>>(<PaymentReminder>[]);

void _syncPaymentReminders() {
  paymentReminderController.value =
      List<PaymentReminder>.of(businessWorkspaceController.selectedBusiness.reminders);
}

// ignore: unused_element
final bool _paymentReminderSyncAttached = (() {
  businessWorkspaceController.addListener(_syncPaymentReminders);
  _syncPaymentReminders();
  return true;
})();

void addPaymentReminder(PaymentReminder reminder) {
  businessWorkspaceController.upsertReminder(reminder);
}

void updatePaymentReminder(PaymentReminder reminder) {
  businessWorkspaceController.upsertReminder(reminder);
}

void deletePaymentReminder(String id) {
  businessWorkspaceController.deleteReminder(id);
}

void togglePaymentReminderCompletion(String id, bool completed) {
  businessWorkspaceController.toggleReminderCompletion(id, completed);
}
