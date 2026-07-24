import 'package:nectar_app/helpers/id_generator.dart';

/// A single Nectar card.
///
/// A new card only needs first and last names, which should be inherited from user model.
/// Must be owned by an user - ownerUserId.
/// In database, all cards are under the user's firebaseAuth id.
///
/// Schema in firebase:
///
// {
//   "person_name": "iri",
//   "company": {
//     "company_name": "Sony Music Artists Inc.",
//     "business_type": "Music Production / Performing Arts",
//     "role": "Singer-Songwriter / Recording Artist",
//     "department": ""
//   },
//   "short_description": "Japanese singer-songwriter known for her soulful vocals and signature blend of hip-hop, R&B, and pop music.",
//   "address": {
//     "street": "",
//     "city": "",
//     "state": "Kanagawa Prefecture",
//     "postal_code": "",
//     "country": "Japan"
//   },
//   "phone": "",
//   "email": "",
//   "social_media": {
//     "website": "https://www.iriofficial.com/",
//     "linkedin": "",
//     "twitter": "03iritaama",
//     "instagram": "i.gram.iri",
//     "facebook": "iri.official.japan"
//   }
// }

class NectarCard {
  final String cardId;
  final String ownerUserId;

  // required params for a new card
  final String firstName;
  final String lastName;

  // optional params
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

  /// Make a new business card for user ownerUserId.
  /// No optional fields. The user's add business function copies fields from user's info if needed.
  /// It's assumed only an user can add a business card.
  NectarCard({
    String? cardId,
    required this.ownerUserId,
    required this.firstName,
    required this.lastName,
    this.phone = '',
    this.email = '',
    this.job = '',
    this.company = '',
    this.website = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.postal = '',
  }) : cardId = cardId ?? generatePrefixedId('card');

  NectarCard copyWith({
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
    return NectarCard(
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
