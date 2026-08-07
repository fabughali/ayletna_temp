import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_notification.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_notification_category.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/app_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/session_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/utilities/utility_open_notifications.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_async_state_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_avatar.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_list_item.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_page_header.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD [NotificationsScreen] — customer marketing inbox + ops shift inbox.
class CustomerNotificationsScreen extends ConsumerWidget {
  const CustomerNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final role = ref.watch(appRoleProvider);
    if (!isCustomerNotificationsAudience(role)) {
      return _OpsInboxScaffold(role: role);
    }

    return WidgetsScaffoldPage(
      title: l10n.screenNotifications,
      child: WidgetsRefreshList(
        onRefresh: () async {
          ref.read(customerNotificationsDismissedProvider.notifier).reset();
          ref.invalidate(customerNotificationCategoriesProvider);
          UtilityMockFeedback.showSuccess(context, l10n.notificationsTitle);
        },
        child: Builder(
          builder: (context) {
            final visible = ref.watch(visibleCustomerNotificationsProvider);
            if (visible.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: CoreSpacing.md(context)),
                  _HeaderActions(l10n: l10n),
                  SizedBox(height: CoreSpacing.xl(context)),
                  WidgetsAsyncStateCard.empty(
                    title: l10n.notificationsRecentAlerts,
                    message: l10n.notificationsSubtitle,
                  ),
                ],
              );
            }

            final recent =
                visible.where((item) => !item.isSubdued).toList(growable: false);
            final yesterday =
                visible.where((item) => item.isSubdued).toList(growable: false);
            // header + recent section + items + yesterday section + items + footer
            final itemCount =
                1 +
                (recent.isEmpty ? 0 : 1 + recent.length) +
                (yesterday.isEmpty ? 0 : 1 + yesterday.length) +
                1;

            return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (context, index) {
                var cursor = 0;
                if (index == cursor) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: CoreSpacing.md(context)),
                      _HeaderActions(l10n: l10n),
                      SizedBox(height: CoreSpacing.lg(context)),
                      _CategorySummary(l10n: l10n),
                      SizedBox(height: CoreSpacing.md(context)),
                      const _WeeklyReportCard(),
                      SizedBox(height: CoreSpacing.xl(context)),
                    ],
                  );
                }
                cursor++;

                if (recent.isNotEmpty) {
                  if (index == cursor) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _SectionLabel(label: l10n.notificationsRecentAlerts),
                        SizedBox(height: CoreSpacing.md(context)),
                      ],
                    );
                  }
                  cursor++;
                  final recentIndex = index - cursor;
                  if (recentIndex >= 0 && recentIndex < recent.length) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: CoreSpacing.sm(context),
                      ),
                      child: _NotificationCard(item: recent[recentIndex]),
                    );
                  }
                  cursor += recent.length;
                }

                if (yesterday.isNotEmpty) {
                  if (index == cursor) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: CoreSpacing.lg(context)),
                        _SectionLabel(label: l10n.notificationsYesterday),
                        SizedBox(height: CoreSpacing.md(context)),
                      ],
                    );
                  }
                  cursor++;
                  final yesterdayIndex = index - cursor;
                  if (yesterdayIndex >= 0 &&
                      yesterdayIndex < yesterday.length) {
                    return _NotificationCard(item: yesterday[yesterdayIndex]);
                  }
                  cursor += yesterday.length;
                }

                return SizedBox(height: CoreSpacing.xxl(context));
              },
            );
          },
        ),
      ),
    );
  }
}

class _OpsInboxScaffold extends ConsumerWidget {
  const _OpsInboxScaffold({required this.role});

  final AppRole role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final hub = homeRouteForRole(role);

    return WidgetsScaffoldPage(
      title: l10n.opsInboxTitle,
      child: ListView(
        children: [
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsPageHeader(
            title: l10n.opsInboxTitle,
            subtitle: l10n.opsInboxSubtitle,
          ),
          WidgetsListItem(
            title: l10n.opsInboxShiftAlertTitle,
            subtitle: l10n.opsInboxShiftAlertBody,
            leading: const Icon(Icons.schedule_outlined),
            onTap: () => context.go(hub),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          WidgetsListItem(
            title: l10n.opsInboxOrderAlertTitle,
            subtitle: l10n.opsInboxOrderAlertBody,
            leading: const Icon(Icons.notifications_active_outlined),
            onTap: () => context.go(hub),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          WidgetsAppButton(
            label: l10n.opsInboxOpenHub,
            onPressed: () => context.go(hub),
            icon: Icons.home_outlined,
            fullWidth: true,
          ),
          SizedBox(height: CoreSpacing.xxl(context)),
        ],
      ),
    );
  }
}

class _HeaderActions extends ConsumerWidget {
  const _HeaderActions({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WidgetsPageHeader(
      title: l10n.notificationsTitle,
      subtitle: l10n.notificationsSubtitle,
      trailing: Wrap(
        spacing: CoreSpacing.sm(context),
        runSpacing: CoreSpacing.sm(context),
        children: [
          WidgetsAppButton(
            label: l10n.notificationsClearAll,
            onPressed: () async {
              final confirmed = await UtilityMockFeedback.confirm(
                context: context,
                title: l10n.notificationsClearAll,
                message: l10n.notificationsSubtitle,
                confirmLabel: l10n.notificationsClearAll,
                cancelLabel:
                    MaterialLocalizations.of(context).cancelButtonLabel,
                icon: Icons.delete_sweep_outlined,
                confirmVariant: WidgetsAppButtonVariant.secondary,
              );
              if (confirmed && context.mounted) {
                ref.read(customerNotificationsDismissedProvider.notifier).clearAll();
                UtilityMockFeedback.showSuccess(
                  context,
                  l10n.notificationsClearAll,
                );
              }
            },
            icon: Icons.delete_sweep_outlined,
            variant: WidgetsAppButtonVariant.outline,
          ),
          WidgetsAppButton(
            label: l10n.notificationsPreferences,
            onPressed: () => context.push(AppRoutePaths.profile),
            icon: Icons.settings_outlined,
          ),
        ],
      ),
    );
  }
}

class _CategorySummary extends ConsumerWidget {
  const _CategorySummary({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final rows = ref.watch(customerNotificationCategoriesProvider);

    return WidgetsAppCard(
      title: l10n.notificationsCategories,
      leading: Icon(Icons.category_outlined, color: scheme.primary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final row in rows) ...[
            _CategoryRow(data: row),
            SizedBox(height: CoreSpacing.xs(context)),
          ],
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.data});

  final ModelCustomerNotificationCategory data;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final scheme = Theme.of(context).colorScheme;
    final color = _categoryColor(scheme, data.colorKey);

    return WidgetsListItem(
      title: isAr ? data.labelAr : data.labelEn,
      dense: true,
      leading: Icon(
        _categoryIcon(data.iconKey),
        size: CoreContentSizes.orderTypeIcon(context),
        color: color,
      ),
      trailing: _CountBadge(count: data.count, color: color),
    );
  }

  IconData _categoryIcon(String key) {
    return switch (key) {
      'delivery' => Icons.local_shipping_outlined,
      'eco' => Icons.eco_outlined,
      'admin' => Icons.admin_panel_settings_outlined,
      _ => Icons.all_inbox_outlined,
    };
  }

  Color _categoryColor(ColorScheme scheme, String key) {
    return switch (key) {
      'delivery' => CoreColors.orderTypeDelivery,
      'secondary' => scheme.secondary,
      'warning' => CoreColors.semanticWarning,
      _ => scheme.primary,
    };
  }
}

class _WeeklyReportCard extends StatelessWidget {
  const _WeeklyReportCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return WidgetsAppCard(
      accentColor: scheme.secondary,
      leading: Icon(Icons.analytics_outlined, color: scheme.secondary),
      title: l10n.notificationsWeeklyReport,
      child: Stack(
        children: [
          PositionedDirectional(
            bottom: -CoreSpacing.lg(context),
            end: -CoreSpacing.lg(context),
            child: Icon(
              Icons.analytics_outlined,
              size: CoreContentSizes.logoWelcome(context),
              color: scheme.secondary.withValues(alpha: 0.12),
            ),
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.notificationsWeeklySubtitle,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(height: CoreSpacing.md(context)),
                WidgetsAppButton(
                  label: l10n.notificationsViewDetails,
                  onPressed: () => context.push(AppRoutePaths.loyalty),
                  icon: Icons.arrow_forward,
                  variant: WidgetsAppButtonVariant.ghost,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Text(
      label,
      style: CoreTypography.caption(
        context,
        scheme.onSurfaceVariant,
      ).copyWith(fontWeight: FontWeight.w900),
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count, required this.color});

  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 28),
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
      ),
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: CoreTypography.caption(
          context,
          color,
        ).copyWith(fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _NotificationCard extends ConsumerWidget {
  const _NotificationCard({required this.item});

  final ModelCustomerNotification item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final title = isAr ? item.titleAr : item.titleEn;
    final body = isAr ? item.bodyAr : item.bodyEn;
    final time = isAr ? item.timeAr : item.timeEn;
    final actions = isAr ? item.actionLabelsAr : item.actionLabelsEn;
    final color = _notificationColor(scheme, item.colorKey);

    return Opacity(
      opacity: item.isSubdued ? 0.76 : 1,
      child: WidgetsAppCard(
        accentColor: color,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadiusDirectional.horizontal(
                    start: Radius.circular(CoreSpacing.radiusCardOf(context)),
                  ),
                ),
                child: SizedBox(
                  width: CoreContentSizes.amountIndicatorWidth(context),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(CoreSpacing.md(context)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetsAvatar(
                        icon: _notificationIcon(item.iconKey),
                        color: color,
                      ),
                      SizedBox(width: CoreSpacing.md(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    title,
                                    style: CoreTypography.bodyMedium(
                                      context,
                                      _titleColor(scheme, item.colorKey),
                                    ).copyWith(fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Text(
                                  time,
                                  style: CoreTypography.caption(
                                    context,
                                    scheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: CoreSpacing.xs(context)),
                            Text(
                              body,
                              style: CoreTypography.caption(
                                context,
                                scheme.onSurfaceVariant,
                              ),
                            ),
                            if (actions.isNotEmpty) ...[
                              SizedBox(height: CoreSpacing.md(context)),
                              Wrap(
                                spacing: CoreSpacing.sm(context),
                                runSpacing: CoreSpacing.sm(context),
                                children: [
                                  for (final indexedAction in actions.indexed)
                                    WidgetsAppButton(
                                      label: indexedAction.$2,
                                      onPressed: () {
                                        final routeIndex = indexedAction.$1;
                                        final route =
                                            routeIndex < item.actionRoutes.length
                                                ? item.actionRoutes[routeIndex]
                                                : null;
                                        if (route != null && route.isNotEmpty) {
                                          if (route == AppRoutePaths.orderTracking) {
                                            ref
                                                .read(
                                                  activeTrackingOrderIdProvider
                                                      .notifier,
                                                )
                                                .state = item.id;
                                          }
                                          context.push(route);
                                          return;
                                        }
                                        context.push(AppRoutePaths.home);
                                      },
                                      variant:
                                          item.primaryActionIndexes.contains(
                                                indexedAction.$1,
                                              )
                                              ? WidgetsAppButtonVariant.primary
                                              : WidgetsAppButtonVariant.outline,
                                    ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      WidgetsIconButton(
                        onPressed:
                            () => ref
                                .read(
                                  customerNotificationsDismissedProvider
                                      .notifier,
                                )
                                .dismiss(item.id),
                        icon: Icons.close,
                        tooltip:
                            MaterialLocalizations.of(
                              context,
                            ).closeButtonTooltip,
                        variant: WidgetsIconButtonVariant.tonal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _notificationIcon(String key) {
    return switch (key) {
      'delivery' => Icons.delivery_dining,
      'payments' => Icons.payments_outlined,
      'eco' => Icons.eco_outlined,
      'inventory' => Icons.inventory_2_outlined,
      'restaurant' => Icons.restaurant_outlined,
      'campaign' => Icons.campaign_outlined,
      _ => Icons.notifications_outlined,
    };
  }

  Color _notificationColor(ColorScheme scheme, String key) {
    return switch (key) {
      'plated' => CoreColors.orderTypePlated,
      'success' => CoreColors.semanticSuccess,
      'warning' => CoreColors.semanticWarning,
      'delivery' => CoreColors.orderTypeDelivery,
      _ => scheme.primary,
    };
  }

  Color _titleColor(ColorScheme scheme, String key) {
    return switch (key) {
      'success' => CoreColors.semanticSuccess,
      'warning' => CoreColors.semanticWarning,
      'delivery' => CoreColors.orderTypeDelivery,
      _ => scheme.onSurface,
    };
  }
}
