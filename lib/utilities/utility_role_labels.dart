import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';

/// Localized display label for [AppRole].
String roleLabel(AppLocalizations l10n, AppRole role) => switch (role) {
  AppRole.customer => l10n.roleCustomer,
  AppRole.guest => l10n.roleCustomer,
  AppRole.owner => l10n.roleOwner,
  AppRole.operator => l10n.roleOperator,
  AppRole.admin => l10n.roleAdmin,
  AppRole.support => l10n.roleSupport,
  AppRole.marketing => l10n.roleMarketing,
  AppRole.cashier => l10n.roleCashier,
  AppRole.kitchen => l10n.roleKitchen,
  AppRole.delivery => l10n.roleDelivery,
  AppRole.inventory => l10n.roleInventory,
  AppRole.staff => l10n.roleStaff,
};

/// Localized RBAC user account status label.
String rbacUserStatusLabel(AppLocalizations l10n, String status) =>
    switch (status) {
      'pending_approval' => l10n.rbacStatusPendingApproval,
      'suspended' => l10n.rbacStatusSuspended,
      _ => l10n.rbacStatusActive,
    };

String hubLabel(AppLocalizations l10n, AppRole role) => switch (role) {
  AppRole.admin => l10n.hubAppAdmin,
  AppRole.operator => l10n.hubOperator,
  AppRole.owner => l10n.hubOwner,
  AppRole.support => l10n.hubSupportDesk,
  AppRole.marketing => l10n.hubMarketing,
  _ => roleLabel(l10n, role),
};

String permissionKeyLabel(String key, bool isAr) {
  final labels =
      isAr
          ? {
            'perm.admin.users': 'إدارة المستخدمين',
            'perm.admin.rbac_defaults': 'قواعد الأدوار الافتراضية',
            'perm.admin.rbac_overrides': 'استثناءات الصلاحيات',
            'perm.admin.audit': 'سجل التدقيق',
            'perm.admin.integrations': 'التكاملات',
            'perm.admin.system_settings': 'إعدادات النظام',
            'perm.admin.owner_view_config': 'إعدادات عرض المالك',
            'perm.operator.dashboard': 'لوحة العمليات',
            'perm.operator.orders': 'إدارة الطلبات',
            'perm.operator.menu': 'إدارة القائمة',
            'perm.operator.tips': 'توزيع الإكراميات',
            'perm.operator.plates': 'إدارة الأطباق',
            'perm.operator.hr': 'الحضور والموارد البشرية',
            'perm.operator.reports': 'التقارير',
            'perm.operator.financial_close': 'الإغلاق المالي',
            'perm.owner.dashboard': 'لوحة المالك',
            'perm.owner.reports': 'تقارير المالك',
            'perm.owner.financial': 'المالية للمالك',
            'perm.support.tickets': 'التذاكر',
            'perm.support.chat': 'الدردشة المباشرة',
            'perm.support.reviews': 'مراجعة التقييمات',
            'perm.support.faq': 'الأسئلة الشائعة',
            'perm.support.refunds': 'استرداد وإلغاء الطلبات',
            'perm.support.sla': 'SLA وتسليم الوردية',
            'perm.marketing.offers': 'العروض',
            'perm.marketing.combos': 'الكومبو',
            'perm.marketing.subscriptions': 'الاشتراكات',
            'perm.marketing.promotions': 'الحملات',
            'perm.marketing.loyalty': 'الولاء',
            'perm.marketing.social': 'وسائل التواصل',
            'perm.marketing.menu_pricing': 'نشر أسعار القائمة',
            'perm.marketing.publish': 'نشر الحملات',
            'perm.operator.campaign_approve': 'اعتماد الحملات',
            'perm.cashier.pos': 'نقطة البيع',
            'perm.kitchen.queue': 'طابور المطبخ',
            'perm.delivery.routes': 'مسارات التوصيل',
            'perm.inventory.stock': 'المخزون',
            'perm.staff.attendance': 'حضور الموظفين',
          }
          : {
            'perm.admin.users': 'User management',
            'perm.admin.rbac_defaults': 'Role default rules',
            'perm.admin.rbac_overrides': 'Permission overrides',
            'perm.admin.audit': 'Audit log',
            'perm.admin.integrations': 'Integrations',
            'perm.admin.system_settings': 'System settings',
            'perm.admin.owner_view_config': 'Owner view config',
            'perm.operator.dashboard': 'Operations dashboard',
            'perm.operator.orders': 'Orders management',
            'perm.operator.menu': 'Menu management',
            'perm.operator.tips': 'Tip distribution',
            'perm.operator.plates': 'Plates management',
            'perm.operator.hr': 'Attendance & HR',
            'perm.operator.reports': 'Reports',
            'perm.operator.financial_close': 'Financial close',
            'perm.owner.dashboard': 'Owner dashboard',
            'perm.owner.reports': 'Owner reports',
            'perm.owner.financial': 'Owner financial',
            'perm.support.tickets': 'Support tickets',
            'perm.support.chat': 'Live chat',
            'perm.support.reviews': 'Review moderation',
            'perm.support.faq': 'FAQ content',
            'perm.support.refunds': 'Order refunds & cancel',
            'perm.support.sla': 'SLA & shift handover',
            'perm.marketing.offers': 'Offers',
            'perm.marketing.combos': 'Combos',
            'perm.marketing.subscriptions': 'Subscriptions',
            'perm.marketing.promotions': 'Promotions',
            'perm.marketing.loyalty': 'Loyalty program',
            'perm.marketing.social': 'Social integrations',
            'perm.marketing.menu_pricing': 'Menu price publish',
            'perm.marketing.publish': 'Campaign publish',
            'perm.operator.campaign_approve': 'Campaign co-approval',
            'perm.cashier.pos': 'Cashier POS',
            'perm.kitchen.queue': 'Kitchen queue',
            'perm.delivery.routes': 'Delivery routes',
            'perm.inventory.stock': 'Inventory stock',
            'perm.staff.attendance': 'Staff attendance',
          };
  return labels[key] ?? key;
}
