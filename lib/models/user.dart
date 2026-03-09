import 'package:nectar_app/models/business_card.dart';

/// Represents an app user profile and the business cards they own (0 to 3).
class User {
  static const int maxBusinessCards = 3;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final List<BusinessCard> businessCards;

  /// Creates a user and validates ownership/card-count constraints.
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
    this.isActive = true,
    DateTime? createdAt,
    this.businessCards = const <BusinessCard>[],
  }) : createdAt = createdAt ?? DateTime.now() {
    if (businessCards.length > maxBusinessCards) {
      throw ArgumentError(
        'You can only add a maximum of $maxBusinessCards business cards.',
      );
    }

    final ownsAllCards = businessCards.every((card) => card.ownerUserId == id);
    if (!ownsAllCards) {
      throw ArgumentError(
        'Trying to add a business card that does not belong to you!',
      );
    }
  }

  /// Returns the user's display name as "FirstName LastName".
  String get fullName => '$firstName $lastName';

  /// Adds a business card if ownership matches and the 3-card limit is not exceeded.
  User addBusinessCard(BusinessCard card) {
    if (card.ownerUserId != id) {
      throw ArgumentError(
        'Trying to add a business card that does not belong to you! Id: ${card.id}',
      );
    }
    if (businessCards.length >= maxBusinessCards) {
      throw StateError(
        'Cannot add more than $maxBusinessCards business cards per user.',
      );
    }
    return copyWith(
      businessCards: <BusinessCard>[...businessCards, card],
    );
  }

  /// Returns a new [User] with the business card matching [cardId] removed.
  User removeBusinessCardById(String cardId) {
    return copyWith(
      businessCards: businessCards.where((card) => card.id != cardId).toList(),
    );
  }

  /// Serializes the user and owned business cards into a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'businessCards': businessCards.map((card) => card.toJson()).toList(),
    };
  }

  /// Builds a [User] from JSON and re-validates ownership/card constraints.
  factory User.fromJson(Map<String, dynamic> json) {
    final cardJson = (json['businessCards'] as List<dynamic>? ?? <dynamic>[])
        .cast<Map<String, dynamic>>();

    return User(
      id: json['id'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
      businessCards:
          cardJson.map((card) => BusinessCard.fromJson(card)).toList(),
    );
  }

  /// Returns a new [User] with selected fields replaced.
  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    List<BusinessCard>? businessCards,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      businessCards: businessCards ?? this.businessCards,
    );
  }
}
