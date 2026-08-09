import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/data/models/model_permission_rule.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/utilities/utility_role_labels.dart';
import 'package:flutter/material.dart';

/// Reusable capability matrix for RBAC Screen A & B.
class WidgetsPermissionMatrix extends StatelessWidget {
  const WidgetsPermissionMatrix({
    required this.keys,
    required this.accessForKey,
    this.readOnly = false,
    this.onChanged,
    this.onKeyTap,
    this.postponedUntilForKey,
    this.accessOptions,
    super.key,
  });

  final List<String> keys;
  final PermissionAccess Function(String key) accessForKey;
  final bool readOnly;
  final void Function(String key, PermissionAccess access)? onChanged;
  final void Function(String key)? onKeyTap;
  final DateTime? Function(String key)? postponedUntilForKey;
  final List<PermissionAccess>? accessOptions;

  List<PermissionAccess> get _accessOptions =>
      accessOptions ?? PermissionAccess.values;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    if (keys.isEmpty) {
      return Text(
        l10n.permissionMatrixEmpty,
        style: CoreTypography.bodyMedium(context, scheme.onSurfaceVariant),
      );
    }

    return Column(
      children: [
        for (final key in keys)
          Padding(
            padding: EdgeInsets.only(bottom: CoreSpacing.sm(context)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(CoreSpacing.radiusCardOf(context)),
                border: Border.all(
                  color: scheme.outline.withValues(alpha: 0.35),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(CoreSpacing.md(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:
                                onKeyTap == null ? null : () => onKeyTap!(key),
                            child: Text(
                              permissionKeyLabel(key, isAr),
                              style: CoreTypography.bodyMedium(
                                context,
                                scheme.onSurface,
                              ).copyWith(
                                fontWeight: FontWeight.w700,
                                color: onKeyTap == null ? null : scheme.primary,
                                decoration:
                                    onKeyTap == null
                                        ? null
                                        : TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        if (readOnly)
                          _AccessChip(access: accessForKey(key))
                        else
                          DropdownButton<PermissionAccess>(
                            value: accessForKey(key),
                            underline: const SizedBox.shrink(),
                            onChanged: (value) {
                              if (value != null) onChanged?.call(key, value);
                            },
                            items:
                                _accessOptions
                                    .map(
                                      (access) => DropdownMenuItem(
                                        value: access,
                                        child: _AccessChip(access: access),
                                      ),
                                    )
                                    .toList(),
                          ),
                      ],
                    ),
                    if (postponedUntilForKey?.call(key) case final until?) ...[
                      SizedBox(height: CoreSpacing.xs(context)),
                      Text(
                        l10n.rbacPostponedUntil(
                          MaterialLocalizations.of(
                            context,
                          ).formatMediumDate(until),
                        ),
                        style: CoreTypography.caption(
                          context,
                          CoreColors.brandOrange,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _AccessChip extends StatelessWidget {
  const _AccessChip({required this.access});

  final PermissionAccess access;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, color) = switch (access) {
      PermissionAccess.full => (
        l10n.permissionAccessFull,
        CoreColors.semanticSuccess,
      ),
      PermissionAccess.readOnly => (
        l10n.permissionAccessRead,
        CoreColors.orderTypeDelivery,
      ),
      PermissionAccess.denied => (
        l10n.permissionAccessDenied,
        CoreColors.semanticError,
      ),
      PermissionAccess.postponed => (
        l10n.permissionAccessPostponed,
        CoreColors.brandOrange,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: CoreSpacing.sm(context),
        vertical: CoreSpacing.xs(context),
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(CoreContentSizes.pillRadius(context)),
      ),
      child: Text(
        label,
        style: CoreTypography.caption(context, color).copyWith(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
