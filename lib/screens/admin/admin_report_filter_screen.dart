import 'package:ayletna_restaurant_app/core/core_theme.dart';
import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_app_card.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_refresh_list.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_report_filter_sheet.dart';
import 'package:ayletna_restaurant_app/widgets/widgets_scaffold_page.dart';
import 'package:flutter/material.dart';

/// PRD [ReportFilterScreen].
class AdminReportFilterScreen extends StatelessWidget {
  const AdminReportFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return WidgetsScaffoldPage(
      title: l10n.screenReportFilter,
      child: WidgetsRefreshList(
        onRefresh: () async {
          await Future<void>.delayed(const Duration(milliseconds: 300));
        },
        child: ListView(
          padding: EdgeInsetsDirectional.only(
            top: CoreSpacing.md(context),
            bottom: CoreSpacing.xxl(context),
          ),
          children: [
            WidgetsAppCard(
              title: l10n.screenReportFilter,
              subtitle:
                  isAr
                      ? 'نفس الفلتر المستخدم داخل مركز التقارير، متاح كصفحة كاملة للمدير.'
                      : 'The same filter used inside the reports hub, available as a full admin page.',
              leading: const Icon(Icons.tune_outlined),
              child: const WidgetsReportFilterSheet(
                embedded: true,
                dismissOnApply: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
