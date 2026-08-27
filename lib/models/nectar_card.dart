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
//   'main_name:': 'iri',
//   'short_description': 'Japanese singer-songwriter known for her soulful vocals and signature blend of hip-hop, R&B, and pop music.',
//   'personal_info': {
//     'first_name': '',
//     'last_name': '',
//     'phone': '',
//     'email': '',
//   },
//   'company_info': {
//     'company_name': 'Sony Music Artists Inc.',
//     'business_type': 'Music Production / Performing Arts',
//     'role': 'Singer-Songwriter / Recording Artist',
//     'department': ''
//   },
//   'address_info': {
//     'street': '',
//     'city': '',
//     'state': 'Kanagawa Prefecture',
//     'postal_code': '',
//     'country': 'Japan'
//   },
//   'social_media': {
//     'website': 'https://www.iriofficial.com/',
//     'linkedin': '',
//     'twitter': '03iritaama',
//     'instagram': 'i.gram.iri',
//     'facebook': 'iri.official.japan'
//   }
// }

class NectarCard {
  final String cardId;
  final String ownerUserId;

  final String mainName;
  final String shortDescription;

  final Map<String, String> personalInfo = {
    'firstName': '',
    'lastName': '',
    'phone': '',
    'email': ''
  };
  final Map<String, String> companyInfo = {
    'companyName': '',
    'businessType': '',
    'role': '',
    'department': ''
  };
  final Map<String, String> addressInfo = {
    'street': '',
    'city': '',
    'state': '',
    'postalCode': '',
    'country': ''
  };
  final Map<String, String> socialMedia = {
    'website': '',
    'linkedin': '',
    'twitter': '',
    'instagram': '',
    'facebook': ''
  };

  NectarCard(
      {String? cardId,
      required this.ownerUserId,
      required this.mainName,
      this.shortDescription = '',
      personalInfo,
      companyInfo,
      addressInfo,
      socialMedia})
      : cardId = cardId ?? generatePrefixedId('card') {
    this.personalInfo['firstName'] = personalInfo['firstName'];
    this.personalInfo['lastName'] = personalInfo['lastName'];
    this.personalInfo['phone'] = personalInfo['phone'];
    this.personalInfo['email'] = personalInfo['email'];

    this.companyInfo['companyName'] = personalInfo['companyName'];
    this.companyInfo['businessType'] = personalInfo['businessType'];
    this.companyInfo['role'] = personalInfo['role'];
    this.companyInfo['department'] = personalInfo['department'];

    this.addressInfo['street'] = personalInfo['street'];
    this.addressInfo['city'] = personalInfo['city'];
    this.addressInfo['state'] = personalInfo['state'];
    this.addressInfo['country'] = personalInfo['country'];
    this.addressInfo['postalCode'] = personalInfo['postalCode'];

    this.socialMedia['website'] = personalInfo['website'];
    this.socialMedia['linkedin'] = personalInfo['linkedin'];
    this.socialMedia['twitter'] = personalInfo['twitter'];
    this.socialMedia['instagram'] = personalInfo['instagram'];
    this.socialMedia['facebook'] = personalInfo['facebook'];
  }
}
