#!/usr/bin/env python3
"""Batch 18: M1 menu price publish + O3 operator escalation inbox."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "marketingMenuPricePublishTitle": "Menu price publish",
  "marketingMenuPricePublishBanner": "Marketing can update base menu prices. Each change is logged for operator audit before publish.",
  "operatorEscalationsInboxTitle": "Support escalations",
  "operatorEscalationsInboxSubtitle": "Tickets escalated from Support — refund, cancel, or policy requests",
  "operatorEscalationAcknowledge": "Acknowledge",
  "operatorEscalationAcknowledged": "Escalation acknowledged",
  "operatorEscalationOpenTicket": "Open ticket",
  "operatorEscalationTarget": "Escalated to {target}",
  "@operatorEscalationTarget": {
    "placeholders": { "target": { "type": "String" } }
  }
"""

AR = """
  "marketingMenuPricePublishTitle": "نشر أسعار القائمة",
  "marketingMenuPricePublishBanner": "يمكن للتسويق تحديث أسعار القائمة الأساسية. يُسجّل كل تغيير للمراجعة قبل النشر.",
  "operatorEscalationsInboxTitle": "تصعيدات الدعم",
  "operatorEscalationsInboxSubtitle": "تذاكر مُصعّدة من الدعم — استرداد أو إلغاء أو طلبات سياسة",
  "operatorEscalationAcknowledge": "إقرار",
  "operatorEscalationAcknowledged": "تم الإقرار بالتصعيد",
  "operatorEscalationOpenTicket": "فتح التذكرة",
  "operatorEscalationTarget": "مُصعّد إلى {target}",
  "@operatorEscalationTarget": {
    "placeholders": { "target": { "type": "String" } }
  }
"""


def append_arb(path: Path, keys: str) -> None:
    text = path.read_text(encoding='utf-8').rstrip()
    if text.endswith('}'):
        text = text[:-1].rstrip()
        if not text.endswith(','):
            text += ','
        text += '\n' + keys.strip() + '\n}\n'
        path.write_text(text, encoding='utf-8')


def main() -> None:
    append_arb(ROOT / 'lib/l10n/app_en.arb', EN)
    append_arb(ROOT / 'lib/l10n/app_ar.arb', AR)
    print('batch 18 ARB done')


if __name__ == '__main__':
    main()
