import 'package:nectar_app/helpers/id_generator.dart';
import 'package:nectar_app/models/nectar_card.dart';

/// An user in Nectar.
///
/// Has 0 to 3 business cards.
/// Has personal infos as well as auth info.
///
class NectarUser {
  final String userId;
  final bool isActive;
  final DateTime createdAt;
  static const int maxNectarCards = 3;
  final List<NectarCard> nectarCards;

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

  NectarUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password = '',
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
    this.nectarCards = const <NectarCard>[],
    this.isActive = true,
    DateTime? createdAt,
    String? userId,
  })  : userId = userId ?? generatePrefixedId('user'),
        createdAt = createdAt ?? DateTime.now() {
    if (nectarCards.length > maxNectarCards) {
      throw ArgumentError(
        'You can only add a maximum of $maxNectarCards business cards.',
      );
    }
  }

  /// Returns the user's display name as "FirstName LastName".
  String get fullName => '$firstName $lastName';

  /// Adds a new business card.
  /// Pull info from user info if any field is omitted from input here.
  NectarUser addNectarCard(
      {required String mainName,
      String? firstName,
      String? lastName,
      String? phone,
      String? email,
      String? job,
      String? company,
      String? role,
      String? businessType,
      String? department,
      String? address,
      String? city,
      String? state,
      String? country,
      String? postal,
      String? website,
      String? linkedin,
      String? instagram,
      String? facebook,
      String? twitter}) {
    if (nectarCards.length >= maxNectarCards) {
      throw StateError(
        'Cannot add more than $maxNectarCards business cards per user.',
      );
    }

    final NectarCard cardToAdd =
        NectarCard(ownerUserId: userId, mainName: mainName, personalInfo: {
      'firstName': firstName ?? this.firstName,
      'lastName': lastName ?? this.lastName,
      'phone': phone ?? this.phone,
      'email': email ?? this.email
    }, companyInfo: {
      'job': job ?? this.job,
      'company': company ?? this.company,
      'businessType': businessType ?? '',
      'role': role ?? '',
      'department': department ?? ''
    }, addressInfo: {
      'address': address ?? this.address,
      'city': city ?? this.city,
      'state': state ?? this.state,
      'country': country ?? this.country,
      'postal': postal ?? this.postal,
    }, socialMedia: {
      'website': website ?? this.website,
      'linkedin': linkedin ?? '',
      'twitter': twitter ?? '',
      'instagram': instagram ?? '',
      'facebook': facebook ?? ''
    });
    return copyWith(
      nectarCards: <NectarCard>[...nectarCards, cardToAdd],
    );
  }

  // Remove a card with cardId [targetCardId].
  NectarUser removeNectarCardById(String targetCardId) {
    return copyWith(
      nectarCards:
          nectarCards.where((card) => card.cardId != targetCardId).toList(),
    );
  }

  NectarUser copyWith({
    String? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
    String? avatarUrl,
    bool? isActive,
    DateTime? createdAt,
    List<NectarCard>? nectarCards,
  }) {
    return NectarUser(
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      nectarCards: nectarCards ?? this.nectarCards,
    );
  }
}
