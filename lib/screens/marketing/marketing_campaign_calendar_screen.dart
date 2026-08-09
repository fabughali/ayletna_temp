import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_marketing_campaign_event.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/utilities/utility_confirm_dialog.dart';
import 'package:ayletna_restaurant_app/utilities/utility_mock_feedback.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_status_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MarketingCampaignCalendarScreen extends ConsumerStatefulWidget {
  const MarketingCampaignCalendarScreen({super.key});

  @override
  ConsumerState<MarketingCampaignCalendarScreen> createState() =>
      _MarketingCampaignCalendarScreenState();
}

class _MarketingCampaignCalendarScreenState
    extends ConsumerState<MarketingCampaignCalendarScreen> {
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final month = ref.watch(marketingCampaignCalendarMonthProvider);
    final events = ref.watch(marketingCampaignEventsProvider);
    final selected = _selectedDay ?? DateTime(month.year, month.month, 1);
    final dayEvents =
        events.where((event) => event.occursOn(selected)).toList();

    return WidgetsScaffoldPage(
      title: l10n.marketingCampaignCalendar,
      child: ListView(
        padding: EdgeInsetsDirectional.only(bottom: CoreSpacing.xxl(context)),
        children: [
          WidgetsAppCard(
            child: Padding(
              padding: EdgeInsets.all(CoreSpacing.lg(context)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: CoreSpacing.sm(context)),
                  Expanded(
                    child: Text(
                      l10n.marketingCalendarCampaignAuthorityNotice,
                      style: CoreTypography.bodyMedium(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          _MonthHeader(
            month: month,
            isAr: isAr,
            onPrevious: () => _shiftMonth(-1),
            onNext: () => _shiftMonth(1),
          ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppCard(
            child: _CalendarGrid(
              month: month,
              events: events,
              selectedDay: selected,
              isAr: isAr,
              onDaySelected: (day) => setState(() => _selectedDay = day),
            ),
          ),
          SizedBox(height: CoreSpacing.lg(context)),
          Text(
            l10n.marketingCalendarCampaignsOn(_formatDay(selected, isAr)),
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          if (dayEvents.isEmpty)
            WidgetsAppCard(
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.lg(context)),
                child: Text(
                  l10n.marketingCalendarNoEvents,
                  style: CoreTypography.bodyMedium(
                    context,
                    Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ...dayEvents.map(
              (event) => Padding(
                padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
                child: _CampaignEventCard(
                  event: event,
                  isAr: isAr,
                  l10n: l10n,
                  onEdit: () => _editCampaign(context, ref, event, l10n),
                  onDelete: () => _deleteCampaign(context, ref, event, l10n),
                ),
              ),
            ),
          SizedBox(height: CoreSpacing.md(context)),
          WidgetsAppButton(
            onPressed: () => _createCampaign(context, ref, l10n),
            label: l10n.marketingCalendarScheduleAction,
            icon: Icons.add_outlined,
          ),
        ],
      ),
    );
  }

  void _shiftMonth(int delta) {
    final current = ref.read(marketingCampaignCalendarMonthProvider);
    ref.read(marketingCampaignCalendarMonthProvider.notifier).state =
        DateTime(current.year, current.month + delta);
    setState(() => _selectedDay = null);
  }

  Future<void> _createCampaign(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    if (_selectedDay == null) {
      UtilityMockFeedback.showWarning(context, l10n.marketingCalendarSelectDay);
      return;
    }
    final titleEn = TextEditingController();
    final titleAr = TextEditingController();
    final channelEn = TextEditingController();
    final channelAr = TextEditingController();
    var kind = MarketingCampaignKind.offer;
    var startAt = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      9,
    );
    var endAt = DateTime(
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
      21,
    );
    final selectedOffers = <String>{};
    final selectedCombos = <String>{};
    final selectedDiscounts = <String>{};

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: titleEn,
                          label: 'Title EN',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: titleAr,
                          label: 'Title AR',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        DropdownButtonFormField<MarketingCampaignKind>(
                          initialValue: kind,
                          decoration: InputDecoration(
                            labelText: 'Campaign kind',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                CoreSpacing.radiusChipOf(context),
                              ),
                            ),
                          ),
                          items:
                              MarketingCampaignKind.values
                                  .map(
                                    (k) => DropdownMenuItem(
                                      value: k,
                                      child: Text(k.name),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (v) =>
                                  setSheetState(() => kind = v ?? MarketingCampaignKind.offer),
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        ListTile(
                          title: Text(
                            'Start: ${DateFormat.yMMMd(l10n.localeName).add_jm().format(startAt)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final d = await showDatePicker(
                                    context: ctx,
                                    initialDate: startAt,
                                    firstDate: DateTime.now().subtract(
                                      const Duration(days: 1),
                                    ),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (d != null) {
                                    setSheetState(() {
                                      startAt = DateTime(
                                        d.year,
                                        d.month,
                                        d.day,
                                        startAt.hour,
                                        startAt.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.schedule),
                                onPressed: () async {
                                  final t = await showTimePicker(
                                    context: ctx,
                                    initialTime: TimeOfDay.fromDateTime(startAt),
                                  );
                                  if (t != null) {
                                    setSheetState(() {
                                      startAt = DateTime(
                                        startAt.year,
                                        startAt.month,
                                        startAt.day,
                                        t.hour,
                                        t.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'End: ${DateFormat.yMMMd(l10n.localeName).add_jm().format(endAt)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final d = await showDatePicker(
                                    context: ctx,
                                    initialDate: endAt,
                                    firstDate: DateTime.now().subtract(
                                      const Duration(days: 1),
                                    ),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (d != null) {
                                    setSheetState(() {
                                      endAt = DateTime(
                                        d.year,
                                        d.month,
                                        d.day,
                                        endAt.hour,
                                        endAt.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.schedule),
                                onPressed: () async {
                                  final t = await showTimePicker(
                                    context: ctx,
                                    initialTime: TimeOfDay.fromDateTime(endAt),
                                  );
                                  if (t != null) {
                                    setSheetState(() {
                                      endAt = DateTime(
                                        endAt.year,
                                        endAt.month,
                                        endAt.day,
                                        t.hour,
                                        t.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        Text(
                          l10n.marketingCampaignAttachTitle,
                          style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final o in MockupCatalog.offers)
                              FilterChip(
                                label: Text(o.titleEn),
                                selected: selectedOffers.contains(o.id),
                                onSelected: (v) {
                                  setSheetState(() {
                                    if (v) {
                                      selectedOffers.add(o.id);
                                    } else {
                                      selectedOffers.remove(o.id);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final c in MockupCatalog.comboHighlights)
                              FilterChip(
                                label: Text(c.titleEn),
                                selected: selectedCombos.contains(c.id),
                                onSelected: (v) {
                                  setSheetState(() {
                                    if (v) {
                                      selectedCombos.add(c.id);
                                    } else {
                                      selectedCombos.remove(c.id);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: channelEn,
                          label: 'Channel EN (optional)',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: channelAr,
                          label: 'Channel AR (optional)',
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            if (titleEn.text.trim().isEmpty) return;
                            ref
                                .read(marketingCampaignEventsProvider.notifier)
                                .addEvent(
                                  MarketingCampaignEvent(
                                    id: nextCampaignId(),
                                    titleEn: titleEn.text.trim(),
                                    titleAr:
                                        titleAr.text.trim().isNotEmpty
                                            ? titleAr.text.trim()
                                            : titleEn.text.trim(),
                                    startAt: startAt,
                                    endAt: endAt,
                                    kind: kind,
                                    channelEn:
                                        channelEn.text.trim().isNotEmpty
                                            ? channelEn.text.trim()
                                            : null,
                                    channelAr:
                                        channelAr.text.trim().isNotEmpty
                                            ? channelAr.text.trim()
                                            : null,
                                    offerIds: selectedOffers.toList(),
                                    comboIds: selectedCombos.toList(),
                                    discountIds: selectedDiscounts.toList(),
                                  ),
                                );
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.marketingCalendarScheduledSuccess,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  Future<void> _editCampaign(
    BuildContext context,
    WidgetRef ref,
    MarketingCampaignEvent event,
    AppLocalizations l10n,
  ) async {
    final titleEn = TextEditingController(text: event.titleEn);
    final titleAr = TextEditingController(text: event.titleAr);
    final channelEn = TextEditingController(text: event.channelEn);
    final channelAr = TextEditingController(text: event.channelAr);
    var kind = event.kind;
    var startAt = event.startAt;
    var endAt = event.endAt;
    final selectedOffers = {...event.offerIds};
    final selectedCombos = {...event.comboIds};
    final selectedDiscounts = {...event.discountIds};

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder:
          (ctx) => StatefulBuilder(
            builder:
                (ctx, setSheetState) => Padding(
                  padding: EdgeInsets.only(
                    left: CoreSpacing.lg(ctx),
                    right: CoreSpacing.lg(ctx),
                    top: CoreSpacing.lg(ctx),
                    bottom:
                        MediaQuery.viewInsetsOf(ctx).bottom +
                        CoreSpacing.lg(ctx),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetsAppTextField(
                          controller: titleEn,
                          label: 'Title EN',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: titleAr,
                          label: 'Title AR',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        DropdownButtonFormField<MarketingCampaignKind>(
                          initialValue: kind,
                          decoration: InputDecoration(
                            labelText: 'Campaign kind',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                CoreSpacing.radiusChipOf(context),
                              ),
                            ),
                          ),
                          items:
                              MarketingCampaignKind.values
                                  .map(
                                    (k) => DropdownMenuItem(
                                      value: k,
                                      child: Text(k.name),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (v) =>
                                  setSheetState(() => kind = v ?? MarketingCampaignKind.offer),
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        ListTile(
                          title: Text(
                            'Start: ${DateFormat.yMMMd(l10n.localeName).add_jm().format(startAt)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final d = await showDatePicker(
                                    context: ctx,
                                    initialDate: startAt,
                                    firstDate: DateTime.now().subtract(
                                      const Duration(days: 30),
                                    ),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (d != null) {
                                    setSheetState(() {
                                      startAt = DateTime(
                                        d.year,
                                        d.month,
                                        d.day,
                                        startAt.hour,
                                        startAt.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.schedule),
                                onPressed: () async {
                                  final t = await showTimePicker(
                                    context: ctx,
                                    initialTime: TimeOfDay.fromDateTime(startAt),
                                  );
                                  if (t != null) {
                                    setSheetState(() {
                                      startAt = DateTime(
                                        startAt.year,
                                        startAt.month,
                                        startAt.day,
                                        t.hour,
                                        t.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'End: ${DateFormat.yMMMd(l10n.localeName).add_jm().format(endAt)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () async {
                                  final d = await showDatePicker(
                                    context: ctx,
                                    initialDate: endAt,
                                    firstDate: DateTime.now().subtract(
                                      const Duration(days: 30),
                                    ),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (d != null) {
                                    setSheetState(() {
                                      endAt = DateTime(
                                        d.year,
                                        d.month,
                                        d.day,
                                        endAt.hour,
                                        endAt.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.schedule),
                                onPressed: () async {
                                  final t = await showTimePicker(
                                    context: ctx,
                                    initialTime: TimeOfDay.fromDateTime(endAt),
                                  );
                                  if (t != null) {
                                    setSheetState(() {
                                      endAt = DateTime(
                                        endAt.year,
                                        endAt.month,
                                        endAt.day,
                                        t.hour,
                                        t.minute,
                                      );
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        Text(
                          l10n.marketingCampaignAttachTitle,
                          style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            for (final o in MockupCatalog.offers)
                              FilterChip(
                                label: Text(o.titleEn),
                                selected: selectedOffers.contains(o.id),
                                onSelected: (v) {
                                  setSheetState(() {
                                    if (v) {
                                      selectedOffers.add(o.id);
                                    } else {
                                      selectedOffers.remove(o.id);
                                    }
                                  });
                                },
                              ),
                            for (final c in MockupCatalog.comboHighlights)
                              FilterChip(
                                label: Text(c.titleEn),
                                selected: selectedCombos.contains(c.id),
                                onSelected: (v) {
                                  setSheetState(() {
                                    if (v) {
                                      selectedCombos.add(c.id);
                                    } else {
                                      selectedCombos.remove(c.id);
                                    }
                                  });
                                },
                              ),
                          ],
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: channelEn,
                          label: 'Channel EN (optional)',
                        ),
                        SizedBox(height: CoreSpacing.sm(ctx)),
                        WidgetsAppTextField(
                          controller: channelAr,
                          label: 'Channel AR (optional)',
                        ),
                        SizedBox(height: CoreSpacing.md(ctx)),
                        WidgetsAppButton(
                          label: l10n.actionSave,
                          onPressed: () {
                            if (titleEn.text.trim().isEmpty) return;
                            ref
                                .read(marketingCampaignEventsProvider.notifier)
                                .updateEvent(
                                  event.id,
                                  event.copyWith(
                                    titleEn: titleEn.text.trim(),
                                    titleAr:
                                        titleAr.text.trim().isNotEmpty
                                            ? titleAr.text.trim()
                                            : titleEn.text.trim(),
                                    startAt: startAt,
                                    endAt: endAt,
                                    kind: kind,
                                    channelEn:
                                        channelEn.text.trim().isNotEmpty
                                            ? channelEn.text.trim()
                                            : null,
                                    channelAr:
                                        channelAr.text.trim().isNotEmpty
                                            ? channelAr.text.trim()
                                            : null,
                                    offerIds: selectedOffers.toList(),
                                    comboIds: selectedCombos.toList(),
                                    discountIds: selectedDiscounts.toList(),
                                  ),
                                );
                            Navigator.pop(ctx);
                            UtilityMockFeedback.showSuccess(
                              context,
                              l10n.catalogCrudUpdated,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  Future<void> _deleteCampaign(
    BuildContext context,
    WidgetRef ref,
    MarketingCampaignEvent event,
    AppLocalizations l10n,
  ) async {
    confirmAdminDelete(
      context,
      isAr: Localizations.localeOf(context).languageCode == 'ar',
      onConfirmed: () {
        ref.read(marketingCampaignEventsProvider.notifier).removeEvent(event.id);
        UtilityMockFeedback.showSuccess(context, l10n.catalogCrudDeleted);
      },
    );
  }

  String _formatDay(DateTime day, bool isAr) {
    final locale = isAr ? 'ar' : 'en';
    return DateFormat.yMMMd(locale).format(day);
  }
}

class _MonthHeader extends StatelessWidget {
  const _MonthHeader({
    required this.month,
    required this.isAr,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime month;
  final bool isAr;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final label = DateFormat.yMMMM(isAr ? 'ar' : 'en').format(month);
    return Row(
      children: [
        IconButton(onPressed: onPrevious, icon: const Icon(Icons.chevron_left)),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: CoreTypography.titleMedium(
              context,
              Theme.of(context).colorScheme.onSurface,
            ).copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        IconButton(onPressed: onNext, icon: const Icon(Icons.chevron_right)),
      ],
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  const _CalendarGrid({
    required this.month,
    required this.events,
    required this.selectedDay,
    required this.isAr,
    required this.onDaySelected,
  });

  final DateTime month;
  final List<MarketingCampaignEvent> events;
  final DateTime selectedDay;
  final bool isAr;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final first = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final startOffset = first.weekday % 7;
    final weekdayLabels = isAr
        ? const ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س']
        : const ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return Padding(
      padding: EdgeInsets.all(CoreSpacing.md(context)),
      child: Column(
        children: [
          Row(
            children: [
              for (final label in weekdayLabels)
                Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: CoreTypography.caption(
                        context,
                        Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: CoreSpacing.sm(context)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
            ),
            itemCount: startOffset + daysInMonth,
            itemBuilder: (context, index) {
              if (index < startOffset) return const SizedBox.shrink();
              final dayNum = index - startOffset + 1;
              final day = DateTime(month.year, month.month, dayNum);
              final dayEvents = events.where((e) => e.occursOn(day)).length;
              final isSelected = _sameDay(day, selectedDay);
              final isToday = _sameDay(day, DateTime.now());

              return InkWell(
                onTap: () => onDaySelected(day),
                borderRadius: BorderRadius.circular(UtilitySizer.of(context, 8)),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                    borderRadius: BorderRadius.circular(UtilitySizer.of(context, 8)),
                    border: isToday
                        ? Border.all(color: Theme.of(context).colorScheme.primary)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNum',
                        style: CoreTypography.caption(
                          context,
                          Theme.of(context).colorScheme.onSurface,
                        ).copyWith(fontWeight: isSelected ? FontWeight.w800 : null),
                      ),
                      if (dayEvents > 0)
                        Container(
                          margin: EdgeInsets.only(top: UtilitySizer.of(context, 2)),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: CoreColors.brandOrange,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _CampaignEventCard extends StatelessWidget {
  const _CampaignEventCard({
    required this.event,
    required this.isAr,
    required this.l10n,
    required this.onEdit,
    required this.onDelete,
  });

  final MarketingCampaignEvent event;
  final bool isAr;
  final AppLocalizations l10n;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return WidgetsAppCard(
      child: ListTile(
        title: Text(
          event.title(isAr),
          style: CoreTypography.titleMedium(context, Theme.of(context).colorScheme.onSurface).copyWith(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          '${DateFormat.MMMd(isAr ? 'ar' : 'en').format(event.startDate)}'
          ' — ${DateFormat.MMMd(isAr ? 'ar' : 'en').format(event.endDate)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit_outlined, size: CoreContentSizes.buttonIcon(context)),
              onPressed: onEdit,
            ),
            IconButton(
              icon: Icon(Icons.delete_outline, size: CoreContentSizes.buttonIcon(context)),
              onPressed: onDelete,
            ),
            WidgetsStatusPill(
              label: _kindLabel(event.kind),
              color: _kindColor(event.kind),
            ),
          ],
        ),
      ),
    );
  }

  String _kindLabel(MarketingCampaignKind kind) => switch (kind) {
        MarketingCampaignKind.offer => l10n.marketingKindOffer,
        MarketingCampaignKind.promo => l10n.marketingKindPromo,
        MarketingCampaignKind.social => l10n.marketingKindSocial,
        MarketingCampaignKind.loyalty => l10n.marketingKindLoyalty,
      };

  Color _kindColor(MarketingCampaignKind kind) => switch (kind) {
        MarketingCampaignKind.offer => CoreColors.brandOrange,
        MarketingCampaignKind.promo => CoreColors.orderTypeDelivery,
        MarketingCampaignKind.social => CoreColors.brandGold,
        MarketingCampaignKind.loyalty => CoreColors.semanticSuccess,
      };
}
