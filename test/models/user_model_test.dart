import 'package:flutter_test/flutter_test.dart';
import 'package:nectar_app/models/business_card.dart';
import 'package:nectar_app/models/user.dart';

BusinessCard _card(String cardId, String ownerUserId) {
  return BusinessCard(
    cardId: cardId,
    ownerUserId: ownerUserId,
    firstName: 'Jane',
    lastName: 'Doe',
    phone: '555-0101',
    email: 'jane@nectar.app',
    job: 'Engineer',
    company: 'Nectar',
    website: 'nectar.app',
    address: '123 Main St',
    city: 'San Francisco',
    state: 'CA',
    country: 'USA',
    postal: '94105',
  );
}

void main() {
  test('user auto-generates id when omitted', () {
    final user = User(
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      password: 'password123',
    );

    expect(user.userId, isNotEmpty);
    expect(user.userId.startsWith('user_'), isTrue);
  });

  test('business card auto-generates id when omitted', () {
    final card = BusinessCard(
      ownerUserId: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      phone: '555-0101',
      email: 'jane@nectar.app',
      job: 'Engineer',
      company: 'Nectar',
      website: 'nectar.app',
      address: '123 Main St',
      city: 'San Francisco',
      state: 'CA',
      country: 'USA',
      postal: '94105',
    );

    expect(card.cardId, isNotEmpty);
    expect(card.cardId.startsWith('card_'), isTrue);
  });

  test('user can own up to 3 business cards', () {
    final user = User(
      userId: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      password: 'password123',
      phone: '555-0101',
      job: 'Engineer',
      company: 'Nectar',
      website: 'nectar.app',
      address: '123 Main St',
      city: 'San Francisco',
      state: 'CA',
      country: 'USA',
      postal: '94105',
    );

    final updated = user
        .addBusinessCard()
        .addBusinessCard()
        .addBusinessCard();

    expect(updated.businessCards.length, 3);
  });

  test('adding a 4th card throws StateError', () {
    final user = User(
      userId: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      password: 'password123',
      businessCards: <BusinessCard>[
        _card('card_1', 'user_1'),
        _card('card_2', 'user_1'),
        _card('card_3', 'user_1'),
      ],
    );

    expect(
      () => user.addBusinessCard(),
      throwsStateError,
    );
  });

  test('addBusinessCard uses canonical values from user when omitted', () {
    final user = User(
      userId: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      password: 'password123',
      phone: '555-0101',
      job: 'Engineer',
      company: 'Nectar',
      website: 'nectar.app',
      address: '123 Main St',
      city: 'San Francisco',
      state: 'CA',
      country: 'USA',
      postal: '94105',
    );

    final updated = user.addBusinessCard();

    final createdCard = updated.businessCards.first;
    expect(createdCard.firstName, 'Jane');
    expect(createdCard.lastName, 'Doe');
    expect(createdCard.ownerUserId, 'user_1');
    expect(createdCard.email, 'jane@nectar.app');
    expect(createdCard.phone, '555-0101');
  });

  test('removeBusinessCardById removes matching card', () {
    final user = User(
      userId: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      password: 'password123',
      businessCards: <BusinessCard>[_card('card_1', 'user_1')],
    );

    final updated = user.removeBusinessCardById('card_1');

    expect(updated.businessCards, isEmpty);
  });
}
