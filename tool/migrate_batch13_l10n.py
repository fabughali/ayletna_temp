#!/usr/bin/env python3
"""Batch 13: support desk, marketing E1, staff tip history, delivery refresh l10n."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "supportChatPriorityHigh": "High",
  "supportChatPriorityNormal": "Normal",
  "supportChatWaitingMinutes": "Waiting {minutes} min · {id}",
  "@supportChatWaitingMinutes": {
    "placeholders": {
      "minutes": { "type": "int" },
      "id": { "type": "String" }
    }
  },
  "supportChatAcceptAction": "Accept chat",
  "supportChatAccepted": "Chat accepted",
  "supportChatAcceptFailed": "Chat is no longer in the queue.",
  "supportOrderLookupReadOnlyBanner": "Read-only lookup — orders cannot be edited",
  "supportOrderLookupSearchLabel": "Order # or customer",
  "supportOrderLookupSearchHint": "e.g. 4821",
  "supportOrderLookupNoResults": "No matching orders",
  "staffTipHistoryNoData": "No tip history rows to export for this range.",
  "marketingCalendarSelectDay": "Select a day on the calendar first.",
  "marketingCalendarScheduleConfirmTitle": "Schedule campaign?",
  "marketingCalendarScheduleConfirmMessage": "This adds a mock campaign slot for the selected day.",
  "marketingCalendarScheduledSuccess": "Campaign slot scheduled",
  "marketingPushScheduleConfirmTitle": "Schedule push send?",
  "marketingPushScheduleConfirmMessage": "The draft will move to scheduled status (UI mock).",
  "marketingPushBodyRequired": "Add notification body text before scheduling.",
  "marketingPushScheduleFailed": "Campaign draft could not be scheduled.",
  "opsDeliveryOrderRefreshed": "Delivery order refreshed."
"""

AR = """
  "supportChatPriorityHigh": "عاجل",
  "supportChatPriorityNormal": "عادي",
  "supportChatWaitingMinutes": "انتظار {minutes} د · {id}",
  "@supportChatWaitingMinutes": {
    "placeholders": {
      "minutes": { "type": "int" },
      "id": { "type": "String" }
    }
  },
  "supportChatAcceptAction": "قبول المحادثة",
  "supportChatAccepted": "تم قبول المحادثة",
  "supportChatAcceptFailed": "المحادثة لم تعد في قائمة الانتظار.",
  "supportOrderLookupReadOnlyBanner": "بحث للقراءة فقط — لا تعديل على الطلبات",
  "supportOrderLookupSearchLabel": "رقم الطلب أو العميل",
  "supportOrderLookupSearchHint": "مثال: 4821",
  "supportOrderLookupNoResults": "لا توجد نتائج",
  "staffTipHistoryNoData": "لا توجد صفوف إكراميات للتصدير في هذا النطاق.",
  "marketingCalendarSelectDay": "اختر يوماً من التقويم أولاً.",
  "marketingCalendarScheduleConfirmTitle": "جدولة حملة؟",
  "marketingCalendarScheduleConfirmMessage": "يضيف هذا موعداً تجريبياً للحملة في اليوم المحدد.",
  "marketingCalendarScheduledSuccess": "تمت جدولة موعد الحملة",
  "marketingPushScheduleConfirmTitle": "جدولة إرسال الإشعار؟",
  "marketingPushScheduleConfirmMessage": "ستنتقل المسودة إلى حالة مجدولة (واجهة تجريبية).",
  "marketingPushBodyRequired": "أضف نص الإشعار قبل الجدولة.",
  "marketingPushScheduleFailed": "تعذرت جدولة مسودة الحملة.",
  "opsDeliveryOrderRefreshed": "تم تحديث طلب التوصيل."
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
    print('batch 13 ARB done')


if __name__ == '__main__':
    main()
