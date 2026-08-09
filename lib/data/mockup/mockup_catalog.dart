import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/data/models/model_admin_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_notification.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_notification_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_order_history.dart';
import 'package:ayletna_restaurant_app/data/models/model_customer_reward.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_customization_option.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_pickup_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_delivery_return_task.dart';
import 'package:ayletna_restaurant_app/data/models/model_inventory_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_prep_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_ready_order.dart';
import 'package:ayletna_restaurant_app/data/models/model_list_entry.dart';
import 'package:ayletna_restaurant_app/data/models/model_cart_line.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_category.dart';
import 'package:ayletna_restaurant_app/data/models/model_menu_item.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_detail.dart';
import 'package:ayletna_restaurant_app/data/models/model_order_summary.dart';
import 'package:ayletna_restaurant_app/data/models/model_payment_method.dart';
import 'package:ayletna_restaurant_app/data/models/model_pickup_mode.dart';
import 'package:ayletna_restaurant_app/data/models/model_pickup_slot.dart';
import 'package:ayletna_restaurant_app/data/models/model_saved_address.dart';
import 'package:ayletna_restaurant_app/data/models/model_support_ticket.dart';
import 'package:ayletna_restaurant_app/data/models/model_staff_mock.dart';
import 'package:ayletna_restaurant_app/data/models/model_wallet_transaction.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:flutter/material.dart';

/// Jordan / PRD placeholder menu & orders (no Stitch sample names).
abstract final class MockupCatalog {
  static const adminTodayOrders = 48;
  static const adminRevenueJod = 14282.50;
  static const adminTipPoolJod = 1894.20;
  static const financialGrossRevenueJod = 14250.0;
  static const financialTotalTipsJod = 1120.0;
  static const financialEscrowDepositsJod = 2400.0;
  static const financialOperationalExpensesJod = 1280.0;
  static const financialNetRevenueJod = 11850.0;
  static const financialOwnerShareRate = 0.65;
  static const financialOperatorShareRate = 0.35;
  static const financialOwnerShareJod = 7702.50;
  static const financialOperatorShareJod = 4147.50;
  static const inventoryValueJod = 14280.50;
  static const inventoryPendingOrdersJod = 3150.0;
  static const dailyTipPoolJod = 2485.50;
  static const dailyTipTotalHours = 112.5;
  static const dailyTipPointRate = 2.14;
  static const adminLossBreakageJod = 412.0;
  static const adminRevenueChart = <double>[
    0.30,
    0.42,
    0.34,
    0.55,
    0.50,
    0.62,
    0.48,
    0.74,
  ];
  static const adminPlatedOrders = 12;
  static const adminDineInOrders = 24;
  static const adminTakeawayOrders = 8;
  static const adminDeliveryOrders = 16;
  static const adminGrillLoad = 0.85;
  static const adminColdPrepLoad = 0.20;
  static const cashierCurrentOrderId = '4582';
  static const cashierNumber = 'C-07';
  static const cashierNameAr = 'عمر';
  static const cashierNameEn = 'Omar';
  static const staffDisplayNameAr = 'عمر حسن';
  static const staffDisplayNameEn = 'Omar Hassan';
  static const staffPhone = '+962 7 9000 1122';
  static const staffEmail = 'omar.hassan@ayletna.com';
  static const customerDisplayNameAr = 'عميل عيلتنا';
  static const customerDisplayNameEn = 'Ayletna Guest';
  static const customerPhone = '+962 7 9012 3456';
  static const customerEmail = 'guest@ayletna.com';
  static const cashierTaxRate = 0.16;
  static const cashierShiftRevenueJod = 1248.50;
  static const cashierShiftOrdersCount = 142;
  static const cashierAverageOrderJod = 8.8;
  static const cashierShiftTipsJod = 124.50;
  static const cashierOfferSavingsJod = 1.0;
  static const cashierComboSavingsJod = 1.5;
  static const cashierSubscriptionSavingsJod = 0.5;
  /// Outstanding balance from prior unpaid orders (demo when customer phone is set).
  static const cashierCustomerPriorBalanceJod = 12.50;
  static const checkoutTaxRate = 0.05;
  static const checkoutDineInServiceRate = 0.03;
  static const checkoutTakeawayPackagingFeeJod = 0.20;
  static const checkoutDeliveryFeeJod = 1.50;
  static const checkoutGroupDeliveryFeeJod = 0.75;
  static const checkoutPlatedDepositJod = 5.0;
  static const checkoutPromoSavingsJod = 2.0;
  static const checkoutWalletBalanceJod = 24.50;
  static const checkoutOrderRef = '#SV-99281';
  static const cartPortionOptions = <ModelCartCustomizationOption>[
    ModelCartCustomizationOption(key: 'single', priceDeltaJod: 0.0),
    ModelCartCustomizationOption(key: 'family', priceDeltaJod: 42.0),
  ];
  static const cartAddonOptions = <ModelCartCustomizationOption>[
    ModelCartCustomizationOption(key: 'extra_jameed', priceDeltaJod: 1.5),
    ModelCartCustomizationOption(key: 'extra_almonds', priceDeltaJod: 0.75),
    ModelCartCustomizationOption(key: 'no_pine_nuts', priceDeltaJod: 0.0),
  ];
  static const checkoutPaymentMethods = <ModelPaymentMethod>[
    ModelPaymentMethod(
      id: 'wallet',
      titleAr: 'المحفظة',
      titleEn: 'Wallet',
      subtitleAr: 'رصيد متاح 24.50 د.أ',
      subtitleEn: '24.50 JOD available',
      iconKey: 'wallet',
      colorKey: 'secondary',
      balanceJod: checkoutWalletBalanceJod,
    ),
    ModelPaymentMethod(
      id: 'card',
      titleAr: 'بطاقة / Visa',
      titleEn: 'Card / Visa',
      subtitleAr: '**** 4242',
      subtitleEn: '**** 4242',
      iconKey: 'card',
      colorKey: 'primary',
    ),
    ModelPaymentMethod(
      id: 'cash',
      titleAr: 'نقدا',
      titleEn: 'Cash',
      subtitleAr: 'ادفع عند الاستلام',
      subtitleEn: 'Pay on arrival',
      iconKey: 'cash',
      colorKey: 'tertiary',
    ),
  ];
  static const paymentMethods = <ModelPaymentMethod>[
    ModelPaymentMethod(
      id: 'wallet',
      titleAr: 'رصيد المحفظة',
      titleEn: 'Wallet Balance',
      subtitleAr: 'متاح للدفع السريع',
      subtitleEn: 'Available for quick payment',
      iconKey: 'wallet',
      colorKey: 'secondary',
      balanceJod: checkoutWalletBalanceJod,
    ),
    ModelPaymentMethod(
      id: 'card',
      titleAr: 'بطاقة محفوظة',
      titleEn: 'Saved Card',
      subtitleAr: 'Visa تنتهي بـ 4242',
      subtitleEn: 'Visa ending in 4242',
      iconKey: 'card',
      colorKey: 'primary',
    ),
    ModelPaymentMethod(
      id: 'applePay',
      titleAr: 'Apple Pay',
      titleEn: 'Apple Pay',
      subtitleAr: 'دفع سريع وآمن',
      subtitleEn: 'Fast and secure',
      iconKey: 'phone',
      colorKey: 'surface',
    ),
    ModelPaymentMethod(
      id: 'cashOnDelivery',
      titleAr: 'الدفع عند الاستلام',
      titleEn: 'Cash on delivery',
      subtitleAr: 'ادفع عند استلام الطلب',
      subtitleEn: 'Pay when you receive the order',
      iconKey: 'cash',
      colorKey: 'tertiary',
    ),
  ];
  static const deliveryPickupOrderId = '8821';
  static const deliveryPickupOrderTotalJod = 42.50;
  static const deliveryPickupBagDepositJod = 2.0;
  static const deliveryShiftEarningsJod = 184.20;
  static const deliveryShiftTipsJod = 42.0;
  static const deliveryHistoryEarningsJod = 78.50;
  static const deliveryHistoryCompletedCount = 24;
  static const deliveryHistoryTipsJod = 14.25;
  static const deliveryReturnsTotalTrays = 142;
  static const deliveryReturnsDepositsRefundedJod = 2840.0;
  static const deliveryReturnsBreakageFeesJod = 125.50;
  static const deliveryReturnsSuccessRate = 98.2;
  static const platedDeliveryDepositJod = 10.0;
  static const plateReplacementCostJod = 2.0;

  static const inventoryAlerts = <ModelInventoryAlert>[
    ModelInventoryAlert(
      categoryAr: 'بروتين',
      categoryEn: 'Protein',
      nameAr: 'ستيك ريب آي',
      nameEn: 'Ribeye Steak',
      remainingAr: 'متبقي 3.2 كغ',
      remainingEn: '3.2 kg remaining',
      detailAr: 'نقطة إعادة الطلب 10 كغ',
      detailEn: 'Reorder point 10 kg',
    ),
    ModelInventoryAlert(
      categoryAr: 'ألبان',
      categoryEn: 'Dairy',
      nameAr: 'كريمة ثقيلة',
      nameEn: 'Heavy Cream',
      remainingAr: 'متبقي 1.5 لتر',
      remainingEn: '1.5 L remaining',
      detailAr: 'نقطة إعادة الطلب 5 لتر',
      detailEn: 'Reorder point 5 L',
    ),
    ModelInventoryAlert(
      categoryAr: 'خضار',
      categoryEn: 'Produce',
      nameAr: 'ريحان طازج',
      nameEn: 'Fresh Basil',
      remainingAr: 'متبقي 200 غ',
      remainingEn: '200 g remaining',
      detailAr: 'نقطة إعادة الطلب 500 غ',
      detailEn: 'Reorder point 500 g',
    ),
    ModelInventoryAlert(
      categoryAr: 'مخزن',
      categoryEn: 'Pantry',
      nameAr: 'زيت الكمأة',
      nameEn: 'Truffle Oil',
      remainingAr: 'نفد المخزون',
      remainingEn: 'Out of stock',
      detailAr: 'مطلوب لأطباق مميزة',
      detailEn: 'Required for signature dishes',
    ),
  ];

  static const inventoryLevels = <ModelInventoryLevel>[
    ModelInventoryLevel(
      nameAr: 'ستيك ريب آي',
      nameEn: 'Ribeye Steak',
      percent: 32,
      capacity: '10 kg',
      colorKey: 'primary',
    ),
    ModelInventoryLevel(
      nameAr: 'دجاج عضوي',
      nameEn: 'Organic Chicken',
      percent: 68,
      capacity: '45 kg',
      colorKey: 'secondary',
    ),
    ModelInventoryLevel(
      nameAr: 'بيض وألبان',
      nameEn: 'Dairy & Eggs',
      percent: 12,
      capacity: '50',
      colorKey: 'error',
    ),
    ModelInventoryLevel(
      nameAr: 'مأكولات بحرية',
      nameEn: 'Seafood',
      percent: 85,
      capacity: '20 kg',
      colorKey: 'secondary',
    ),
    ModelInventoryLevel(
      nameAr: 'طحين ومؤن',
      nameEn: 'Flour & Staples',
      percent: 54,
      capacity: '120 kg',
      colorKey: 'tertiary',
    ),
  ];

  static const inventoryStorageStatuses = <ModelInventoryStorageStatus>[
    ModelInventoryStorageStatus(
      nameAr: 'التخزين البارد',
      nameEn: 'Cold Storage',
      statusAr: 'مثالي',
      statusEn: 'Optimal',
    ),
    ModelInventoryStorageStatus(
      nameAr: 'التخزين الجاف',
      nameEn: 'Dry Storage',
      statusAr: 'مثالي',
      statusEn: 'Optimal',
    ),
    ModelInventoryStorageStatus(
      nameAr: 'وحدة التجميد',
      nameEn: 'Freezer Unit',
      statusAr: 'تنبيه',
      statusEn: 'Alert',
      hasAlert: true,
    ),
  ];

  static const inventoryWastageLogs = <ModelInventoryWastageLog>[
    ModelInventoryWastageLog(
      itemAr: 'صندوق أفوكادو',
      itemEn: 'Avocado Case',
      quantityAr: 'نصف صندوق',
      quantityEn: '0.5 Case',
      reasonAr: 'تلف',
      reasonEn: 'Spoilage',
      valueLostJod: -45,
      time: '09:12',
      userAr: 'الشيف',
      userEn: 'Chef',
    ),
    ModelInventoryWastageLog(
      itemAr: 'حليب كامل الدسم',
      itemEn: 'Whole Milk',
      quantityAr: '4 جالون',
      quantityEn: '4 Gallons',
      reasonAr: 'منتهي',
      reasonEn: 'Expired',
      valueLostJod: -22.40,
      time: '16:30',
      userAr: 'مسؤول المخزون',
      userEn: 'Inventory Admin',
    ),
    ModelInventoryWastageLog(
      itemAr: 'فيليه سي باس',
      itemEn: 'Sea Bass Fillets',
      quantityAr: '1.2 كغ',
      quantityEn: '1.2 kg',
      reasonAr: 'هدر تحضير',
      reasonEn: 'Prep Waste',
      valueLostJod: -78.10,
      time: '11:15',
      userAr: 'الطاهي',
      userEn: 'Line Cook',
    ),
  ];

  static const inventoryAuditRows = <ModelInventoryAuditRow>[
    ModelInventoryAuditRow(
      dateAr: 'اليوم 09:12',
      dateEn: 'Today 09:12',
      typeAr: 'تصحيح',
      typeEn: 'Correction',
      userAr: 'الشيف',
      userEn: 'Chef',
      amountAr: '-0.5 كغ',
      amountEn: '-0.5 kg',
      balanceAr: '42.5 كغ',
      balanceEn: '42.5 kg',
      isNegative: true,
    ),
    ModelInventoryAuditRow(
      dateAr: '24 أكتوبر 16:30',
      dateEn: 'Oct 24 16:30',
      typeAr: 'توريد',
      typeEn: 'Delivery',
      userAr: 'النظام',
      userEn: 'System Admin',
      amountAr: '+25.0 كغ',
      amountEn: '+25.0 kg',
      balanceAr: '43.0 كغ',
      balanceEn: '43.0 kg',
    ),
    ModelInventoryAuditRow(
      dateAr: '23 أكتوبر 11:15',
      dateEn: 'Oct 23 11:15',
      typeAr: 'استهلاك',
      typeEn: 'Consumption',
      userAr: 'الطاهي',
      userEn: 'Line Cook',
      amountAr: '-12.2 كغ',
      amountEn: '-12.2 kg',
      balanceAr: '18.0 كغ',
      balanceEn: '18.0 kg',
      isNegative: true,
    ),
  ];

  static const checkoutReviewLines = <ModelCartLine>[
    ModelCartLine(
      itemId: 'shawarma_meal_super',
      nameAr: 'وجبة شاورما سوبر',
      nameEn: 'Super shawarma meal',
      unitPriceJod: 2.75,
      quantity: 2,
    ),
    ModelCartLine(
      itemId: 'soft_drink',
      nameAr: 'مشروبات غازية',
      nameEn: 'Soft drink',
      unitPriceJod: 0.35,
      quantity: 2,
    ),
  ];

  static const checkoutOrderDetail = ModelOrderDetail(
    id: 'SV-99281',
    reference: checkoutOrderRef,
    customerNameAr: 'عميل عيلتنا',
    customerNameEn: 'Ayletna Guest',
    statusKey: 'pending',
    lines: checkoutReviewLines,
    deliveryFeeJod: checkoutDeliveryFeeJod,
    depositJod: 0,
    tipJod: 0,
    fulfillment: CheckoutFulfillment.delivery,
  );

  static const cartPreviewLines = <ModelCartLine>[
    ModelCartLine(
      itemId: 'shawarma_meal_super',
      nameAr: 'وجبة شاورما سوبر',
      nameEn: 'Super shawarma meal',
      unitPriceJod: 2.75,
      quantity: 1,
    ),
    ModelCartLine(
      itemId: 'hummus_medium',
      nameAr: 'صحن حمص وسط',
      nameEn: 'Medium hummus plate',
      unitPriceJod: 1.00,
      quantity: 2,
    ),
    ModelCartLine(
      itemId: 'manaqeesh_zaatar',
      nameAr: 'زعتر',
      nameEn: 'Zaatar manaqeesh',
      unitPriceJod: 0.60,
      quantity: 1,
    ),
  ];

  static const pickupModes = <ModelPickupMode>[
    ModelPickupMode(
      id: 'asap',
      titleAr: 'فوراً',
      titleEn: 'ASAP',
      subtitleAr: '15 - 20 دقيقة',
      subtitleEn: '15 - 20 mins',
      iconKey: 'flash',
      isSelected: true,
    ),
    ModelPickupMode(
      id: 'scheduled',
      titleAr: 'جدولة',
      titleEn: 'Schedule',
      subtitleAr: 'اختر وقتاً',
      subtitleEn: 'Choose time',
      iconKey: 'schedule',
    ),
  ];

  static const pickupDays = <ModelPickupSlot>[
    ModelPickupSlot(
      id: 'today',
      labelAr: 'اليوم',
      labelEn: 'Today',
      isSelected: true,
    ),
    ModelPickupSlot(id: 'tomorrow', labelAr: 'غداً', labelEn: 'Tomorrow'),
    ModelPickupSlot(id: 'oct25', labelAr: '25 أكتوبر', labelEn: 'Oct 25'),
  ];

  static const pickupSlots = <ModelPickupSlot>[
    ModelPickupSlot(
      id: 'slot_1230',
      labelAr: '12:30 م',
      labelEn: '12:30 PM',
      isSelected: true,
    ),
    ModelPickupSlot(id: 'slot_0100', labelAr: '01:00 م', labelEn: '01:00 PM'),
    ModelPickupSlot(id: 'slot_0130', labelAr: '01:30 م', labelEn: '01:30 PM'),
    ModelPickupSlot(id: 'slot_0200', labelAr: '02:00 م', labelEn: '02:00 PM'),
    ModelPickupSlot(
      id: 'slot_0230',
      labelAr: '02:30 م',
      labelEn: '02:30 PM',
      isDisabled: true,
      trailingAr: 'ممتلئ',
      trailingEn: 'Full',
    ),
  ];

  static const savedAddresses = <ModelSavedAddress>[
    ModelSavedAddress(
      id: 'home',
      labelAr: 'المنزل',
      labelEn: 'Home',
      addressAr: 'فيلا 42، شارع الريم، الصويفية، عمان، الأردن',
      addressEn: 'Villa 42, Al-Reem Street, Sweifieh, Amman, Jordan',
      iconKey: 'home',
      isSelected: true,
      contactName: 'Ahmad Al-Khatib',
      phone: '0791234567',
      building: '42',
      floor: '1',
      accessCode: '1234',
      customerAccountId: 'cust_1001',
    ),
    ModelSavedAddress(
      id: 'work',
      labelAr: 'العمل',
      labelEn: 'Work',
      addressAr: 'مجمع الملك حسين للأعمال، مبنى 5، الطابق الثالث، عمان',
      addressEn:
          'The Business Park, Building 5, 3rd Floor, King Hussein Business Park, Amman',
      iconKey: 'work',
      canRemove: false,
      contactName: 'Sara Office',
      phone: '0787654321',
      building: '5',
      floor: '3',
      customerAccountId: 'cust_2044',
    ),
    ModelSavedAddress(
      id: 'family',
      labelAr: 'بيت العائلة',
      labelEn: 'Family house',
      addressAr: 'شارع مكة، جبل الحسين، عمان',
      addressEn: 'Mecca Street, Jabal Al Hussein, Amman',
      iconKey: 'home',
      contactName: 'Omar Family',
      phone: '0771122334',
      building: '12',
      floor: '2',
    ),
  ];

  static const popularMenuItemIds = <String>[
    'shawarma_meal_super',
    'hummus_medium',
    'pizza_alfredo_medium',
    'burger_ayletna_150',
  ];

  static const comboHighlights = <ModelListEntry>[
    ModelListEntry(
      id: 'combo_family_shawarma',
      titleAr: 'كومبو شاورما العائلة',
      titleEn: 'Family shawarma combo',
      subtitleAr: 'وجبتان شاورما سوبر + حمص وسط + مشروبان',
      subtitleEn: '2 super shawarma meals + medium hummus + 2 drinks',
    ),
    ModelListEntry(
      id: 'combo_pizza_night',
      titleAr: 'كومبو ليلة البيتزا',
      titleEn: 'Pizza night combo',
      subtitleAr: 'بيتزا وسط + سناكات + مشروبات',
      subtitleEn: 'Medium pizza + snacks + drinks',
    ),
  ];

  static const discountedMenuItemIds = <String>[
    'hummus_medium',
    'pizza_alfredo_medium',
    'falafel_sandwich_regular',
  ];

  static const subscriptionMenuItemIds = <String>[
    'shawarma_meal_regular',
    'hummus_small',
    'falafel_sandwich_regular',
  ];

  static const homePromoCards = <ModelListEntry>[
    ModelListEntry(
      id: 'healthy_selection',
      titleAr: 'اختيارات صحية',
      titleEn: 'Healthy selection',
      subtitleAr: 'وجبات خفيفة ومشبعة لأيام العمل.',
      subtitleEn: 'Light, filling meals for workdays.',
    ),
    ModelListEntry(
      id: 'client_feedback',
      titleAr: 'آراء عملائنا',
      titleEn: 'Our clients feedback',
      subtitleAr: 'أكثر ما يطلبه ضيوف عيلتنا هذا الأسبوع.',
      subtitleEn: 'What Ayletna guests loved most this week.',
    ),
    ModelListEntry(
      id: 'festival_table',
      titleAr: 'مائدة المهرجانات',
      titleEn: 'Festival table',
      subtitleAr: 'اقتراحات للمناسبات والجمعات العائلية.',
      subtitleEn: 'Picks for gatherings and family occasions.',
    ),
  ];

  static const customerOrderHistory = <ModelCustomerOrderHistory>[
    ModelCustomerOrderHistory(
      id: '#SV-9821',
      labelAr: 'طلب #SV-9821',
      labelEn: 'Order #SV-9821',
      dateAr: '12 أكتوبر 2023 • 14:30',
      dateEn: 'Oct 12, 2023 • 14:30',
      totalJod: 7.20,
      itemsAr: ['2x وجبة شاورما سوبر', '2x مشروبات غازية', '1x حمص وسط'],
      itemsEn: [
        '2x Super shawarma meal',
        '2x Soft drink',
        '1x Medium hummus plate',
      ],
      isActive: true,
      currentStepIndex: 3,
      driverPhone: '+962790000123',
    ),
    ModelCustomerOrderHistory(
      id: '#SV-9750',
      labelAr: 'طلب #SV-9750',
      labelEn: 'Order #SV-9750',
      dateAr: '8 أكتوبر 2023 • 20:15',
      dateEn: 'Oct 08, 2023 • 20:15',
      totalJod: 4.75,
      itemsAr: ['1x بيتزا الفريدو وسط', '1x ماء صغير', '1x شاي'],
      itemsEn: ['1x Medium Alfredo pizza', '1x Small water', '1x Tea'],
      isCancelled: true,
    ),
    ModelCustomerOrderHistory(
      id: '#SV-9612',
      labelAr: 'طلب #SV-9612',
      labelEn: 'Order #SV-9612',
      dateAr: '2 أكتوبر 2023 • 19:45',
      dateEn: 'Oct 02, 2023 • 19:45',
      totalJod: 13.50,
      itemsAr: ['3x برغر عيلتنا 150 غم', '2x بطاطا - حمام / عادي', '3x عيران'],
      itemsEn: [
        '3x Ayletna burger 150g',
        '2x Potato sandwich - regular bread',
        '3x Ayran',
      ],
      metaAr: 'داخلي • طاولة 4',
      metaEn: 'Dine-In • Table 4',
    ),
  ];

  static const walletTransactions = <ModelWalletTransaction>[
    ModelWalletTransaction(
      id: 'burger-hub',
      titleAr: 'مطعم البرغر',
      titleEn: 'The Burger Hub',
      metaAr: 'طلب طعام • 12 أكتوبر',
      metaEn: 'Food order • Oct 12',
      amountLabelAr: '- 18.50 د.أ',
      amountLabelEn: '- JOD 18.50',
      detailAr: '+185 نقطة',
      detailEn: '+185 pts',
      iconKey: 'restaurant',
      colorKey: 'error',
      isPositive: false,
    ),
    ModelWalletTransaction(
      id: 'refund',
      titleAr: 'استرداد وديعة',
      titleEn: 'Deposit refund',
      metaAr: 'إرجاع أطباق • 10 أكتوبر',
      metaEn: 'Plate return • Oct 10',
      amountLabelAr: '+ 5.00 د.أ',
      amountLabelEn: '+ JOD 5.00',
      detailAr: 'رصيد محفظة',
      detailEn: 'Wallet credit',
      iconKey: 'return',
      colorKey: 'success',
      isPositive: true,
    ),
    ModelWalletTransaction(
      id: 'top-up',
      titleAr: 'تعبئة المحفظة',
      titleEn: 'Wallet top-up',
      metaAr: 'بطاقة فيزا • 8 أكتوبر',
      metaEn: 'Visa card • Oct 08',
      amountLabelAr: '+ 25.00 د.أ',
      amountLabelEn: '+ JOD 25.00',
      detailAr: 'مكتمل',
      detailEn: 'Completed',
      iconKey: 'top_up',
      colorKey: 'delivery',
      isPositive: true,
    ),
    ModelWalletTransaction(
      id: 'pasta-prime',
      titleAr: 'باستا برايم',
      titleEn: 'Pasta Prime',
      metaAr: 'طلب طعام • 4 أكتوبر',
      metaEn: 'Food order • Oct 04',
      amountLabelAr: '- 12.30 د.أ',
      amountLabelEn: '- JOD 12.30',
      detailAr: '+123 نقطة',
      detailEn: '+123 pts',
      iconKey: 'bag',
      colorKey: 'error',
      isPositive: false,
    ),
    ModelWalletTransaction(
      id: 'free-drink',
      titleAr: 'مكافأة مشروب مجاني',
      titleEn: 'Free drink reward',
      metaAr: 'استبدال نقاط • 1 أكتوبر',
      metaEn: 'Points redeemed • Oct 01',
      amountLabelAr: '- 200 نقطة',
      amountLabelEn: '- 200 pts',
      detailAr: 'مكافأة',
      detailEn: 'Reward',
      iconKey: 'gift',
      colorKey: 'orange',
      isPositive: false,
    ),
  ];

  static const restaurantPhoneNumber = '+96262000000';
  static const restaurantWhatsappNumber = '962790000321';

  static const supportTickets = <ModelSupportTicket>[
    ModelSupportTicket(
      id: 'AYL-2048',
      titleAr: 'متابعة طلب التوصيل',
      titleEn: 'Delivery order follow-up',
      bodyAr: 'سؤال عن وقت وصول الطلب النشط.',
      bodyEn: 'Question about the active order arrival time.',
      statusAr: 'قيد المتابعة',
      statusEn: 'In progress',
      updatedAr: 'قبل 12 دقيقة',
      updatedEn: '12 min ago',
    ),
    ModelSupportTicket(
      id: 'AYL-2019',
      titleAr: 'استفسار عن نقاط الولاء',
      titleEn: 'Loyalty points question',
      bodyAr: 'تم توضيح طريقة احتساب النقاط للطلب السابق.',
      bodyEn: 'Explained how points were calculated for the last order.',
      statusAr: 'تم الحل',
      statusEn: 'Resolved',
      updatedAr: 'أمس',
      updatedEn: 'Yesterday',
    ),
  ];

  static const customerRewards = <ModelCustomerReward>[
    ModelCustomerReward(
      id: 'signature-platter',
      titleAr: 'برغر عيلتنا المميز',
      titleEn: 'Signature Ayletna burger',
      descriptionAr: 'استبدل نقاطك ببرغر عيلتنا 150 غم.',
      descriptionEn: 'Redeem points for the Ayletna 150g burger.',
      points: 1200,
      categoryKey: 'main',
      artKey: 'burger',
      colorKey: 'primary',
      badgeAr: 'الأكثر طلباً',
      badgeEn: 'Popular',
      isPopular: true,
    ),
    ModelCustomerReward(
      id: 'large-pizza',
      titleAr: 'بيتزا كبيرة',
      titleEn: 'Large pizza',
      descriptionAr: 'بيتزا كبيرة مجانية عند الاستبدال.',
      descriptionEn: 'A complimentary large pizza redemption.',
      points: 850,
      categoryKey: 'main',
      artKey: 'burger',
      colorKey: 'tertiary',
    ),
    ModelCustomerReward(
      id: 'free-dessert',
      titleAr: 'معجنات مجانية',
      titleEn: 'Free pastry',
      descriptionAr: 'اختيارك من معجنات عيلتنا اليومية.',
      descriptionEn: 'Your choice from the daily Ayletna pastries.',
      points: 450,
      categoryKey: 'sides',
      artKey: 'donut',
      colorKey: 'secondary',
      badgeAr: 'طبق جانبي',
      badgeEn: 'Side',
    ),
    ModelCustomerReward(
      id: 'chef-tasting',
      titleAr: 'تجربة تذوق الشيف',
      titleEn: 'Chef tasting',
      descriptionAr: 'تجربة خاصة لأعضاء الفئة البلاتينية.',
      descriptionEn: 'A private tasting experience for platinum members.',
      points: 5000,
      categoryKey: 'main',
      artKey: 'bowl',
      colorKey: 'outline',
      isLocked: true,
    ),
    ModelCustomerReward(
      id: 'nitro-cold-brew',
      titleAr: 'قهوة نيترو باردة',
      titleEn: 'Nitro cold brew',
      descriptionAr: 'مشروب بارد منعش.',
      descriptionEn: 'A refreshing cold drink.',
      points: 350,
      categoryKey: 'drinks',
      artKey: 'drink',
      colorKey: 'delivery',
    ),
    ModelCustomerReward(
      id: 'truffle-fries',
      titleAr: 'بطاطا بارميزان بالكمأة',
      titleEn: 'Truffle parm fries',
      descriptionAr: 'بطاطا مقرمشة مع بارميزان.',
      descriptionEn: 'Crispy fries with parmesan.',
      points: 450,
      categoryKey: 'sides',
      artKey: 'fries',
      colorKey: 'orange',
      badgeAr: 'طبق جانبي',
      badgeEn: 'Side',
    ),
    ModelCustomerReward(
      id: 'berry-bowl',
      titleAr: 'وعاء التوت',
      titleEn: 'Berry power bowl',
      descriptionAr: 'وجبة رئيسية خفيفة وغنية.',
      descriptionEn: 'A light and rich main reward.',
      points: 800,
      categoryKey: 'main',
      artKey: 'bowl',
      colorKey: 'dine_in',
      badgeAr: 'طبق رئيسي',
      badgeEn: 'Main',
    ),
    ModelCustomerReward(
      id: 'donut-selection',
      titleAr: 'تشكيلة دونات',
      titleEn: 'Donut selection',
      descriptionAr: 'تشكيلة حلوى موسمية.',
      descriptionEn: 'A seasonal sweet selection.',
      points: 200,
      categoryKey: 'sides',
      artKey: 'donut',
      colorKey: 'olive',
      isSoldOut: true,
    ),
  ];

  static const customerNotifications = <ModelCustomerNotification>[
    ModelCustomerNotification(
      id: 'delivery-8829',
      titleAr: 'الطلب #8829 في طريقه للتوصيل',
      titleEn: 'Order #8829 is out for delivery',
      bodyAr: 'استلم السائق أحمد الطلب وهو الآن متجه إلى موقع التسليم.',
      bodyEn:
          'Driver Ahmad has picked up the order and is heading to the destination.',
      timeAr: 'قبل دقيقتين',
      timeEn: '2 mins ago',
      iconKey: 'delivery',
      colorKey: 'plated',
      actionLabelsAr: ['تتبع الخريطة', 'اتصل بالسائق'],
      actionLabelsEn: ['Track Map', 'Contact Driver'],
      actionRoutes: ['/order-tracking', null],
    ),
    ModelCustomerNotification(
      id: 'tip-ready',
      titleAr: 'توزيع الإكراميات جاهز',
      titleEn: 'Tip distribution ready',
      bodyAr: 'تم احتساب إكراميات وردية الصباح وهي جاهزة للتوزيع.',
      bodyEn:
          'The tip pool for the morning shift has been calculated and is ready for distribution.',
      timeAr: 'قبل 15 دقيقة',
      timeEn: '15 mins ago',
      iconKey: 'payments',
      colorKey: 'plated',
      actionLabelsAr: ['وزع الآن', 'راجع التفاصيل'],
      actionLabelsEn: ['Distribute Now', 'Review Breakdown'],
      primaryActionIndexes: {0},
    ),
    ModelCustomerNotification(
      id: 'tray-reminder',
      titleAr: 'تذكير جمع الصواني',
      titleEn: 'Tray collection reminder',
      bodyAr:
          'تنبيه استدامة: توجد 12 صينية قابلة لإعادة الاستخدام لم تعد بعد في نقاط تجميع بلوك ب.',
      bodyEn:
          'Sustainability alert: 12 reusable trays are currently unreturned at Block B collection points.',
      timeAr: 'قبل 45 دقيقة',
      timeEn: '45 mins ago',
      iconKey: 'eco',
      colorKey: 'success',
      actionLabelsAr: ['نبه فريق الجمع'],
      actionLabelsEn: ['Ping Collection Staff'],
      actionRoutes: ['/plated-return-reminder'],
    ),
    ModelCustomerNotification(
      id: 'stock-alert',
      titleAr: 'تنبيه مخزون: حبوب إسبريسو مميزة',
      titleEn: 'Stock alert: Premium Espresso Beans',
      bodyAr:
          'انخفض مستوى المخزون تحت حد 15%. يفضل إعادة الطلب قريباً لتجنب انقطاع الخدمة.',
      bodyEn:
          'Inventory level dropped below the 15% threshold. Consider restocking soon to avoid service interruption.',
      timeAr: 'قبل ساعة',
      timeEn: '1 hour ago',
      iconKey: 'inventory',
      colorKey: 'warning',
      actionLabelsAr: ['اطلب المزيد', 'تجاهل الآن'],
      actionLabelsEn: ['Order More', 'Ignore for now'],
      primaryActionIndexes: {0},
    ),
    ModelCustomerNotification(
      id: 'pickup-ready',
      titleAr: 'الطلب #7741 جاهز للاستلام',
      titleEn: 'Order #7741 is ready for pickup',
      bodyAr: 'الوجبة المطلية الآن على رف التسخين في المحطة 3.',
      bodyEn: 'The plated meal is now on the heat rack at Station 3.',
      timeAr: 'قبل 3 ساعات',
      timeEn: '3 hours ago',
      iconKey: 'restaurant',
      colorKey: 'delivery',
      actionLabelsAr: ['عرض التذكرة'],
      actionLabelsEn: ['View Ticket'],
      actionRoutes: ['/order-history'],
    ),
    ModelCustomerNotification(
      id: 'policy-update',
      titleAr: 'تحديث سياسة جديد',
      titleEn: 'New Policy Update',
      bodyAr:
          'تم تحديث إرشادات التعقيم. يرجى مراجعة قائمة الفحص الجديدة في بوابة الموظفين.',
      bodyEn:
          'The sanitation guidelines have been updated. Please review the new checklist in the staff portal.',
      timeAr: 'قبل 24 ساعة',
      timeEn: '24 hours ago',
      iconKey: 'campaign',
      colorKey: 'warning',
      isSubdued: true,
    ),
  ];

  static const customerNotificationCategories =
      <ModelCustomerNotificationCategory>[
        ModelCustomerNotificationCategory(
          id: 'all',
          labelAr: 'الكل',
          labelEn: 'All',
          count: 12,
          iconKey: 'all',
          colorKey: 'primary',
          isSelected: true,
        ),
        ModelCustomerNotificationCategory(
          id: 'orders',
          labelAr: 'تحديثات الطلبات',
          labelEn: 'Order Updates',
          count: 4,
          iconKey: 'delivery',
          colorKey: 'delivery',
        ),
        ModelCustomerNotificationCategory(
          id: 'sustainability',
          labelAr: 'الاستدامة',
          labelEn: 'Sustainability',
          count: 3,
          iconKey: 'eco',
          colorKey: 'secondary',
        ),
        ModelCustomerNotificationCategory(
          id: 'account',
          labelAr: 'الحساب والتنبيهات',
          labelEn: 'Account & Alerts',
          count: 5,
          iconKey: 'admin',
          colorKey: 'warning',
        ),
      ];

  static const kitchenReadyOrders = <ModelKitchenReadyOrder>[
    ModelKitchenReadyOrder(
      id: '1084',
      destinationAr: 'طاولة 12',
      destinationEn: 'Table 12',
      badgeAr: 'داخلي',
      badgeEn: 'Dine-In',
      typeKey: 'dine_in',
      readyTime: '02:45',
      actionLabelAr: 'سلم للنادل',
      actionLabelEn: 'Handover to server',
      actionIcon: Icons.person_add_alt_1_outlined,
      itemsAr: [
        ModelKitchenReadyItem(quantity: 2, name: 'برغر واجيو مميز'),
        ModelKitchenReadyItem(quantity: 1, name: 'بطاطا بارميزان بالكمأة'),
        ModelKitchenReadyItem(quantity: 2, name: 'ماتشا مثلجة'),
      ],
      itemsEn: [
        ModelKitchenReadyItem(quantity: 2, name: 'Signature Wagyu Burger'),
        ModelKitchenReadyItem(quantity: 1, name: 'Truffle Parmesan Fries'),
        ModelKitchenReadyItem(quantity: 2, name: 'Iced Matcha Latte'),
      ],
    ),
    ModelKitchenReadyOrder(
      id: '1087',
      destinationAr: 'كاونتر سريع',
      destinationEn: 'Express Counter',
      badgeAr: 'استدامة',
      badgeEn: 'Sustainability',
      typeKey: 'plated',
      readyTime: '16:20',
      actionLabelAr: 'سلم الآن',
      actionLabelEn: 'Handover now',
      actionIcon: Icons.pan_tool_outlined,
      isDelayed: true,
      noteAr: 'العميل ينتظر عند نقطة الاستلام.',
      noteEn: 'Customer is waiting at the pickup point.',
      itemsAr: [
        ModelKitchenReadyItem(quantity: 1, name: 'وعاء كيل بلا هدر'),
        ModelKitchenReadyItem(quantity: 1, name: 'عصير لب معاد التدوير'),
      ],
      itemsEn: [
        ModelKitchenReadyItem(quantity: 1, name: 'Zero-Waste Kale Bowl'),
        ModelKitchenReadyItem(quantity: 1, name: 'Recycled Pulp Juice'),
      ],
    ),
    ModelKitchenReadyOrder(
      id: '1102',
      destinationAr: 'الضيفة سارة',
      destinationEn: 'Guest Sarah',
      badgeAr: 'استلام',
      badgeEn: 'Takeaway',
      typeKey: 'takeaway',
      readyTime: '01:10',
      actionLabelAr: 'سلم للضيف',
      actionLabelEn: 'Handover to guest',
      actionIcon: Icons.shopping_bag_outlined,
      itemsAr: [
        ModelKitchenReadyItem(quantity: 1, name: 'طبق متوسطي'),
        ModelKitchenReadyItem(quantity: 1, name: 'خبز بيتا إضافي'),
      ],
      itemsEn: [
        ModelKitchenReadyItem(quantity: 1, name: 'Mediterranean Plate'),
        ModelKitchenReadyItem(quantity: 1, name: 'Extra Pita Side'),
      ],
    ),
    ModelKitchenReadyOrder(
      id: '1105',
      destinationAr: 'مندوب جيمس',
      destinationEn: 'Courier James',
      badgeAr: 'توصيل',
      badgeEn: 'Delivery',
      typeKey: 'delivery',
      readyTime: '03:22',
      actionLabelAr: 'سلم للمندوب',
      actionLabelEn: 'Handover to courier',
      actionIcon: Icons.local_shipping_outlined,
      itemsAr: [
        ModelKitchenReadyItem(quantity: 3, name: 'ساندو دجاج مقرمش'),
        ModelKitchenReadyItem(quantity: 1, name: 'كومبو رامن حار'),
      ],
      itemsEn: [
        ModelKitchenReadyItem(quantity: 3, name: 'Crispy Chicken Sando'),
        ModelKitchenReadyItem(quantity: 1, name: 'Spicy Ramen Combo'),
      ],
    ),
    ModelKitchenReadyOrder(
      id: '1109',
      destinationAr: 'طاولة 04',
      destinationEn: 'Table 04',
      badgeAr: 'داخلي',
      badgeEn: 'Dine-In',
      typeKey: 'dine_in',
      readyTime: '00:30',
      actionLabelAr: 'سلم للنادل',
      actionLabelEn: 'Handover to server',
      actionIcon: Icons.person_add_alt_1_outlined,
      itemsAr: [ModelKitchenReadyItem(quantity: 1, name: 'سلطة خضراء طازجة')],
      itemsEn: [ModelKitchenReadyItem(quantity: 1, name: 'Garden Fresh Salad')],
    ),
  ];

  static const kitchenPrepItems = <ModelKitchenPrepItem>[
    ModelKitchenPrepItem(
      quantity: 2,
      nameAr: 'برغر واجيو',
      nameEn: 'Wagyu Burger',
      warningAr: 'بدون بصل',
      warningEn: 'No onions',
      specsAr: 'متوسط النضج • خبز بريوش • مخلل إضافي',
      specsEn: 'Medium Rare • Brioche Bun • Extra Pickles',
    ),
    ModelKitchenPrepItem(
      quantity: 1,
      nameAr: 'بطاطا بالكمأة',
      nameEn: 'Truffle Fries',
      specsAr: 'بارميزان • صلصة على الجانب',
      specsEn: 'Parmesan • Sauce on side',
    ),
    ModelKitchenPrepItem(
      quantity: 2,
      nameAr: 'سيزر البيت',
      nameEn: 'House Caesar',
      specsAr: 'صلصة خفيفة • خبز محمص إضافي',
      specsEn: 'Light dressing • Extra croutons',
    ),
  ];

  static const deliveryPickupItems = <ModelDeliveryPickupItem>[
    ModelDeliveryPickupItem(
      titleAr: 'برغر واجيو حرفي',
      titleEn: 'Artisan Wagyu Burger',
      subtitleAr: 'متوسط النضج • بدون بصل',
      subtitleEn: 'Medium Rare • No Onions',
      quantity: 1,
    ),
    ModelDeliveryPickupItem(
      titleAr: 'بطاطا بارميزان بالكمأة',
      titleEn: 'Truffle Parmesan Fries',
      subtitleAr: 'صلصة إضافية',
      subtitleEn: 'Extra Dipping Sauce',
      quantity: 1,
    ),
    ModelDeliveryPickupItem(
      titleAr: 'شاي كركديه مثلج',
      titleEn: 'Iced Hibiscus Tea',
      subtitleAr: 'كبير • سكر 50%',
      subtitleEn: 'Large • 50% Sugar',
      quantity: 2,
    ),
  ];

  static const deliveryReturnTasks = <ModelDeliveryReturnTask>[
    ModelDeliveryReturnTask(
      id: 'return-eleanor',
      nameAr: 'إليانور شلستروب',
      nameEn: 'Eleanor Shellstrop',
      addressAr: 'برج بارك، الطابق 14',
      addressEn: 'Park Tower, Floor 14',
      statusAr: 'متأخر',
      statusEn: 'Overdue',
      itemSummaryAr: '4 أطباق كبيرة + صينيتان',
      itemSummaryEn: '4 large plates + 2 trays',
      iconKey: 'receipt',
      colorKey: 'error',
      mapFilled: true,
    ),
    ModelDeliveryReturnTask(
      id: 'return-tahani',
      nameAr: 'تهاني الجميل',
      nameEn: 'Tahani Al-Jamil',
      addressAr: 'عبدون، شارع الليمون',
      addressEn: 'Abdoun, Lemon Street',
      statusAr: 'بعد 20 دقيقة',
      statusEn: 'In 20 min',
      itemSummaryAr: 'طبق متوسط + وعاءان',
      itemSummaryEn: 'Medium plate + 2 bowls',
      iconKey: 'delivery',
      colorKey: 'success',
    ),
    ModelDeliveryReturnTask(
      id: 'return-chidi',
      nameAr: 'تشيدي أناجوني',
      nameEn: 'Chidi Anagonye',
      addressAr: 'اللويبدة، قرب الدوار',
      addressEn: 'Lweibdeh, near the circle',
      statusAr: 'مجدول',
      statusEn: 'Scheduled',
      itemSummaryAr: '3 صواني',
      itemSummaryEn: '3 trays',
      iconKey: 'kitchen',
      colorKey: 'primary',
    ),
  ];

  static ModelMenuItem _realMenuItem(
    String id,
    String categoryId,
    String nameAr,
    String nameEn,
    double priceJod, {
    String? descriptionAr,
    String? descriptionEn,
    String? imageUrl,
    bool isFeatured = false,
    bool isAvailable = true,
    int sortOrder = 0,
  }) {
    return ModelMenuItem(
      id: id,
      categoryId: categoryId,
      nameAr: nameAr,
      nameEn: nameEn,
      priceJod: priceJod,
      descriptionAr: descriptionAr ?? 'صنف من قائمة عيلتنا الفعلية.',
      descriptionEn: descriptionEn ?? 'Item from the real Ayletna menu.',
      imageUrl: imageUrl ?? _menuImageUrlForItem(id, categoryId),
      isFeatured: isFeatured,
      isAvailable: isAvailable,
      sortOrder: sortOrder,
    );
  }

  static String _menuImageUrlForItem(String id, String categoryId) {
    final photoId = switch (categoryId) {
      'shawarma' => 'photo-1529006557810-274b9b2fc783',
      'qalayat' =>
        id.contains('egg') || id.contains('shakshuka')
            ? 'photo-1590412200988-a436970781fa'
            : 'photo-1601050690597-df0568f70950',
      'hummus_ful' =>
        id.contains('fries') || id.contains('fried')
            ? 'photo-1576107232684-1279f390859f'
            : id.contains('fatteh')
            ? 'photo-1604908176997-125f25cc6f3d'
            : id.contains('mutabbal')
            ? 'photo-1542528180-a1208c5169a5'
            : id.contains('ful')
            ? 'photo-1579631542720-3a87824fff86'
            : 'photo-1577805947697-89e18249d767',
      'drinks' =>
        id.contains('coffee')
            ? 'photo-1509042239860-f550ce710b93'
            : id.contains('tea')
            ? 'photo-1544787219-7f47ccb76574'
            : id.contains('water')
            ? 'photo-1523362628745-0c100150b504'
            : id.contains('ayran')
            ? 'photo-1551024601-bec78aea704b'
            : 'photo-1513558161293-cdaf765ed2fd',
      'sandwiches' =>
        id.contains('potato')
            ? 'photo-1528736235302-52922df5c122'
            : 'photo-1528735602780-2552fd46c7af',
      'falafel' => 'photo-1593001872095-7d5b3868fb1d',
      'pizza' =>
        id.contains('margherita')
            ? 'photo-1574071318508-1cdbab80d002'
            : id.contains('bbq')
            ? 'photo-1565299624946-b28f40a0ae38'
            : id.contains('alfredo')
            ? 'photo-1593560708920-61dd98c46a4e'
            : 'photo-1513104890138-7c749659a591',
      'snacks' =>
        id.contains('hotdog')
            ? 'photo-1528735602780-2552fd46c7af'
            : id.contains('zinger')
            ? 'photo-1562967916-eb82221dfb92'
            : 'photo-1528735602780-2552fd46c7af',
      'manaqeesh' =>
        id.contains('zaatar')
            ? 'photo-1604908176997-125f25cc6f3d'
            : id.contains('cheese') || id.contains('halloumi')
            ? 'photo-1578985545062-69928b1d9587'
            : 'photo-1604908176997-125f25cc6f3d',
      'pastries' =>
        id.contains('kibbeh')
            ? 'photo-1601050690597-df0568f70950'
            : id.contains('musakhan')
            ? 'photo-1528735602780-2552fd46c7af'
            : 'photo-1509440159596-0249088772ff',
      'burgers' =>
        id.contains('chicken')
            ? 'photo-1606755962773-d324e0a13086'
            : 'photo-1568901346375-23c9450c58cd',
      _ => 'photo-1504674900247-0877df9cc836',
    };

    return 'https://images.unsplash.com/$photoId?auto=format&fit=crop&w=900&q=80';
  }

  static const categories = <ModelMenuCategory>[
    ModelMenuCategory(
      id: 'shawarma',
      nameAr: 'الشاورما',
      nameEn: 'Shawarma',
      iconKey: 'shawarma',
      descriptionAr: 'شاورما الدجاج اللذيذة على الفحم',
      descriptionEn: 'Delicious charcoal-grilled chicken shawarma',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'qalayat',
      nameAr: 'القلايات',
      nameEn: 'Skillets',
      iconKey: 'skillet',
      descriptionAr: 'مقليات ساخنة وشهية',
      descriptionEn: 'Hot and tasty skillet dishes',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'hummus_ful',
      nameAr: 'حمص وفول',
      nameEn: 'Hummus & Ful',
      iconKey: 'hummus',
      descriptionAr: 'حمص طري وفول مدمس بزيت الزيتون',
      descriptionEn: 'Smooth hummus and fava beans with olive oil',
      mealType: 'side',
    ),
    ModelMenuCategory(
      id: 'drinks',
      nameAr: 'المشروبات',
      nameEn: 'Drinks',
      iconKey: 'drink',
      descriptionAr: 'مشروبات باردة وساخنة منعشة',
      descriptionEn: 'Refreshing cold and hot beverages',
      mealType: 'drink',
    ),
    ModelMenuCategory(
      id: 'sandwiches',
      nameAr: 'السندويشات',
      nameEn: 'Sandwiches',
      iconKey: 'sandwich',
      descriptionAr: 'سندويشات طازجة ومتنوعة',
      descriptionEn: 'Fresh and varied sandwiches',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'falafel',
      nameAr: 'الفلافل',
      nameEn: 'Falafel',
      iconKey: 'falafel',
      descriptionAr: 'فلافل مقرمشة وحمص طري',
      descriptionEn: 'Crispy falafel with smooth hummus',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'pizza',
      nameAr: 'البيتزا',
      nameEn: 'Pizza',
      iconKey: 'pizza',
      descriptionAr: 'بيتزا طازجة بالجبنة والصلصة',
      descriptionEn: 'Fresh pizza with cheese and sauce',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'snacks',
      nameAr: 'السناك',
      nameEn: 'Snacks',
      iconKey: 'snack',
      descriptionAr: 'وجبات خفيفة ومقبلات',
      descriptionEn: 'Light snacks and appetizers',
      mealType: 'side',
    ),
    ModelMenuCategory(
      id: 'manaqeesh',
      nameAr: 'المناقيش',
      nameEn: 'Manaqeesh',
      iconKey: 'manaqeesh',
      descriptionAr: 'مناقيش زعتر وجبنة على الساج',
      descriptionEn: 'Zaatar and cheese manaqeesh on saj',
      mealType: 'main',
    ),
    ModelMenuCategory(
      id: 'pastries',
      nameAr: 'المعجنات',
      nameEn: 'Pastries',
      iconKey: 'pastry',
      descriptionAr: 'معجنات طازجة ومحشية',
      descriptionEn: 'Fresh stuffed pastries',
      mealType: 'dessert',
    ),
    ModelMenuCategory(
      id: 'burgers',
      nameAr: 'البرجر',
      nameEn: 'Burgers',
      iconKey: 'burger',
      descriptionAr: 'برجر لحم ودجاج مع البطاطا',
      descriptionEn: 'Beef and chicken burgers with fries',
      mealType: 'main',
    ),
  ];

  static final items = <ModelMenuItem>[
    _realMenuItem(
      'shawarma_sandwich_regular',
      'shawarma',
      'ساندويش شاورما عادي',
      'Regular shawarma sandwich',
      0.75,
    ),
    _realMenuItem(
      'shawarma_sandwich_super',
      'shawarma',
      'ساندويش شاورما سوبر',
      'Super shawarma sandwich',
      1.25,
    ),
    _realMenuItem(
      'shawarma_meal_regular',
      'shawarma',
      'وجبة شاورما عادي',
      'Regular shawarma meal',
      2.25,
    ),
    _realMenuItem(
      'shawarma_meal_super',
      'shawarma',
      'وجبة شاورما سوبر',
      'Super shawarma meal',
      2.75,
      isFeatured: true,
    ),
    _realMenuItem(
      'shawarma_meal_double',
      'shawarma',
      'وجبة شاورما دبل',
      'Double shawarma meal',
      3.25,
    ),
    _realMenuItem(
      'shawarma_meal_triple',
      'shawarma',
      'وجبة شاورما تربل',
      'Triple shawarma meal',
      4.00,
    ),
    _realMenuItem(
      'shawarma_meal_italian',
      'shawarma',
      'وجبة شاورما إيطالي',
      'Italian shawarma meal',
      3.50,
    ),
    _realMenuItem(
      'qalayat_tomato',
      'qalayat',
      'قلاية بندورة',
      'Tomato skillet',
      1.00,
    ),
    _realMenuItem(
      'qalayat_tomato_meat',
      'qalayat',
      'قلاية بندورة مع لحمة',
      'Tomato skillet with meat',
      1.50,
    ),
    _realMenuItem(
      'qalayat_chicken_liver',
      'qalayat',
      'كبدة دجاج',
      'Chicken liver skillet',
      1.50,
    ),
    _realMenuItem(
      'qalayat_chicken_liver_hummus',
      'qalayat',
      'كبدة دجاج مع حمص',
      'Chicken liver with hummus',
      1.50,
    ),
    _realMenuItem(
      'qalayat_lamb_liver',
      'qalayat',
      'كبدة غنم',
      'Lamb liver skillet',
      2.00,
    ),
    _realMenuItem(
      'qalayat_mafrakeh',
      'qalayat',
      'مفركة',
      'Mafrakeh skillet',
      1.00,
    ),
    _realMenuItem(
      'qalayat_sausage_eggs',
      'qalayat',
      'نقانق بالبيض',
      'Sausage with eggs',
      1.00,
    ),
    _realMenuItem(
      'qalayat_spleen',
      'qalayat',
      'طحالات',
      'Spleen skillet',
      2.00,
    ),
    _realMenuItem('qalayat_shakshuka', 'qalayat', 'شكشوكة', 'Shakshuka', 1.00),
    _realMenuItem(
      'qalayat_omelette',
      'qalayat',
      'بيض عجة',
      'Omelette eggs',
      1.00,
    ),
    _realMenuItem(
      'qalayat_eggs',
      'qalayat',
      'بيض مسلوق / مقلي عيون',
      'Boiled or sunny-side eggs',
      1.00,
    ),
    _realMenuItem(
      'hummus_small',
      'hummus_ful',
      'صحن حمص صغير',
      'Small hummus plate',
      0.60,
    ),
    _realMenuItem(
      'hummus_medium',
      'hummus_ful',
      'صحن حمص وسط',
      'Medium hummus plate',
      1.00,
      isFeatured: true,
    ),
    _realMenuItem(
      'hummus_large',
      'hummus_ful',
      'صحن حمص كبير',
      'Large hummus plate',
      1.35,
    ),
    _realMenuItem('ful_small', 'hummus_ful', 'فول صغير', 'Small ful', 0.60),
    _realMenuItem('ful_medium', 'hummus_ful', 'فول وسط', 'Medium ful', 1.00),
    _realMenuItem('ful_large', 'hummus_ful', 'فول كبير', 'Large ful', 1.35),
    _realMenuItem(
      'musabaha_small',
      'hummus_ful',
      'مسبحة صغير',
      'Small musabaha',
      0.60,
    ),
    _realMenuItem(
      'musabaha_medium',
      'hummus_ful',
      'مسبحة وسط',
      'Medium musabaha',
      1.00,
    ),
    _realMenuItem(
      'musabaha_large',
      'hummus_ful',
      'مسبحة كبير',
      'Large musabaha',
      1.35,
    ),
    _realMenuItem(
      'qudsieh_small',
      'hummus_ful',
      'قدسية صغير',
      'Small qudsieh',
      0.60,
    ),
    _realMenuItem(
      'qudsieh_medium',
      'hummus_ful',
      'قدسية وسط',
      'Medium qudsieh',
      1.00,
    ),
    _realMenuItem(
      'qudsieh_large',
      'hummus_ful',
      'قدسية كبير',
      'Large qudsieh',
      1.35,
    ),
    _realMenuItem(
      'mutabbal_small',
      'hummus_ful',
      'متبل صغير',
      'Small mutabbal',
      0.60,
    ),
    _realMenuItem(
      'mutabbal_medium',
      'hummus_ful',
      'متبل وسط',
      'Medium mutabbal',
      1.00,
    ),
    _realMenuItem(
      'mutabbal_large',
      'hummus_ful',
      'متبل كبير',
      'Large mutabbal',
      1.35,
    ),
    _realMenuItem(
      'fatteh_nuts_small',
      'hummus_ful',
      'فتة بالمكسرات صغير',
      'Small fatteh with nuts',
      1.50,
    ),
    _realMenuItem(
      'fatteh_nuts_medium',
      'hummus_ful',
      'فتة بالمكسرات وسط',
      'Medium fatteh with nuts',
      2.25,
    ),
    _realMenuItem(
      'fatteh_nuts_large',
      'hummus_ful',
      'فتة بالمكسرات كبير',
      'Large fatteh with nuts',
      2.75,
    ),
    _realMenuItem(
      'fries_plate_small',
      'hummus_ful',
      'صحن بطاطا صغير',
      'Small fries plate',
      0.75,
    ),
    _realMenuItem(
      'fries_plate_medium',
      'hummus_ful',
      'صحن بطاطا وسط',
      'Medium fries plate',
      1.50,
    ),
    _realMenuItem(
      'fries_plate_large',
      'hummus_ful',
      'صحن بطاطا كبير',
      'Large fries plate',
      2.00,
    ),
    _realMenuItem(
      'fried_mix_small',
      'hummus_ful',
      'صحن مقالي صغير',
      'Small fried mix plate',
      1.00,
    ),
    _realMenuItem(
      'fried_mix_medium',
      'hummus_ful',
      'صحن مقالي وسط',
      'Medium fried mix plate',
      1.50,
    ),
    _realMenuItem(
      'fried_mix_large',
      'hummus_ful',
      'صحن مقالي كبير',
      'Large fried mix plate',
      2.25,
    ),
    _realMenuItem(
      'hummus_meat_large',
      'hummus_ful',
      'حمص مع لحمة كبير',
      'Large hummus with meat',
      3.50,
    ),
    _realMenuItem(
      'hummus_liver_large',
      'hummus_ful',
      'حمص مع كبدة كبير',
      'Large hummus with liver',
      3.50,
    ),
    _realMenuItem('tea', 'drinks', 'شاي', 'Tea', 0.25),
    _realMenuItem('ameed_coffee', 'drinks', 'قهوة عميد', 'Ameed coffee', 0.60),
    _realMenuItem('espresso', 'drinks', 'اسبريسو', 'Espresso', 0.50),
    _realMenuItem('cappuccino', 'drinks', 'كاباتشينو', 'Cappuccino', 0.50),
    _realMenuItem(
      'nescafe_3in1',
      'drinks',
      'نسكافية 3 في 1',
      'Nescafe 3 in 1',
      0.50,
    ),
    _realMenuItem('mocha_cafe', 'drinks', 'موكا كافيه', 'Mocha cafe', 0.50),
    _realMenuItem(
      'hot_chocolate',
      'drinks',
      'شكولاتة بالحليب',
      'Milk chocolate drink',
      0.50,
    ),
    _realMenuItem(
      'cardamom_tea',
      'drinks',
      'شاي مع الهال',
      'Tea with cardamom',
      0.50,
    ),
    _realMenuItem(
      'caramel_cappuccino',
      'drinks',
      'كابتشينو كاراميل',
      'Caramel cappuccino',
      0.50,
    ),
    _realMenuItem('mojito', 'drinks', 'موهيتو', 'Mojito', 1.00),
    _realMenuItem('pm_small', 'drinks', 'بي ام صغير', 'Small BM drink', 0.35),
    _realMenuItem('pm_large', 'drinks', 'بي ام كبير', 'Large BM drink', 0.50),
    _realMenuItem('boom_boom', 'drinks', 'بوم بوم', 'Boom Boom', 0.75),
    _realMenuItem('soft_drink', 'drinks', 'مشروبات غازية', 'Soft drink', 0.35),
    _realMenuItem('chips', 'drinks', 'شبس', 'Chips', 0.40),
    _realMenuItem('ayran', 'drinks', 'عيران', 'Ayran', 0.50),
    _realMenuItem('water_cups', 'drinks', 'ماء كاسات', 'Water cups', 0.10),
    _realMenuItem('water_small', 'drinks', 'ماء صغير', 'Small water', 0.25),
    _realMenuItem('water_large', 'drinks', 'ماء كبير', 'Large water', 0.40),
    _realMenuItem(
      'sandwich_chicken_liver_regular',
      'sandwiches',
      'كبدة دجاج - حمام / عادي',
      'Chicken liver sandwich - regular bread',
      0.75,
    ),
    _realMenuItem(
      'sandwich_chicken_liver_sesame',
      'sandwiches',
      'كبدة دجاج - كعك بسمسم',
      'Chicken liver sandwich - sesame kaak',
      1.25,
    ),
    _realMenuItem(
      'sandwich_chicken_liver_french',
      'sandwiches',
      'كبدة دجاج - فرنسي',
      'Chicken liver sandwich - French bread',
      1.75,
    ),
    _realMenuItem(
      'sandwich_lamb_liver_regular',
      'sandwiches',
      'كبدة غنم - حمام / عادي',
      'Lamb liver sandwich - regular bread',
      0.85,
    ),
    _realMenuItem(
      'sandwich_lamb_liver_sesame',
      'sandwiches',
      'كبدة غنم - كعك بسمسم',
      'Lamb liver sandwich - sesame kaak',
      1.40,
    ),
    _realMenuItem(
      'sandwich_lamb_liver_french',
      'sandwiches',
      'كبدة غنم - فرنسي',
      'Lamb liver sandwich - French bread',
      1.85,
    ),
    _realMenuItem(
      'sandwich_turkey_cheese_regular',
      'sandwiches',
      'تركي مع جبنة - حمام / عادي',
      'Turkey and cheese sandwich - regular bread',
      1.15,
    ),
    _realMenuItem(
      'sandwich_turkey_cheese_sesame',
      'sandwiches',
      'تركي مع جبنة - كعك بسمسم',
      'Turkey and cheese sandwich - sesame kaak',
      1.50,
    ),
    _realMenuItem(
      'sandwich_turkey_cheese_french',
      'sandwiches',
      'تركي مع جبنة - فرنسي',
      'Turkey and cheese sandwich - French bread',
      1.85,
    ),
    _realMenuItem(
      'sandwich_potato_regular',
      'sandwiches',
      'بطاطا - حمام / عادي',
      'Potato sandwich - regular bread',
      0.50,
    ),
    _realMenuItem(
      'sandwich_potato_sesame',
      'sandwiches',
      'بطاطا - كعك بسمسم',
      'Potato sandwich - sesame kaak',
      0.95,
    ),
    _realMenuItem(
      'sandwich_potato_french',
      'sandwiches',
      'بطاطا - فرنسي',
      'Potato sandwich - French bread',
      1.25,
    ),
    _realMenuItem(
      'falafel_hummus_regular',
      'falafel',
      'سندويشة حمص عادي',
      'Hummus sandwich - regular',
      0.40,
    ),
    _realMenuItem(
      'falafel_hummus_kaak',
      'falafel',
      'سندويشة حمص كعك',
      'Hummus sandwich - kaak',
      0.75,
    ),
    _realMenuItem(
      'falafel_hummus_shrak',
      'falafel',
      'سندويشة حمص شراك',
      'Hummus sandwich - shrak',
      0.85,
    ),
    _realMenuItem(
      'falafel_sandwich_regular',
      'falafel',
      'فلافل عادي',
      'Falafel sandwich - regular',
      0.40,
    ),
    _realMenuItem(
      'falafel_sandwich_kaak',
      'falafel',
      'فلافل كعك',
      'Falafel sandwich - kaak',
      0.75,
    ),
    _realMenuItem(
      'falafel_pieces',
      'falafel',
      'فلافل 2 حبة',
      'Falafel - 2 pieces',
      0.05,
    ),
    _realMenuItem(
      'falafel_dough_kg',
      'falafel',
      'عجينة فلافل 1 كيلوجرام',
      'Falafel dough - 1 kg',
      1.50,
    ),
    _realMenuItem(
      'falafel_dough_half_kg',
      'falafel',
      'عجينة فلافل نص كيلوجرام',
      'Falafel dough - half kg',
      0.75,
    ),
    _realMenuItem(
      'pizza_vegetable_small',
      'pizza',
      'بيتزا خضار صغير',
      'Vegetable pizza - small',
      2.00,
    ),
    _realMenuItem(
      'pizza_vegetable_medium',
      'pizza',
      'بيتزا خضار وسط',
      'Vegetable pizza - medium',
      3.50,
    ),
    _realMenuItem(
      'pizza_vegetable_large',
      'pizza',
      'بيتزا خضار كبير',
      'Vegetable pizza - large',
      5.00,
    ),
    _realMenuItem(
      'pizza_margherita_small',
      'pizza',
      'بيتزا مارغريتا صغير',
      'Margherita pizza - small',
      2.00,
    ),
    _realMenuItem(
      'pizza_margherita_medium',
      'pizza',
      'بيتزا مارغريتا وسط',
      'Margherita pizza - medium',
      3.00,
    ),
    _realMenuItem(
      'pizza_margherita_large',
      'pizza',
      'بيتزا مارغريتا كبير',
      'Margherita pizza - large',
      4.00,
    ),
    _realMenuItem(
      'pizza_bbq_chicken_small',
      'pizza',
      'بيتزا دجاج باربكيو صغير',
      'BBQ chicken pizza - small',
      2.50,
    ),
    _realMenuItem(
      'pizza_bbq_chicken_medium',
      'pizza',
      'بيتزا دجاج باربكيو وسط',
      'BBQ chicken pizza - medium',
      3.50,
    ),
    _realMenuItem(
      'pizza_bbq_chicken_large',
      'pizza',
      'بيتزا دجاج باربكيو كبير',
      'BBQ chicken pizza - large',
      5.00,
    ),
    _realMenuItem(
      'pizza_alfredo_small',
      'pizza',
      'بيتزا الفريدو صغير',
      'Alfredo pizza - small',
      2.75,
    ),
    _realMenuItem(
      'pizza_alfredo_medium',
      'pizza',
      'بيتزا الفريدو وسط',
      'Alfredo pizza - medium',
      4.00,
      isFeatured: true,
    ),
    _realMenuItem(
      'pizza_alfredo_large',
      'pizza',
      'بيتزا الفريدو كبير',
      'Alfredo pizza - large',
      6.00,
    ),
    _realMenuItem(
      'snack_zinger_regular',
      'snacks',
      'زنجر - حمام',
      'Zinger snack - regular bread',
      1.00,
    ),
    _realMenuItem(
      'snack_zinger_sesame',
      'snacks',
      'زنجر - كعك بسمسم',
      'Zinger snack - sesame kaak',
      1.50,
    ),
    _realMenuItem(
      'snack_zinger_french',
      'snacks',
      'زنجر - فرنسي',
      'Zinger snack - French bread',
      2.00,
    ),
    _realMenuItem(
      'snack_zinger_meal',
      'snacks',
      'وجبة فرنسي زنجر',
      'French zinger meal',
      3.00,
    ),
    _realMenuItem(
      'snack_fajita_regular',
      'snacks',
      'فاهيتا - حمام',
      'Fajita snack - regular bread',
      0.85,
    ),
    _realMenuItem(
      'snack_fajita_sesame',
      'snacks',
      'فاهيتا - كعك بسمسم',
      'Fajita snack - sesame kaak',
      1.40,
    ),
    _realMenuItem(
      'snack_fajita_french',
      'snacks',
      'فاهيتا - فرنسي',
      'Fajita snack - French bread',
      2.00,
    ),
    _realMenuItem(
      'snack_fajita_meal',
      'snacks',
      'وجبة فرنسي فاهيتا',
      'French fajita meal',
      3.00,
    ),
    _realMenuItem(
      'snack_hotdog_regular',
      'snacks',
      'هوت دوج - حمام',
      'Hot dog snack - regular bread',
      0.75,
    ),
    _realMenuItem(
      'snack_hotdog_sesame',
      'snacks',
      'هوت دوج - كعك بسمسم',
      'Hot dog snack - sesame kaak',
      1.25,
    ),
    _realMenuItem(
      'snack_hotdog_french',
      'snacks',
      'هوت دوج - فرنسي',
      'Hot dog snack - French bread',
      1.75,
    ),
    _realMenuItem(
      'snack_hotdog_meal',
      'snacks',
      'وجبة فرنسي هوت دوج',
      'French hot dog meal',
      2.75,
    ),
    _realMenuItem(
      'manaqeesh_zaatar',
      'manaqeesh',
      'زعتر',
      'Zaatar manaqeesh',
      0.60,
    ),
    _realMenuItem(
      'manaqeesh_halloumi',
      'manaqeesh',
      'جبنة حلوم',
      'Halloumi manaqeesh',
      1.00,
    ),
    _realMenuItem(
      'manaqeesh_white_cheese',
      'manaqeesh',
      'جبنة بيضاء',
      'White cheese manaqeesh',
      0.80,
    ),
    _realMenuItem(
      'manaqeesh_cheese_zaatar',
      'manaqeesh',
      'جبنة وزعتر',
      'Cheese and zaatar manaqeesh',
      0.70,
    ),
    _realMenuItem(
      'manaqeesh_kashkaval',
      'manaqeesh',
      'قشقوان',
      'Kashkaval manaqeesh',
      0.85,
    ),
    _realMenuItem(
      'manaqeesh_mixed_cheese',
      'manaqeesh',
      'مكس أجبان',
      'Mixed cheese manaqeesh',
      0.85,
    ),
    _realMenuItem(
      'manaqeesh_muhammara_cheese',
      'manaqeesh',
      'محمرة وجبنة',
      'Muhammara and cheese manaqeesh',
      0.95,
    ),
    _realMenuItem(
      'manaqeesh_sfiha',
      'manaqeesh',
      'صفيحة',
      'Sfiha manaqeesh',
      1.25,
    ),
    _realMenuItem('manaqeesh_egg', 'manaqeesh', 'بيض', 'Egg manaqeesh', 0.60),
    _realMenuItem(
      'manaqeesh_egg_cheese',
      'manaqeesh',
      'بيض وجبنة',
      'Egg and cheese manaqeesh',
      0.75,
    ),
    _realMenuItem(
      'manaqeesh_salami_cheese',
      'manaqeesh',
      'سلامي وجبنة',
      'Salami and cheese manaqeesh',
      1.25,
    ),
    _realMenuItem(
      'pastry_mini_pizza',
      'pastries',
      'بيتزا ميني',
      'Mini pizza pastry',
      0.50,
    ),
    _realMenuItem(
      'pastry_mini_zaatar',
      'pastries',
      'زعتر ميني',
      'Mini zaatar pastry',
      0.25,
    ),
    _realMenuItem(
      'pastry_white_cheese',
      'pastries',
      'جبنة بيضا',
      'White cheese pastry',
      0.35,
    ),
    _realMenuItem(
      'pastry_yellow_cheese',
      'pastries',
      'جبنة صفرا',
      'Yellow cheese pastry',
      0.35,
    ),
    _realMenuItem(
      'pastry_mixed_cheese',
      'pastries',
      'مكس اجبان',
      'Mixed cheese pastry',
      0.35,
    ),
    _realMenuItem(
      'pastry_spinach',
      'pastries',
      'سبانخ',
      'Spinach pastry',
      0.35,
    ),
    _realMenuItem('pastry_potato', 'pastries', 'بطاطا', 'Potato pastry', 0.35),
    _realMenuItem(
      'pastry_zinger_hot',
      'pastries',
      'زنجر حار',
      'Spicy zinger pastry',
      0.50,
    ),
    _realMenuItem(
      'pastry_musakhan_roll',
      'pastries',
      'مسخن رول',
      'Musakhan roll',
      0.50,
    ),
    _realMenuItem(
      'pastry_kibbeh',
      'pastries',
      'كبة مقلية',
      'Fried kibbeh',
      0.50,
    ),
    _realMenuItem(
      'burger_beef_100',
      'burgers',
      'برغر لحم 100 غم',
      'Beef burger 100g',
      1.50,
    ),
    _realMenuItem(
      'burger_beef_150',
      'burgers',
      'برغر لحم 150 غم',
      'Beef burger 150g',
      1.85,
    ),
    _realMenuItem(
      'burger_beef_200',
      'burgers',
      'برغر لحم 200 غم',
      'Beef burger 200g',
      2.50,
    ),
    _realMenuItem(
      'burger_chicken_100',
      'burgers',
      'برغر دجاج 100 غم',
      'Chicken burger 100g',
      1.25,
    ),
    _realMenuItem(
      'burger_chicken_150',
      'burgers',
      'برغر دجاج 150 غم',
      'Chicken burger 150g',
      1.75,
    ),
    _realMenuItem(
      'burger_chicken_200',
      'burgers',
      'برغر دجاج 200 غم',
      'Chicken burger 200g',
      3.00,
    ),
    _realMenuItem(
      'burger_ayletna_100',
      'burgers',
      'برغر عيلتنا 100 غم',
      'Ayletna burger 100g',
      2.00,
    ),
    _realMenuItem(
      'burger_ayletna_150',
      'burgers',
      'برغر عيلتنا 150 غم',
      'Ayletna burger 150g',
      3.00,
      isFeatured: true,
    ),
    _realMenuItem(
      'burger_ayletna_200',
      'burgers',
      'برغر عيلتنا 200 غم',
      'Ayletna burger 200g',
      3.50,
    ),
  ];

  static List<ModelMenuItem> itemsForCategory(String categoryId) =>
      items.where((i) => i.categoryId == categoryId).toList();

  /// Default promo/combo/offer image when admin has not uploaded one yet.
  static String promoImageUrlFor(String promoId) {
    final linkedItemId = switch (promoId) {
      'combo_family_shawarma' => 'shawarma_meal_super',
      'combo_pizza_night' => 'pizza_alfredo_medium',
      'o1' => 'hummus_medium',
      'o2' => 'shawarma_meal_super',
      _ => null,
    };
    if (linkedItemId != null) {
      final item = itemById(linkedItemId);
      if (item?.primaryImageUrl != null) {
        return item!.primaryImageUrl!;
      }
    }
    return 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80';
  }

  static ModelMenuItem? itemById(String id) {
    for (final i in items) {
      if (i.id == id) {
        return i;
      }
    }
    return null;
  }

  static const activeOrders = <ModelOrderSummary>[
    ModelOrderSummary(
      id: '1042',
      orderType: OrderType.dineIn,
      customerLabel: 'طاولة ٧',
      totalJod: 18.5,
      depositJod: 0,
      statusKey: 'preparing',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: '1043',
      orderType: OrderType.takeaway,
      customerLabel: 'سفري #٢١',
      totalJod: 12.0,
      depositJod: 0,
      statusKey: 'ready',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: '1044',
      orderType: OrderType.platedDelivery,
      customerLabel: 'عميل — عبدون',
      totalJod: 30.0,
      depositJod: platedDeliveryDepositJod,
      statusKey: 'on_way',
      isPlated: true,
    ),
    ModelOrderSummary(
      id: '1045',
      orderType: OrderType.delivery,
      customerLabel: 'توصيل — الجبيهة',
      totalJod: 15.5,
      depositJod: 0,
      statusKey: 'pending',
      isPlated: false,
    ),
  ];

  static const orderHistory = <ModelOrderSummary>[
    ModelOrderSummary(
      id: '1038',
      orderType: OrderType.delivery,
      customerLabel: 'عميل — الشميساني',
      totalJod: 22.0,
      depositJod: 0,
      statusKey: 'delivered',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: '1035',
      orderType: OrderType.platedDelivery,
      customerLabel: 'عميل — تلاع العلي',
      totalJod: 35.0,
      depositJod: platedDeliveryDepositJod,
      statusKey: 'delivered',
      isPlated: true,
    ),
  ];

  static const cashierTransactions = <ModelOrderSummary>[
    ModelOrderSummary(
      id: 'CL-9842',
      orderType: OrderType.dineIn,
      customerLabel: '14:22',
      totalJod: 14.50,
      depositJod: 0,
      statusKey: 'paid',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: 'CL-9841',
      orderType: OrderType.takeaway,
      customerLabel: '14:15',
      totalJod: 6.75,
      depositJod: 0,
      statusKey: 'paid',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: 'CL-9839',
      orderType: OrderType.delivery,
      customerLabel: '13:58',
      totalJod: 12.0,
      depositJod: 0,
      statusKey: 'refunded',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: 'CL-9838',
      orderType: OrderType.dineIn,
      customerLabel: '13:45',
      totalJod: 22.40,
      depositJod: 0,
      statusKey: 'paid',
      isPlated: false,
    ),
    ModelOrderSummary(
      id: 'CL-9835',
      orderType: OrderType.takeaway,
      customerLabel: '13:10',
      totalJod: 5.20,
      depositJod: 0,
      statusKey: 'paid',
      isPlated: false,
    ),
  ];

  static const notifications = <ModelListEntry>[
    ModelListEntry(
      id: 'n1',
      titleAr: 'طلبك قيد التحضير',
      titleEn: 'Your order is preparing',
      subtitleAr: 'طلب #1042',
      subtitleEn: 'Order #1042',
    ),
    ModelListEntry(
      id: 'n2',
      titleAr: 'تذكير استرجاع الصينية',
      titleEn: 'Tray return reminder',
      subtitleAr: 'بعد ٦٠ دقيقة من التسليم',
      subtitleEn: '60 minutes after delivery',
    ),
  ];

  static const offers = <ModelListEntry>[
    ModelListEntry(
      id: 'o1',
      titleAr: 'خصم ١٠٪ على حمص وفول',
      titleEn: '10% off hummus and ful',
      subtitleAr: 'حتى نهاية الأسبوع',
      subtitleEn: 'Until end of week',
    ),
    ModelListEntry(
      id: 'o2',
      titleAr: 'وجبة عائلية',
      titleEn: 'Family combo',
      subtitleAr: 'شاورما + حمص + مشروبات',
      subtitleEn: 'Shawarma + hummus + drinks',
    ),
  ];

  static const rewards = <ModelListEntry>[
    ModelListEntry(
      id: 'r1',
      titleAr: 'حمص مجاني',
      titleEn: 'Free hummus',
      subtitleAr: '٢٠٠ نقطة',
      subtitleEn: '200 points',
    ),
    ModelListEntry(
      id: 'r2',
      titleAr: 'عصير مجاني',
      titleEn: 'Free juice',
      subtitleAr: '١٠٠ نقطة',
      subtitleEn: '100 points',
    ),
  ];

  static const addresses = <ModelListEntry>[
    ModelListEntry(
      id: 'a1',
      titleAr: 'المنزل — عبدون',
      titleEn: 'Home — Abdoun',
      subtitleAr: 'شارع الأمير حسن',
      subtitleEn: 'Prince Hassan St',
    ),
    ModelListEntry(
      id: 'a2',
      titleAr: 'العمل — الشميساني',
      titleEn: 'Work — Shmeisani',
      subtitleAr: 'مجمع الأعمال',
      subtitleEn: 'Business park',
    ),
  ];

  static const auditLogs = <ModelListEntry>[
    ModelListEntry(
      id: 'log1',
      titleAr: 'تعديل دور مستخدم',
      titleEn: 'User role changed',
      subtitleAr: 'المشغل — ٢٠٢٦/٠٥/٢٤',
      subtitleEn: 'Operator — 2026/05/24',
    ),
    ModelListEntry(
      id: 'log2',
      titleAr: 'توزيع بقشيش يومي',
      titleEn: 'Daily tip distribution',
      subtitleAr: 'مالك — ٢٠٢٦/٠٥/٢٣',
      subtitleEn: 'Owner — 2026/05/23',
    ),
  ];

  static const users = <ModelListEntry>[
    ModelListEntry(
      id: 'u1',
      titleAr: 'أحمد — كاشير',
      titleEn: 'Ahmad — Cashier',
      subtitleAr: 'معتمد',
      subtitleEn: 'Approved',
    ),
    ModelListEntry(
      id: 'u2',
      titleAr: 'سارة — مطبخ',
      titleEn: 'Sara — Kitchen',
      subtitleAr: 'معتمد',
      subtitleEn: 'Approved',
    ),
  ];

  static const adminTeamMembers = <ModelAdminTeamMember>[
    ModelAdminTeamMember(
      nameAr: 'إيلينا لوبيز',
      nameEn: 'Elena Lopez',
      roleAr: 'رئيسة المطبخ',
      roleEn: 'Kitchen Lead',
      email: 'elena@ayletna.jo',
      shiftAr: 'وردية مسائية',
      shiftEn: 'Evening shift',
      colorKey: 'success',
      iconKey: 'kitchen',
    ),
    ModelAdminTeamMember(
      nameAr: 'ماركوس ستيرلنغ',
      nameEn: 'Marcus Sterling',
      roleAr: 'مشرف الصندوق',
      roleEn: 'Cashier Supervisor',
      email: 'marcus@ayletna.jo',
      shiftAr: 'وردية صباحية',
      shiftEn: 'Morning shift',
      colorKey: 'orange',
      iconKey: 'cashier',
    ),
    ModelAdminTeamMember(
      nameAr: 'سارة أمين',
      nameEn: 'Sarah Amin',
      roleAr: 'منسقة التوصيل',
      roleEn: 'Delivery Coordinator',
      email: 'sarah@ayletna.jo',
      shiftAr: 'عند الطلب',
      shiftEn: 'On call',
      colorKey: 'delivery',
      iconKey: 'delivery',
      active: false,
    ),
    ModelAdminTeamMember(
      nameAr: 'ديفيد ويلسون',
      nameEn: 'David Wilson',
      roleAr: 'شيف مساعد',
      roleEn: 'Sous Chef',
      email: 'david@ayletna.jo',
      shiftAr: 'وردية مسائية',
      shiftEn: 'Evening shift',
      colorKey: 'plated',
      iconKey: 'kitchen',
    ),
    ModelAdminTeamMember(
      nameAr: 'ليندا حداد',
      nameEn: 'Linda Haddad',
      roleAr: 'مشرفة الفريق',
      roleEn: 'Team Supervisor',
      email: 'linda@ayletna.jo',
      shiftAr: 'وردية إدارية',
      shiftEn: 'Admin shift',
      colorKey: 'tip',
      iconKey: 'team',
    ),
  ];

  static const adminMenuItems = <ModelAdminMenuItem>[
    ModelAdminMenuItem(
      titleAr: 'وجبة شاورما سوبر',
      titleEn: 'Super shawarma meal',
      subtitleAr: 'شاورما مع بطاطا ومخلل حسب القائمة القديمة',
      subtitleEn: 'Shawarma meal with fries and pickles from the legacy menu',
      priceLabel: '2.75',
      typeKey: 'dineIn',
      stockKey: 'inStock',
      iconKey: 'ramen',
    ),
    ModelAdminMenuItem(
      titleAr: 'بيتزا الفريدو وسط',
      titleEn: 'Medium Alfredo pizza',
      subtitleAr: 'بيتزا الفريدو بحجم وسط',
      subtitleEn: 'Medium Alfredo pizza from the real menu',
      priceLabel: '4.00',
      typeKey: 'takeaway',
      stockKey: 'lowStock',
      iconKey: 'burger',
    ),
    ModelAdminMenuItem(
      titleAr: 'برغر عيلتنا 150 غم',
      titleEn: 'Ayletna burger 150g',
      subtitleAr: 'برغر عيلتنا لحم بلدي',
      subtitleEn: 'Ayletna local beef burger',
      priceLabel: '3.00',
      typeKey: 'delivery',
      stockKey: 'outOfStock',
      iconKey: 'burger',
      active: false,
    ),
  ];

  static const adminPlateAssets = <ModelAdminPlateAsset>[
    ModelAdminPlateAsset(
      titleAr: 'صينية كبيرة',
      titleEn: 'Large Tray',
      sku: 'TRAY-LG-001',
      badgeKey: 'plated',
      priceJod: 42,
      stock: 42,
      circulating: 118,
      painterKey: 'tray',
    ),
    ModelAdminPlateAsset(
      titleAr: 'وعاء سيراميك',
      titleEn: 'Ceramic Bowl',
      sku: 'BOWL-CR-002',
      badgeKey: 'dineIn',
      priceJod: 18.50,
      stock: 215,
      circulating: 482,
      painterKey: 'bowl',
    ),
    ModelAdminPlateAsset(
      titleAr: 'طبق مقبلات',
      titleEn: 'Mezze Plate',
      sku: 'MEZZE-PL-003',
      badgeKey: 'takeaway',
      priceJod: 12,
      stock: 156,
      circulating: 290,
      painterKey: 'mezze',
    ),
  ];

  static const adminBreakageReports = <ModelAdminBreakageReport>[
    ModelAdminBreakageReport(
      titleAr: 'كسر وعاء سيراميك',
      titleEn: 'Ceramic bowl breakage',
      metaAr: 'فرع عبدون - وردية العشاء',
      metaEn: 'Abdoun branch - dinner shift',
      lossJod: -74,
      timeAr: 'اليوم 08:12',
      timeEn: 'Today 08:12',
    ),
    ModelAdminBreakageReport(
      titleAr: 'تلف طبق مقبلات',
      titleEn: 'Mezze plate damage',
      metaAr: 'طلب توصيل #8821',
      metaEn: 'Delivery order #8821',
      lossJod: -24,
      timeAr: 'أمس 17:30',
      timeEn: 'Yesterday 17:30',
    ),
  ];

  static const adminTipDistributionRows = <ModelAdminTipDistributionRow>[
    ModelAdminTipDistributionRow(
      initials: 'MS',
      name: 'Marcus Sterling',
      orderId: '#8829',
      role: 'Dine-in',
      hours: 8.0,
      tipShareJod: 176.72,
    ),
    ModelAdminTipDistributionRow(
      initials: 'EL',
      name: 'Elena Lopez',
      orderId: '#4485',
      role: 'Plated',
      hours: 7.5,
      tipShareJod: 165.63,
    ),
    ModelAdminTipDistributionRow(
      initials: 'JK',
      name: 'Jordan Kim',
      orderId: '#1103',
      role: 'Takeaway',
      hours: 9.0,
      tipShareJod: 198.00,
    ),
    ModelAdminTipDistributionRow(
      initials: 'DW',
      name: 'Dawid Wilson',
      orderId: '#5540',
      role: 'Delivery',
      hours: 6.0,
      tipShareJod: 132.54,
    ),
  ];

  static const staffOnShift = <ModelListEntry>[
    ModelListEntry(
      id: 's1',
      titleAr: 'جوليان د.',
      titleEn: 'Julian D.',
      subtitleAr: 'كاشير أمامي',
      subtitleEn: 'Front cashier',
    ),
    ModelListEntry(
      id: 's2',
      titleAr: 'ماريا ل.',
      titleEn: 'Maria L.',
      subtitleAr: 'شيف مساعد',
      subtitleEn: 'Sous chef',
    ),
    ModelListEntry(
      id: 's3',
      titleAr: 'تامر ر.',
      titleEn: 'Tamer R.',
      subtitleAr: 'مندوب توصيل',
      subtitleEn: 'Delivery crew',
    ),
    ModelListEntry(
      id: 's4',
      titleAr: 'سامر م.',
      titleEn: 'Samer M.',
      subtitleAr: 'مساعد صالة',
      subtitleEn: 'Runner',
    ),
  ];

  static const staffShiftDetails = <ModelStaffShiftDetail>[
    ModelStaffShiftDetail(
      eyebrowAr: 'الدور',
      eyebrowEn: 'Role',
      valueAr: 'رئيس الطهاة',
      valueEn: 'Lead Chef',
      iconKey: 'role',
      colorKey: 'primary',
    ),
    ModelStaffShiftDetail(
      eyebrowAr: 'وقت الوردية',
      eyebrowEn: 'Scheduled time',
      valueAr: '10:00 صباحا - 6:00 مساء',
      valueEn: '10:00 AM - 6:00 PM',
      iconKey: 'schedule',
      colorKey: 'primary',
    ),
    ModelStaffShiftDetail(
      eyebrowAr: 'الأرباح المتوقعة',
      eyebrowEn: 'Expected earnings',
      valueAr: '36.50 د.أ + إكراميات',
      valueEn: '36.50 JOD + tips',
      iconKey: 'earnings',
      colorKey: 'success',
    ),
    ModelStaffShiftDetail(
      eyebrowAr: 'الموقع',
      eyebrowEn: 'Location',
      valueAr: 'المطبخ الرئيسي',
      valueEn: 'Main Kitchen',
      iconKey: 'location',
      colorKey: 'primary',
    ),
  ];

  static const staffTipShifts = <ModelStaffTipShift>[
    ModelStaffTipShift(
      titleAr: 'وردية الإفطار',
      titleEn: 'Breakfast Shift',
      timeAr: '7:00 صباحا - 11:00 صباحا',
      timeEn: '7:00 AM - 11:00 AM',
      amountLabelAr: '18.40 د.أ',
      amountLabelEn: '18.40 JOD',
      iconKey: 'breakfast',
    ),
    ModelStaffTipShift(
      titleAr: 'ذروة الغداء',
      titleEn: 'Lunch Rush',
      timeAr: '12:00 مساء - 4:00 مساء',
      timeEn: '12:00 PM - 4:00 PM',
      amountLabelAr: '24.10 د.أ',
      amountLabelEn: '24.10 JOD',
      iconKey: 'lunch',
    ),
  ];

  static const staffTipTransactions = <ModelStaffTipTransaction>[
    ModelStaffTipTransaction(
      tagAr: 'توصيل',
      tagEn: 'Delivery',
      metaAr: 'طلب توصيل #8821',
      metaEn: 'Delivery order #8821',
      amountLabelAr: '+4.25 د.أ',
      amountLabelEn: '+4.25 JOD',
      timeAr: 'قبل 18 دقيقة',
      timeEn: '18 mins ago',
      iconKey: 'delivery',
      colorKey: 'plated',
    ),
    ModelStaffTipTransaction(
      tagAr: 'داخل المطعم',
      tagEn: 'Dine-in',
      metaAr: 'طاولة 12',
      metaEn: 'Table 12',
      amountLabelAr: '+7.50 د.أ',
      amountLabelEn: '+7.50 JOD',
      timeAr: 'قبل 44 دقيقة',
      timeEn: '44 mins ago',
      iconKey: 'dineIn',
      colorKey: 'dineIn',
    ),
    ModelStaffTipTransaction(
      tagAr: 'سفري',
      tagEn: 'Takeaway',
      metaAr: 'طلب سفري #4572',
      metaEn: 'Takeaway order #4572',
      amountLabelAr: '+2.00 د.أ',
      amountLabelEn: '+2.00 JOD',
      timeAr: 'قبل ساعة',
      timeEn: '1 hour ago',
      iconKey: 'takeaway',
      colorKey: 'takeaway',
    ),
  ];

  static const staffTipHistory = <ModelStaffTipHistory>[
    ModelStaffTipHistory(
      weekKey: 'this',
      dateAr: 'الأربعاء',
      dateEn: 'Wed',
      titleAr: 'خدمة العشاء',
      titleEn: 'Dinner Service',
      timeAr: '5:00 مساء - 11:00 مساء',
      timeEn: '5:00 PM - 11:00 PM',
      hoursAr: '6 ساعات',
      hoursEn: '6 hours',
      tipsAr: '31.20 د.أ',
      tipsEn: '31.20 JOD',
      colorKey: 'success',
    ),
    ModelStaffTipHistory(
      weekKey: 'this',
      dateAr: 'الجمعة',
      dateEn: 'Fri',
      titleAr: 'وردية البرنش',
      titleEn: 'Brunch Shift',
      timeAr: '9:00 صباحا - 3:00 مساء',
      timeEn: '9:00 AM - 3:00 PM',
      hoursAr: '6 ساعات',
      hoursEn: '6 hours',
      tipsAr: '26.75 د.أ',
      tipsEn: '26.75 JOD',
      colorKey: 'delivery',
    ),
    ModelStaffTipHistory(
      weekKey: 'last',
      dateAr: 'الاثنين',
      dateEn: 'Mon',
      titleAr: 'وردية الإغلاق',
      titleEn: 'Closing Shift',
      timeAr: '4:00 مساء - 12:00 صباحا',
      timeEn: '4:00 PM - 12:00 AM',
      hoursAr: '8 ساعات',
      hoursEn: '8 hours',
      tipsAr: '42.10 د.أ',
      tipsEn: '42.10 JOD',
      colorKey: 'plated',
    ),
    ModelStaffTipHistory(
      weekKey: 'last',
      dateAr: 'السبت',
      dateEn: 'Sat',
      titleAr: 'وردية مزدوجة',
      titleEn: 'Double Shift',
      timeAr: '10:00 صباحا - 10:00 مساء',
      timeEn: '10:00 AM - 10:00 PM',
      hoursAr: '12 ساعة',
      hoursEn: '12 hours',
      tipsAr: '64.90 د.أ',
      tipsEn: '64.90 JOD',
      colorKey: 'orange',
      badgeAr: 'إضافي',
      badgeEn: 'Overtime',
    ),
  ];

  static const plates = <ModelListEntry>[
    ModelListEntry(
      id: 'p1',
      titleAr: 'صينية كبيرة',
      titleEn: 'Large tray',
      subtitleAr: 'عربون ١٠ د.أ',
      subtitleEn: 'Deposit 10 JOD',
    ),
    ModelListEntry(
      id: 'p2',
      titleAr: 'صينية متوسطة',
      titleEn: 'Medium tray',
      subtitleAr: 'عربون ٣ د.أ',
      subtitleEn: 'Deposit 3 JOD',
    ),
  ];

  static const reports = <ModelListEntry>[
    ModelListEntry(id: 'rep1', titleAr: 'مبيعات يومية', titleEn: 'Daily sales'),
    ModelListEntry(id: 'rep2', titleAr: 'البقشيش', titleEn: 'Tips report'),
    ModelListEntry(id: 'rep3', titleAr: 'كسر صواني', titleEn: 'Tray breakage'),
  ];

  static ModelCartLine lineFromItem(ModelMenuItem item, {int qty = 1}) {
    return ModelCartLine(
      itemId: item.id,
      nameAr: item.nameAr,
      nameEn: item.nameEn,
      unitPriceJod: item.priceJod,
      quantity: qty,
    );
  }
}
