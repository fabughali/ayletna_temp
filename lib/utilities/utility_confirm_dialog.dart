import 'package:flutter/material.dart';

/// Shows a standard delete confirmation dialog. Returns true when confirmed.
Future<bool> confirmDestructiveAction(
  BuildContext context, {
  required String title,
  required String message,
  String confirmLabel = 'Delete',
  String cancelLabel = 'Cancel',
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder:
        (ctx) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(cancelLabel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(confirmLabel),
            ),
          ],
        ),
  );
  return result ?? false;
}

/// Standard destructive delete confirmation for admin CRUD lists.
void confirmAdminDelete(
  BuildContext context, {
  required bool isAr,
  required VoidCallback onConfirmed,
}) {
  confirmDestructiveAction(
    context,
    title: isAr ? 'تأكيد الحذف' : 'Confirm delete',
    message: isAr ? 'لا يمكن التراجع عن هذا الإجراء.' : 'This action cannot be undone.',
    confirmLabel: isAr ? 'حذف' : 'Delete',
    cancelLabel: isAr ? 'إلغاء' : 'Cancel',
  ).then((confirmed) {
    if (confirmed) onConfirmed();
  });
}
