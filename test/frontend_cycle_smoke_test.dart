import 'package:ayletna_restaurant_app/data/mockup/mockup_catalog.dart';
import 'package:ayletna_restaurant_app/data/models/model_blog_post.dart';
import 'package:ayletna_restaurant_app/data/models/model_kitchen_ready_order.dart';
import 'package:ayletna_restaurant_app/providers/admin_catalog_providers.dart';
import 'package:ayletna_restaurant_app/providers/cart_providers.dart';
import 'package:ayletna_restaurant_app/providers/checkout_draft_providers.dart';
import 'package:ayletna_restaurant_app/providers/customer_action_providers.dart';
import 'package:ayletna_restaurant_app/providers/kitchen_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_blog_providers.dart';
import 'package:ayletna_restaurant_app/providers/marketing_push_providers.dart';
import 'package:ayletna_restaurant_app/providers/order_placement_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_chat_queue_providers.dart';
import 'package:ayletna_restaurant_app/providers/support_session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Automated smoke for frontend cycle checklist S1–S5 (in-memory providers).
void main() {
  test('S1 cart placeOrder clears cart and sets tracking ids', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final item = MockupCatalog.items.first;
    container.read(cartProvider.notifier).addItem(item);
    expect(container.read(cartProvider), isNotEmpty);

    container
        .read(checkoutDraftProvider.notifier)
        .setFulfillment(CheckoutFulfillment.takeaway);

    final result = await container.read(placeOrderProvider.notifier).submit();
    expect(result, isNotNull);
    expect(container.read(cartProvider), isEmpty);
    expect(container.read(placedOrderIdProvider), result!.orderId);
    expect(container.read(activeTrackingOrderIdProvider), result.orderId);
  });

  test('S2 offer inactive until setActive true is visible', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final offers = container.read(adminCatalogProvider).resolvedOffers;
    expect(offers, isNotEmpty);
    final offer = offers.first;

    container
        .read(adminCatalogProvider.notifier)
        .setOfferActive(offer.id, active: false);
    expect(
      container.read(visibleOffersProvider).any((o) => o.id == offer.id),
      isFalse,
    );

    container
        .read(adminCatalogProvider.notifier)
        .setOfferActive(offer.id, active: true);
    expect(
      container.read(visibleOffersProvider).any((o) => o.id == offer.id),
      isTrue,
    );
  });

  test('S3 blog publish and push schedule reach customer surfaces', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(marketingBlogProvider.notifier).addDraft(
      titleAr: 'مسودة',
      titleEn: 'Draft smoke',
    );
    final drafts = container.read(marketingBlogProvider);
    final draft = drafts.firstWhere((p) => p.titleEn == 'Draft smoke');
    expect(draft.status, BlogPostStatus.draft);
    expect(
      container.read(publishedBlogPostsProvider).any((p) => p.id == draft.id),
      isFalse,
    );

    container.read(marketingBlogProvider.notifier).toggleStatus(draft.id);
    expect(
      container.read(publishedBlogPostsProvider).any((p) => p.id == draft.id),
      isTrue,
    );

    final before = container.read(visibleCustomerNotificationsProvider).length;
    container.read(pushCampaignsProvider.notifier).addDraft(
      titleAr: 'إشعار',
      titleEn: 'Push smoke',
    );
    final campaign = container
        .read(pushCampaignsProvider)
        .firstWhere((c) => c.titleEn == 'Push smoke');
    final scheduled = container
        .read(pushCampaignsProvider.notifier)
        .schedule(campaign.id);
    expect(scheduled, isTrue);
    expect(
      container.read(visibleCustomerNotificationsProvider).length,
      greaterThan(before),
    );
  });

  test('S4 accept chat shrinks queue and creates ticket thread', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final queueBefore = container.read(supportChatQueueProvider);
    expect(queueBefore, isNotEmpty);
    final entry = queueBefore.first;
    final ticketsBefore =
        container.read(supportTicketsProvider).tickets.length;

    final accepted = container
        .read(supportChatQueueProvider.notifier)
        .acceptChat(entry.id);
    expect(accepted, isTrue);
    expect(
      container.read(supportChatQueueProvider).any((e) => e.id == entry.id),
      isFalse,
    );

    final ticket = container.read(supportTicketsProvider.notifier).createTicket(
      titleAr: entry.topicAr,
      titleEn: entry.topicEn,
      bodyAr: 'محادثة',
      bodyEn: 'Live chat',
    );
    expect(ticket, isNotNull);
    container.read(supportChatProvider.notifier).linkTicket(ticket!.id);
    expect(
      container.read(supportTicketsProvider).tickets.length,
      ticketsBefore + 1,
    );
    expect(container.read(supportChatProvider).linkedTicketId, ticket.id);
  });

  test('S5 cashier ticket appears on kitchen board', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final before = container.read(kitchenBoardProvider).readyOrders.length;
    container.read(kitchenBoardProvider.notifier).receiveCashierTicket(
      orderId: 'SMK-1',
      destinationEn: 'Counter',
      destinationAr: 'الكاشير',
      itemsEn: const [ModelKitchenReadyItem(quantity: 1, name: 'Meal')],
      itemsAr: const [ModelKitchenReadyItem(quantity: 1, name: 'وجبة')],
      typeKey: 'takeaway',
    );
    final after = container.read(kitchenBoardProvider).readyOrders;
    expect(after.length, before + 1);
    expect(after.any((t) => t.id == 'SMK-1'), isTrue);
  });
}
