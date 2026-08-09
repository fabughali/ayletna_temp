import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_marketing_campaign_event.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/providers/marketing_campaign_providers.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_button.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

enum CampaignEntityKind { offer, combo, discount, subscription }

/// Pick or create a campaign window. Returns campaign id, or null if cancelled.
/// Every successful call writes a fresh start/end (reschedule).
Future<String?> showCampaignScheduleSheet({
  required BuildContext context,
  required WidgetRef ref,
  required CampaignEntityKind kind,
  required String entityId,
  String? currentCampaignId,
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder:
        (ctx) => _CampaignScheduleSheet(
          kind: kind,
          entityId: entityId,
          currentCampaignId: currentCampaignId,
        ),
  );
}

class _CampaignScheduleSheet extends ConsumerStatefulWidget {
  const _CampaignScheduleSheet({
    required this.kind,
    required this.entityId,
    this.currentCampaignId,
  });

  final CampaignEntityKind kind;
  final String entityId;
  final String? currentCampaignId;

  @override
  ConsumerState<_CampaignScheduleSheet> createState() =>
      _CampaignScheduleSheetState();
}

class _CampaignScheduleSheetState extends ConsumerState<_CampaignScheduleSheet> {
  late String? _selectedId;
  late DateTime _startAt;
  late DateTime _endAt;
  final _titleEn = TextEditingController();
  bool _creatingNew = true;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _startAt = DateTime(now.year, now.month, now.day, now.hour + 1);
    _endAt = _startAt.add(const Duration(days: 7));
    _selectedId = widget.currentCampaignId;
    _creatingNew = widget.currentCampaignId == null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_bootstrapped && widget.currentCampaignId != null) {
      _bootstrapped = true;
      final events = ref.read(marketingCampaignEventsProvider);
      for (final e in events) {
        if (e.id == widget.currentCampaignId) {
          _titleEn.text = e.titleEn;
          _startAt = e.startAt;
          _endAt = e.endAt;
          _creatingNew = false;
          break;
        }
      }
    }
  }

  bool _bootstrapped = false;

  @override
  void dispose() {
    _titleEn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final events = ref.watch(marketingCampaignEventsProvider);
    final fmt = DateFormat.yMMMd(l10n.localeName).add_jm();

    return Padding(
      padding: EdgeInsets.only(
        left: CoreSpacing.lg(context),
        right: CoreSpacing.lg(context),
        top: CoreSpacing.md(context),
        bottom: MediaQuery.viewInsetsOf(context).bottom + CoreSpacing.lg(context),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.marketingCampaignScheduleTitle,
              style: CoreTypography.titleMedium(
                context,
                Theme.of(context).colorScheme.onSurface,
              ).copyWith(fontWeight: FontWeight.w900),
            ),
            SizedBox(height: CoreSpacing.xs(context)),
            Text(
              l10n.marketingCampaignScheduleHint,
              style: CoreTypography.caption(
                context,
                Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: true,
                  label: Text(l10n.marketingCampaignNew),
                ),
                ButtonSegment(
                  value: false,
                  label: Text(l10n.marketingCampaignPickExisting),
                ),
              ],
              selected: {_creatingNew},
              onSelectionChanged: (s) {
                setState(() {
                  _creatingNew = s.first;
                  if (_creatingNew) {
                    _selectedId = null;
                  }
                });
              },
            ),
            SizedBox(height: CoreSpacing.md(context)),
            if (_creatingNew)
              WidgetsAppTextField(
                controller: _titleEn,
                label: l10n.catalogCrudNameEn,
              )
            else
              DropdownButtonFormField<String>(
                initialValue:
                    events.any((e) => e.id == _selectedId) ? _selectedId : null,
                decoration: InputDecoration(
                  labelText: l10n.marketingCampaignPickExisting,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(CoreSpacing.radiusChipOf(context)),
                  ),
                ),
                items: [
                  for (final e in events)
                    DropdownMenuItem(
                      value: e.id,
                      child: Text(e.title(isAr)),
                    ),
                ],
                onChanged: (id) {
                  if (id == null) return;
                  final match = events.firstWhere((e) => e.id == id);
                  setState(() {
                    _selectedId = id;
                    _titleEn.text = match.titleEn;
                    _startAt = match.startAt;
                    _endAt = match.endAt;
                  });
                },
              ),
            SizedBox(height: CoreSpacing.sm(context)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.marketingScheduleStart(fmt.format(_startAt))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _pickDate(isStart: true),
                  ),
                  IconButton(
                    icon: const Icon(Icons.schedule),
                    onPressed: () => _pickTime(isStart: true),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.marketingScheduleEnd(fmt.format(_endAt))),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _pickDate(isStart: false),
                  ),
                  IconButton(
                    icon: const Icon(Icons.schedule),
                    onPressed: () => _pickTime(isStart: false),
                  ),
                ],
              ),
            ),
            SizedBox(height: CoreSpacing.md(context)),
            WidgetsAppButton(
              label: l10n.actionSave,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _startAt : _endAt;
    final d = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (d == null) return;
    setState(() {
      final t = isStart ? _startAt : _endAt;
      final next = DateTime(d.year, d.month, d.day, t.hour, t.minute);
      if (isStart) {
        _startAt = next;
      } else {
        _endAt = next;
      }
    });
  }

  Future<void> _pickTime({required bool isStart}) async {
    final initial = TimeOfDay.fromDateTime(isStart ? _startAt : _endAt);
    final t = await showTimePicker(context: context, initialTime: initial);
    if (t == null) return;
    setState(() {
      final base = isStart ? _startAt : _endAt;
      final next = DateTime(
        base.year,
        base.month,
        base.day,
        t.hour,
        t.minute,
      );
      if (isStart) {
        _startAt = next;
      } else {
        _endAt = next;
      }
    });
  }

  void _save() {
    final l10n = AppLocalizations.of(context)!;
    if (!_endAt.isAfter(_startAt)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.marketingCampaignInvalidWindow)),
      );
      return;
    }
    if (_creatingNew && _titleEn.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.catalogCrudCheckFields)),
      );
      return;
    }
    if (!_creatingNew && (_selectedId == null || _selectedId!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.marketingCampaignPickExisting)),
      );
      return;
    }

    final notifier = ref.read(marketingCampaignEventsProvider.notifier);
    final events = ref.read(marketingCampaignEventsProvider);
    late final String campaignId;

    final hasEntity = widget.entityId.trim().isNotEmpty;

    if (_creatingNew) {
      campaignId = nextCampaignId();
      notifier.addEvent(
        MarketingCampaignEvent(
          id: campaignId,
          titleEn: _titleEn.text.trim(),
          titleAr: _titleEn.text.trim(),
          startAt: _startAt,
          endAt: _endAt,
          kind: MarketingCampaignKind.offer,
          offerIds:
              hasEntity && widget.kind == CampaignEntityKind.offer
                  ? [widget.entityId]
                  : const [],
          comboIds:
              hasEntity && widget.kind == CampaignEntityKind.combo
                  ? [widget.entityId]
                  : const [],
          discountIds:
              hasEntity && widget.kind == CampaignEntityKind.discount
                  ? [widget.entityId]
                  : const [],
          subscriptionIds:
              hasEntity && widget.kind == CampaignEntityKind.subscription
                  ? [widget.entityId]
                  : const [],
        ),
      );
    } else {
      campaignId = _selectedId!;
      final existing = events.firstWhere((e) => e.id == campaignId);
      notifier.updateEvent(
        campaignId,
        existing.copyWith(
          startAt: _startAt,
          endAt: _endAt,
          offerIds: _withId(
            existing.offerIds,
            widget.entityId,
            hasEntity && widget.kind == CampaignEntityKind.offer,
          ),
          comboIds: _withId(
            existing.comboIds,
            widget.entityId,
            hasEntity && widget.kind == CampaignEntityKind.combo,
          ),
          discountIds: _withId(
            existing.discountIds,
            widget.entityId,
            hasEntity && widget.kind == CampaignEntityKind.discount,
          ),
          subscriptionIds: _withId(
            existing.subscriptionIds,
            widget.entityId,
            hasEntity && widget.kind == CampaignEntityKind.subscription,
          ),
        ),
      );
    }

    Navigator.pop(context, campaignId);
  }

  List<String> _withId(List<String> current, String id, bool include) {
    if (!include || id.trim().isEmpty) return current;
    if (current.contains(id)) return current;
    return [...current, id];
  }
}

/// Attach an offer/combo/discount/subscription id to a campaign after create.
void attachEntityToCampaign({
  required WidgetRef ref,
  required String campaignId,
  required CampaignEntityKind kind,
  required String entityId,
}) {
  if (entityId.trim().isEmpty) return;
  final events = ref.read(marketingCampaignEventsProvider);
  MarketingCampaignEvent? existing;
  for (final e in events) {
    if (e.id == campaignId) {
      existing = e;
      break;
    }
  }
  if (existing == null) return;

  List<String> withId(List<String> current) {
    if (current.contains(entityId)) return current;
    return [...current, entityId];
  }

  ref.read(marketingCampaignEventsProvider.notifier).updateEvent(
        campaignId,
        existing.copyWith(
          offerIds:
              kind == CampaignEntityKind.offer
                  ? withId(existing.offerIds)
                  : existing.offerIds,
          comboIds:
              kind == CampaignEntityKind.combo
                  ? withId(existing.comboIds)
                  : existing.comboIds,
          discountIds:
              kind == CampaignEntityKind.discount
                  ? withId(existing.discountIds)
                  : existing.discountIds,
          subscriptionIds:
              kind == CampaignEntityKind.subscription
                  ? withId(existing.subscriptionIds)
                  : existing.subscriptionIds,
        ),
      );
}
