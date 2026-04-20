import 'package:nectar_app/helpers/id_generator.dart';

/// A single business card.
///
/// Must be owned by an user - ownerUserId.
///
class BusinessCard {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;

  final String job;
  final String company;
  final String website;

  final String address;
  final String city;
  final String country;
  final String state;
  final String postal;

  final String cardId;
  final String ownerUserId;

  /// Make a new business card for user ownerUserId.
  /// No optional fields. The user's add business function copies fields from user's info if needed.
  /// It's assumed only an user can add a business card.
  BusinessCard({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.job,
    required this.company,
    required this.website,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postal,
    required this.ownerUserId,
    String? cardId,
  }) : cardId = cardId ?? generatePrefixedId('card');

  BusinessCard copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? job,
    String? company,
    String? website,
    String? address,
    String? city,
    String? state,
    String? country,
    String? postal,
    String? cardId,
    String? ownerUserId,
  }) {
    return BusinessCard(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        job: job ?? this.job,
        company: company ?? this.company,
        website: website ?? this.website,
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        postal: postal ?? this.postal,
        cardId: cardId ?? this.cardId,
        ownerUserId: ownerUserId ?? this.ownerUserId);
  }
}
