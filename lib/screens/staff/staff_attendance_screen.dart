import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/navigation/app_route_paths.dart';
import 'package:ayletna_restaurant_app/providers/attendance_providers.dart';
import 'package:ayletna_restaurant_app/providers/staff_session_providers.dart';
import 'package:ayletna_restaurant_app/services/service_attendance_biometric.dart';
import 'package:ayletna_restaurant_app/services/service_attendance_wifi.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_icon_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_info_banner.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// PRD StaffAttendanceScreen — shift, station, and team context.
class StaffAttendanceScreen extends ConsumerWidget {
  const StaffAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(staffSessionProvider);

    return WidgetsScaffoldPage(
      title: l10n.screenStaffAttendance,
      actions: [
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.staffTips),
          icon: Icons.payments_outlined,
          tooltip: l10n.screenStaffDailyTips,
        ),
        WidgetsIconButton(
          onPressed: () => context.push(AppRoutePaths.notifications),
          icon: Icons.notifications_outlined,
          tooltip: l10n.screenNotifications,
        ),
      ],
      child: WidgetsRefreshList(
        onRefresh:
            () async => UtilityMockFeedback.showSuccess(
              context,
              l10n.screenStaffAttendance,
            ),
        child: ListView(
          children: [
            _AttendanceHero(session: session),
            SizedBox(height: CoreSpacing.lg(context)),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth >= 920;
                final shift = Column(
                  children: [
                    _ShiftDetailsCard(session: session),
                    SizedBox(height: CoreSpacing.lg(context)),
                    const _TeamFocusCard(),
                  ],
                );
                final actions = Column(
                  children: [
                    const _StationContextCard(),
                    SizedBox(height: CoreSpacing.lg(context)),
                    _AttendanceGateCard(session: session),
                  ],
                );
                if (isWide) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: shift),
                      SizedBox(width: CoreSpacing.lg(context)),
                      Expanded(flex: 2, child: actions),
                    ],
                  );
                }
                return Column(
                  children: [
                    shift,
                    SizedBox(height: CoreSpacing.lg(context)),
                    actions,
                  ],
                );
              },
            ),
            SizedBox(height: CoreSpacing.xxl(context)),
          ],
        ),
      ),
    );
  }
}

class _AttendanceHero extends StatelessWidget {
  const _AttendanceHero({required this.session});

  final StaffSessionState session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final statusLabel =
        session.isOnShift ? l10n.staffActiveNow : l10n.staffOffDuty;
    final statusColor =
        session.isOnShift ? CoreColors.semanticSuccess : CoreColors.semanticError;
    final clockLabel =
        session.checkInAt == null
            ? l10n.staffCheckInClock
            : session.formatShiftDuration();

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(
                icon: Icons.access_time,
                color: scheme.primary,
                large: true,
              ),
              SizedBox(width: CoreSpacing.md(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.staffAttendanceTitle,
                      style: CoreTypography.headlineSmall(
                        context,
                        scheme.onSurface,
                      ).copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(height: CoreSpacing.xs(context)),
                    Text(
                      '${l10n.staffCheckInDate} • $clockLabel',
                      style: CoreTypography.bodyMedium(
                        context,
                        scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              _SoftBadge(
                label: statusLabel,
                color: statusColor,
                icon: Icons.circle,
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Wrap(
            spacing: CoreSpacing.sm(context),
            runSpacing: CoreSpacing.sm(context),
            children: [
              _SoftBadge(
                label: l10n.staffMainKitchen,
                color: scheme.primary,
                icon: Icons.location_on_outlined,
              ),
              _SoftBadge(
                label: l10n.staffLeadChef,
                color: CoreColors.orderTypePlated,
                icon: Icons.restaurant_menu_outlined,
              ),
              _SoftBadge(
                label: l10n.staffExpectedEarningsValue,
                color: CoreColors.semanticSuccess,
                icon: Icons.payments_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ShiftDetailsCard extends StatelessWidget {
  const _ShiftDetailsCard({required this.session});

  final StaffSessionState session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.form,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.staffShiftDetails,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.xs(context)),
          Text(
            l10n.staffShiftDetailsBody,
            style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
          ),
          if (session.checkInAt != null) ...[
            SizedBox(height: CoreSpacing.md(context)),
            _ShiftDetailTile(
              detail: ModelStaffShiftDetail(
                eyebrowAr: l10n.staffCheckInTime,
                eyebrowEn: l10n.staffCheckInTime,
                valueAr: _formatTime(session.checkInAt!),
                valueEn: _formatTime(session.checkInAt!),
                iconKey: 'schedule',
                colorKey: 'success',
              ),
              isAr: isAr,
            ),
            if (session.checkOutAt != null) ...[
              SizedBox(height: CoreSpacing.sm(context)),
              _ShiftDetailTile(
                detail: ModelStaffShiftDetail(
                  eyebrowAr: l10n.staffCheckOut,
                  eyebrowEn: l10n.staffCheckOut,
                  valueAr: _formatTime(session.checkOutAt!),
                  valueEn: _formatTime(session.checkOutAt!),
                  iconKey: 'schedule',
                  colorKey: 'primary',
                ),
                isAr: isAr,
              ),
              SizedBox(height: CoreSpacing.sm(context)),
              _ShiftDetailTile(
                detail: ModelStaffShiftDetail(
                  eyebrowAr: l10n.staffCurrentDuration,
                  eyebrowEn: l10n.staffCurrentDuration,
                  valueAr: session.formatShiftDuration(),
                  valueEn: session.formatShiftDuration(),
                  iconKey: 'earnings',
                  colorKey: 'success',
                ),
                isAr: isAr,
              ),
            ],
          ],
          SizedBox(height: CoreSpacing.md(context)),
          for (final detail in MockupCatalog.staffShiftDetails) ...[
            _ShiftDetailTile(detail: detail, isAr: isAr),
            SizedBox(height: CoreSpacing.sm(context)),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}

class _ShiftDetailTile extends StatelessWidget {
  const _ShiftDetailTile({required this.detail, required this.isAr});

  final ModelStaffShiftDetail detail;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color =
        detail.colorKey == 'success'
            ? CoreColors.semanticSuccess
            : scheme.primary;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Row(
          children: [
            _IconBubble(icon: _icon(detail.iconKey), color: color),
            SizedBox(width: CoreSpacing.sm(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isAr ? detail.eyebrowAr : detail.eyebrowEn,
                    style: CoreTypography.caption(
                      context,
                      scheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    isAr ? detail.valueAr : detail.valueEn,
                    style: CoreTypography.bodyMedium(
                      context,
                      scheme.onSurface,
                    ).copyWith(fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _icon(String key) => switch (key) {
    'schedule' => Icons.schedule_outlined,
    'earnings' => Icons.payments_outlined,
    'location' => Icons.location_on_outlined,
    _ => Icons.flatware,
  };
}

class _StationContextCard extends StatelessWidget {
  const _StationContextCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      accentColor: scheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _IconBubble(
                icon: Icons.room_service_outlined,
                color: scheme.primary,
              ),
              SizedBox(width: CoreSpacing.sm(context)),
              Expanded(
                child: Text(
                  l10n.staffCurrentFocus,
                  style: CoreTypography.titleMedium(
                    context,
                    scheme.onSurface,
                  ).copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _ContextLine(
            label: l10n.staffTableService,
            value: l10n.staffSectionZone,
            color: scheme.primary,
          ),
          _ContextLine(
            label: l10n.staffKitchenCoordination,
            value: l10n.staffTotalOrdersManaged,
            color: CoreColors.brandOrange,
          ),
          _ContextLine(
            label: l10n.staffCapacity,
            value: l10n.staffCustomerRating,
            color: CoreColors.semanticSuccess,
          ),
        ],
      ),
    );
  }
}

class _TeamFocusCard extends StatelessWidget {
  const _TeamFocusCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.food,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.staffManagerNotes,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _NoteStrip(
            text: l10n.staffChefSpecialNote,
            color: CoreColors.brandOrange,
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          _NoteStrip(text: l10n.staffVipReservationNote, color: scheme.primary),
        ],
      ),
    );
  }
}

class _AttendanceGateCard extends ConsumerStatefulWidget {
  const _AttendanceGateCard({required this.session});

  final StaffSessionState session;

  @override
  ConsumerState<_AttendanceGateCard> createState() =>
      _AttendanceGateCardState();
}

class _AttendanceGateCardState extends ConsumerState<_AttendanceGateCard> {
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(attendanceWifiProvider.notifier).refresh();
      ref.read(attendanceActionModeProvider.notifier).state =
          widget.session.isOnShift
              ? AttendanceActionMode.leaving
              : AttendanceActionMode.coming;
    });
  }

  @override
  void didUpdateWidget(covariant _AttendanceGateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.session.isOnShift != widget.session.isOnShift) {
      ref.read(attendanceActionModeProvider.notifier).state =
          widget.session.isOnShift
              ? AttendanceActionMode.leaving
              : AttendanceActionMode.coming;
    }
  }

  Future<void> _submitAttendance() async {
    final l10n = AppLocalizations.of(context)!;
    final mode = ref.read(attendanceActionModeProvider);
    final wifiAsync = ref.read(attendanceWifiProvider);
    final wifi = wifiAsync.valueOrNull;

    if (_isSubmitting) return;

    if (wifi == null || !wifi.isConfigured) {
      UtilityMockFeedback.showError(context, l10n.attendanceWifiNotConfigured);
      return;
    }
    if (!wifi.isRestaurantWifi) {
      UtilityMockFeedback.showError(context, l10n.attendanceWifiRequired);
      return;
    }

    if (mode == AttendanceActionMode.coming && widget.session.isOnShift) {
      UtilityMockFeedback.showError(context, l10n.staffActiveNow);
      return;
    }
    if (mode == AttendanceActionMode.leaving && !widget.session.isOnShift) {
      UtilityMockFeedback.showError(context, l10n.staffOffDuty);
      return;
    }

    final reason =
        mode == AttendanceActionMode.coming
            ? l10n.attendanceBiometricCheckInReason
            : l10n.attendanceBiometricCheckOutReason;

    final authenticated = await ServiceAttendanceBiometric.authenticate(
      context: context,
      reason: reason,
    );
    if (!mounted || !authenticated) return;

    setState(() => _isSubmitting = true);
    final ssid = wifi.currentSsid ?? wifi.expectedSsid ?? '';
    final bssid = wifi.currentBssid ?? wifi.expectedBssid;
    final ok =
        mode == AttendanceActionMode.coming
            ? ref
                .read(staffSessionProvider.notifier)
                .checkIn(wifiSsid: ssid, wifiBssid: bssid)
            : ref
                .read(staffSessionProvider.notifier)
                .checkOut(wifiSsid: ssid, wifiBssid: bssid);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (ok) {
      UtilityMockFeedback.showSuccess(
        context,
        mode == AttendanceActionMode.coming
            ? l10n.staffCheckInAction
            : l10n.staffCheckOutShift,
      );
      ref.read(attendanceActionModeProvider.notifier).state =
          mode == AttendanceActionMode.coming
              ? AttendanceActionMode.leaving
              : AttendanceActionMode.coming;
    } else {
      UtilityMockFeedback.showError(
        context,
        mode == AttendanceActionMode.coming
            ? l10n.staffActiveNow
            : l10n.staffOffDuty,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final mode = ref.watch(attendanceActionModeProvider);
    final wifiAsync = ref.watch(attendanceWifiProvider);
    final wifi = wifiAsync.valueOrNull;
    final canSubmit =
        !_isSubmitting &&
        wifi != null &&
        wifi.isRestaurantWifi &&
        ((mode == AttendanceActionMode.coming && !widget.session.isOnShift) ||
            (mode == AttendanceActionMode.leaving && widget.session.isOnShift));

    return WidgetsAppCard(
      variant: WidgetsAppCardVariant.dashboard,
      padding: EdgeInsets.all(CoreSpacing.lg(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.attendanceGateTitle,
            style: CoreTypography.titleMedium(
              context,
              scheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          SegmentedButton<AttendanceActionMode>(
            segments: [
              ButtonSegment(
                value: AttendanceActionMode.coming,
                label: Text(l10n.attendanceModeComing),
                icon: const Icon(Icons.login_outlined),
              ),
              ButtonSegment(
                value: AttendanceActionMode.leaving,
                label: Text(l10n.attendanceModeLeaving),
                icon: const Icon(Icons.logout_outlined),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (selection) {
              ref.read(attendanceActionModeProvider.notifier).state =
                  selection.first;
            },
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          _WifiStatusPanel(
            l10n: l10n,
            wifiAsync: wifiAsync,
            onRefresh:
                () => ref.read(attendanceWifiProvider.notifier).refresh(),
          ),
          _WifiRefreshRow(
            onRefresh: () => ref.read(attendanceWifiProvider.notifier).refresh(),
          ),
          if (widget.session.recordedWifiSsid != null) ...[
            SizedBox(height: CoreSpacing.sm(context)),
            Text(
              l10n.attendanceLastRecordedWifi(widget.session.recordedWifiSsid!),
              textAlign: TextAlign.center,
              style: CoreTypography.caption(
                context,
                scheme.onSurfaceVariant,
              ),
            ),
          ],
          SizedBox(height: CoreSpacing.xl(context)),
          Center(
            child: Material(
              color: canSubmit ? scheme.primary : scheme.surfaceContainerHighest,
              shape: const CircleBorder(),
              elevation: canSubmit ? 4 : 0,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: canSubmit ? _submitAttendance : null,
                child: SizedBox.square(
                  dimension: CoreContentSizes.logoCard(context) * 1.65,
                  child:
                      _isSubmitting
                          ? Center(
                            child: CircularProgressIndicator(
                              color: scheme.onPrimary,
                            ),
                          )
                          : Icon(
                            Icons.fingerprint,
                            size: CoreContentSizes.logoCard(context),
                            color:
                                canSubmit
                                    ? scheme.onPrimary
                                    : scheme.onSurfaceVariant,
                          ),
                ),
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          Text(
            mode == AttendanceActionMode.coming
                ? l10n.attendanceFingerprintComingHint
                : l10n.attendanceFingerprintLeavingHint,
            textAlign: TextAlign.center,
            style: CoreTypography.caption(context, scheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _WifiStatusPanel extends StatelessWidget {
  const _WifiStatusPanel({
    required this.l10n,
    required this.wifiAsync,
    required this.onRefresh,
  });

  final AppLocalizations l10n;
  final AsyncValue<AttendanceWifiStatus> wifiAsync;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return wifiAsync.when(
      loading:
          () => WidgetsInfoBanner(
            tone: WidgetsInfoBannerTone.info,
            message: l10n.attendanceWifiChecking,
          ),
      error:
          (_, __) => WidgetsInfoBanner(
            tone: WidgetsInfoBannerTone.warning,
            message: l10n.attendanceWifiCheckFailed,
          ),
      data: (wifi) {
        if (!wifi.isConfigured) {
          return WidgetsInfoBanner(
            tone: WidgetsInfoBannerTone.warning,
            message: l10n.attendanceWifiNotConfigured,
          );
        }
        if (wifi.isRestaurantWifi) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              WidgetsInfoBanner(
                tone: WidgetsInfoBannerTone.success,
                message:
                    wifi.isDemoSimulation
                        ? l10n.attendanceWifiDemoMatched(wifi.currentSsid ?? '')
                        : l10n.attendanceWifiConnected(wifi.currentSsid ?? ''),
              ),
              if (wifi.isDemoSimulation) ...[
                SizedBox(height: CoreSpacing.xs(context)),
                Text(
                  l10n.attendanceWifiWebDemoNote,
                  style: CoreTypography.caption(
                    context,
                    scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          );
        }
        return WidgetsInfoBanner(
          tone: WidgetsInfoBannerTone.warning,
          message: l10n.attendanceWifiWrongNetwork(
            wifi.currentSsid ?? l10n.attendanceWifiUnknown,
            wifi.expectedSsid ?? '',
          ),
        );
      },
    );
  }
}

class _WifiRefreshRow extends StatelessWidget {
  const _WifiRefreshRow({required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: WidgetsAppButton(
        label: l10n.attendanceWifiRefresh,
        onPressed: onRefresh,
        icon: Icons.wifi_find_outlined,
        variant: WidgetsAppButtonVariant.ghost,
      ),
    );
  }
}

class _ContextLine extends StatelessWidget {
  const _ContextLine({
    required this.label,
    required this.value,
    required this.color,
  });
  final String label;
  final String value;
  final Color color;
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
    child: Row(
      children: [
        Icon(Icons.circle, color: color, size: 9),
        SizedBox(width: CoreSpacing.sm(context)),
        Expanded(
          child: Text(
            label,
            style: CoreTypography.bodyMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        Text(
          value,
          style: CoreTypography.caption(
            context,
            Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );
}

class _NoteStrip extends StatelessWidget {
  const _NoteStrip({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      border: Border.all(color: color.withValues(alpha: 0.18)),
    ),
    child: Padding(
      padding: EdgeInsets.all(CoreSpacing.sm(context)),
      child: Text(
        text,
        style: CoreTypography.bodyMedium(
          context,
          Theme.of(context).colorScheme.onSurface,
        ),
      ),
    ),
  );
}

class _SoftBadge extends StatelessWidget {
  const _SoftBadge({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusChip),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: CoreSpacing.sm(context),
          vertical: CoreSpacing.xs(context),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: CoreContentSizes.orderTypeIcon(context),
              color: color,
            ),
            SizedBox(width: CoreSpacing.xs(context)),
            Text(
              label,
              style: CoreTypography.caption(
                context,
                color,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({
    required this.icon,
    required this.color,
    this.large = false,
  });

  final IconData icon;
  final Color color;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
      ),
      child: Padding(
        padding: EdgeInsets.all(CoreSpacing.sm(context)),
        child: Icon(
          icon,
          color: color,
          size:
              large
                  ? CoreContentSizes.logoCard(context) * 0.52
                  : CoreContentSizes.orderTypeIcon(context),
        ),
      ),
    );
  }
}
