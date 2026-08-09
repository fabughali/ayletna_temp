#!/usr/bin/env python3
"""Batch 17: v1 backlog — support SLA, audit, marketing publish."""
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

EN = """
  "permSupportRefunds": "Order refunds & cancel",
  "permSupportSla": "SLA & shift handover",
  "permMarketingMenuPricing": "Menu price publish",
  "permMarketingPublish": "Campaign publish",
  "permOperatorCampaignApprove": "Campaign co-approval",
  "supportSlaAtRisk": "SLA at risk",
  "supportSlaBreached": "SLA breached",
  "supportResolvedToday": "Resolved (24h)",
  "supportAvgResponseTime": "Avg response",
  "supportAvgResponseMinutes": "{minutes} min",
  "@supportAvgResponseMinutes": {
    "placeholders": { "minutes": { "type": "int" } }
  },
  "supportShiftHandoverTitle": "Shift handover",
  "supportShiftHandoverHint": "Open tickets, blockers, and notes for the next agent…",
  "supportShiftHandoverSaved": "Handover notes saved",
  "supportShiftHandoverLast": "Last handover: {when}",
  "@supportShiftHandoverLast": {
    "placeholders": { "when": { "type": "String" } }
  },
  "supportAgentPerformanceTitle": "Agent performance (today)",
  "supportTicketCustomerPhone": "Customer phone",
  "supportTicketCustomerAddress": "Customer address",
  "supportTicketEscalateOperator": "Escalate to Operator",
  "supportTicketEscalateCashier": "Escalate to Cashier",
  "supportTicketEscalated": "Ticket escalated to {target}",
  "@supportTicketEscalated": {
    "placeholders": { "target": { "type": "String" } }
  },
  "supportOrderLookupActionsBanner": "Support can issue refunds and cancel orders (demo-safe).",
  "supportOrderRefundAction": "Issue refund",
  "supportOrderCancelAction": "Cancel order",
  "supportOrderRefundConfirmTitle": "Issue refund?",
  "supportOrderRefundConfirmMessage": "A demo refund will be logged for audit.",
  "supportOrderCancelConfirmTitle": "Cancel order?",
  "supportOrderCancelConfirmMessage": "This marks the order cancelled and logs audit.",
  "supportOrderRefunded": "Refund recorded (demo)",
  "supportOrderCancelled": "Order cancelled",
  "supportOrderAlreadyCancelled": "Order is already cancelled",
  "marketingPublishSubmit": "Submit for operator approval",
  "marketingPublishSubmitted": "Sent to operator for co-approval",
  "marketingPublishPendingTitle": "Pending operator approval",
  "marketingPublishApprove": "Approve & publish",
  "marketingPublishReject": "Reject",
  "marketingPublishApproved": "Campaign published",
  "marketingPublishRejected": "Campaign rejected",
  "marketingSubscriptionContentOnly": "Content only — billing activates when payment provider is wired",
  "auditEventRefund": "Refund",
  "auditEventOrderCancel": "Order cancel",
  "auditEventPriceChange": "Price change",
  "auditEventOfferPublished": "Offer published"
"""

AR = """
  "permSupportRefunds": "استرداد وإلغاء الطلبات",
  "permSupportSla": "SLA وتسليم الوردية",
  "permMarketingMenuPricing": "نشر أسعار القائمة",
  "permMarketingPublish": "نشر الحملات",
  "permOperatorCampaignApprove": "اعتماد مشترك للحملات",
  "supportSlaAtRisk": "SLA معرض للخطر",
  "supportSlaBreached": "SLA متجاوز",
  "supportResolvedToday": "تم الحل (24 س)",
  "supportAvgResponseTime": "متوسط الاستجابة",
  "supportAvgResponseMinutes": "{minutes} د",
  "@supportAvgResponseMinutes": {
    "placeholders": { "minutes": { "type": "int" } }
  },
  "supportShiftHandoverTitle": "تسليم الوردية",
  "supportShiftHandoverHint": "التذاكر المفتوحة والعوائق وملاحظات للوكيل التالي…",
  "supportShiftHandoverSaved": "تم حفظ ملاحظات التسليم",
  "supportShiftHandoverLast": "آخر تسليم: {when}",
  "@supportShiftHandoverLast": {
    "placeholders": { "when": { "type": "String" } }
  },
  "supportAgentPerformanceTitle": "أداء الوكيل (اليوم)",
  "supportTicketCustomerPhone": "هاتف العميل",
  "supportTicketCustomerAddress": "عنوان العميل",
  "supportTicketEscalateOperator": "تصعيد للمشغل",
  "supportTicketEscalateCashier": "تصعيد للكاشير",
  "supportTicketEscalated": "تم التصعيد إلى {target}",
  "@supportTicketEscalated": {
    "placeholders": { "target": { "type": "String" } }
  },
  "supportOrderLookupActionsBanner": "الدعم يمكنه إصدار استرداد وإلغاء الطلبات (تجريبي آمن).",
  "supportOrderRefundAction": "إصدار استرداد",
  "supportOrderCancelAction": "إلغاء الطلب",
  "supportOrderRefundConfirmTitle": "إصدار استرداد؟",
  "supportOrderRefundConfirmMessage": "سيتم تسجيل استرداد تجريبي للتدقيق.",
  "supportOrderCancelConfirmTitle": "إلغاء الطلب؟",
  "supportOrderCancelConfirmMessage": "سيُعلّم الطلب ملغى ويُسجّل في التدقيق.",
  "supportOrderRefunded": "تم تسجيل الاسترداد (تجريبي)",
  "supportOrderCancelled": "تم إلغاء الطلب",
  "supportOrderAlreadyCancelled": "الطلب ملغى مسبقاً",
  "marketingPublishSubmit": "إرسال لاعتماد المشغل",
  "marketingPublishSubmitted": "أُرسل للمشغل للاعتماد المشترك",
  "marketingPublishPendingTitle": "بانتظار اعتماد المشغل",
  "marketingPublishApprove": "اعتماد ونشر",
  "marketingPublishReject": "رفض",
  "marketingPublishApproved": "تم نشر الحملة",
  "marketingPublishRejected": "تم رفض الحملة",
  "marketingSubscriptionContentOnly": "محتوى فقط — يُفعّل الفوترة عند ربط مزود الدفع",
  "auditEventRefund": "استرداد",
  "auditEventOrderCancel": "إلغاء طلب",
  "auditEventPriceChange": "تغيير سعر",
  "auditEventOfferPublished": "نشر عرض"
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
    print('batch 17 ARB done')


if __name__ == '__main__':
    main()
