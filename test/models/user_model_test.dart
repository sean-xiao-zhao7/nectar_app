import 'package:flutter_test/flutter_test.dart';
import 'package:nectar_app/models/business_card.dart';
import 'package:nectar_app/models/user.dart';

BusinessCard _card(String id, String ownerUserId) {
  return BusinessCard(
    id: id,
    ownerUserId: ownerUserId,
    fullName: 'Jane Doe',
    jobTitle: 'Engineer',
    companyName: 'Nectar',
    phoneNumber: '555-0101',
    email: 'jane@nectar.app',
    website: 'nectar.app',
    addressLine1: '123 Main St',
    city: 'San Francisco',
    stateOrRegion: 'CA',
    postalCode: '94105',
    country: 'USA',
  );
}

void main() {
  test('user can own up to 3 business cards', () {
    final user = User(
      id: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
    );

    final updated = user
        .addBusinessCard(_card('card_1', 'user_1'))
        .addBusinessCard(_card('card_2', 'user_1'))
        .addBusinessCard(_card('card_3', 'user_1'));

    expect(updated.businessCards.length, 3);
  });

  test('adding a 4th card throws StateError', () {
    final user = User(
      id: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      businessCards: <BusinessCard>[
        _card('card_1', 'user_1'),
        _card('card_2', 'user_1'),
        _card('card_3', 'user_1'),
      ],
    );

    expect(
      () => user.addBusinessCard(_card('card_4', 'user_1')),
      throwsStateError,
    );
  });

  test('adding card with a different owner throws ArgumentError', () {
    final user = User(
      id: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
    );

    expect(
      () => user.addBusinessCard(_card('card_1', 'user_2')),
      throwsArgumentError,
    );
  });

  test('user json includes business cards', () {
    final user = User(
      id: 'user_1',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'jane@nectar.app',
      businessCards: <BusinessCard>[_card('card_1', 'user_1')],
    );

    final roundTrip = User.fromJson(user.toJson());

    expect(roundTrip.id, 'user_1');
    expect(roundTrip.businessCards.length, 1);
    expect(roundTrip.businessCards.first.ownerUserId, 'user_1');
  });
}
