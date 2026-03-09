class BusinessCard {
  const BusinessCard({
    required this.fullName,
    required this.jobTitle,
    required this.companyName,
    required this.phoneNumber,
    required this.email,
    required this.website,
    required this.addressLine1,
    required this.city,
    required this.stateOrRegion,
    required this.postalCode,
    required this.country,
    this.tagline,
    this.linkedInUrl,
    this.xHandle,
  });

  final String fullName;
  final String jobTitle;
  final String companyName;
  final String phoneNumber;
  final String email;
  final String website;
  final String addressLine1;
  final String city;
  final String stateOrRegion;
  final String postalCode;
  final String country;
  final String? tagline;
  final String? linkedInUrl;
  final String? xHandle;

  BusinessCard copyWith({
    String? fullName,
    String? jobTitle,
    String? companyName,
    String? phoneNumber,
    String? email,
    String? website,
    String? addressLine1,
    String? city,
    String? stateOrRegion,
    String? postalCode,
    String? country,
    String? tagline,
    String? linkedInUrl,
    String? xHandle,
  }) {
    return BusinessCard(
      fullName: fullName ?? this.fullName,
      jobTitle: jobTitle ?? this.jobTitle,
      companyName: companyName ?? this.companyName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      website: website ?? this.website,
      addressLine1: addressLine1 ?? this.addressLine1,
      city: city ?? this.city,
      stateOrRegion: stateOrRegion ?? this.stateOrRegion,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
      tagline: tagline ?? this.tagline,
      linkedInUrl: linkedInUrl ?? this.linkedInUrl,
      xHandle: xHandle ?? this.xHandle,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'jobTitle': jobTitle,
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'email': email,
      'website': website,
      'addressLine1': addressLine1,
      'city': city,
      'stateOrRegion': stateOrRegion,
      'postalCode': postalCode,
      'country': country,
      'tagline': tagline,
      'linkedInUrl': linkedInUrl,
      'xHandle': xHandle,
    };
  }

  factory BusinessCard.fromJson(Map<String, dynamic> json) {
    return BusinessCard(
      fullName: json['fullName'] as String? ?? '',
      jobTitle: json['jobTitle'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String? ?? '',
      website: json['website'] as String? ?? '',
      addressLine1: json['addressLine1'] as String? ?? '',
      city: json['city'] as String? ?? '',
      stateOrRegion: json['stateOrRegion'] as String? ?? '',
      postalCode: json['postalCode'] as String? ?? '',
      country: json['country'] as String? ?? '',
      tagline: json['tagline'] as String?,
      linkedInUrl: json['linkedInUrl'] as String?,
      xHandle: json['xHandle'] as String?,
    );
  }
}
