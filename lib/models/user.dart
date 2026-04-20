import 'package:nectar_app/helpers/id_generator.dart';
import 'package:nectar_app/models/business_card.dart';

/// An user in Nectar.
///
/// Has 0 to 3 business cards.
/// Has personal infos as well as auth info.
///
class User {
  // An user can only created at most 3 cards for now.
  static const int maxBusinessCards = 3;

  // Required params upon init.
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  // Optional params to be added later or upon init.
  final String phone;
  final String website;
  final String job;
  final String company;
  final String city;
  final String state;
  final String country;
  final String address;
  final String postal;
  final String avatarUrl;

  // List of business cards this user owns.
  final List<BusinessCard> businessCards;

  // Auto generated params
  final String userId;
  final bool isActive;
  final DateTime createdAt;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.phone = '',
    this.avatarUrl = '',
    this.website = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.company = '',
    this.job = '',
    this.postal = '',
    this.businessCards = const <BusinessCard>[],
    this.isActive = true,
    DateTime? createdAt,
    String? userId,
  })  : userId = userId ?? generatePrefixedId('user'),
        createdAt = createdAt ?? DateTime.now() {
    // check for max 3 business cards before initing the user.
    if (businessCards.length > maxBusinessCards) {
      throw ArgumentError(
        'You can only add a maximum of $maxBusinessCards business cards.',
      );
    }
  }

  /// Returns the user's display name as "FirstName LastName".
  String get fullName => '$firstName $lastName';

  /// Adds a new business card.
  /// Pull info from user info if any field is omitted from input here.
  User addBusinessCard({
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
  }) {
    if (businessCards.length >= maxBusinessCards) {
      throw StateError(
        'Cannot add more than $maxBusinessCards business cards per user.',
      );
    }

    final BusinessCard cardToAdd = BusinessCard(
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
      ownerUserId: userId,
    );
    return copyWith(
      businessCards: <BusinessCard>[...businessCards, cardToAdd],
    );
  }

  // Remove a card with cardId [targetCardId].
  User removeBusinessCardById(String targetCardId) {
    return copyWith(
      businessCards:
          businessCards.where((card) => card.cardId != targetCardId).toList(),
    );
  }

  User copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    List<BusinessCard>? businessCards,
  }) {
    return User(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      businessCards: businessCards ?? this.businessCards,
    );
  }
}
