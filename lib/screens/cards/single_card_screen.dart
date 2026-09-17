import 'package:flutter/material.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:open_mail/open_mail.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/helpers/ui_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/edit_single_card_screen.dart';

/// Show a single Nectar card
///
/// Separate info by personal, company, social, and address.
/// If one category of info is empty, omit showing that block.
/// Links on tap will launch external apps.
/// Edit screen access is on top right.
class SingleCardScreen extends StatefulWidget {
  final NectarCard nectarCard;
  final bool isOwnCard;
  const SingleCardScreen(
      {super.key, this.isOwnCard = false, required this.nectarCard});

  @override
  State<StatefulWidget> createState() => _SingleCardScreenState();
}

class _SingleCardScreenState extends State<SingleCardScreen> {
  // Use open_mail to launch mail app
  // Set "to" as email from the DB, don't set other fields
  Future<bool> _launchEmailApp() async {
    try {
      OpenMailAppResult result = await OpenMail.composeNewEmailInMailApp(
          nativePickerTitle:
              'Send mail to ${widget.nectarCard.personalInfo['email']!}',
          emailContent: EmailContent(
            to: [widget.nectarCard.personalInfo['email']!],
          ));
      if (mounted && !result.didOpen && !result.canOpen) {
        nectarSnackBar(context, 'Unable to launch mail app.');
        return false;
      }

      return true;
    } catch (e) {
      if (mounted) nectarSnackBar(context, e.toString());
    }
    return false;
  }

  // Use url_launcher to launch phone app
  Future<bool> _launchPhoneApp() async {
    try {
      bool result = await launchUrl(
          Uri(scheme: 'tel', path: widget.nectarCard.personalInfo['phone']!));
      if (mounted && !result) {
        nectarSnackBar(context, 'Unable to launch phone app.');
        return false;
      }

      return true;
    } catch (e) {
      if (mounted) nectarSnackBar(context, e.toString());
    }
    return false;
  }

  // Use url_launcher to launch social media link
  Future<bool> _launchSocialLink(String link) async {
    try {
      bool result = await launchUrl(Uri.parse(link));
      if (mounted && !result) {
        nectarSnackBar(context, 'Unable to launch social media.');
        return false;
      }

      return true;
    } catch (e) {
      if (mounted) nectarSnackBar(context, e.toString());
    }
    return false;
  }

  // Launch contacts app to add this card
  Future<void> _addToContacts() async {
    try {
      bool permit = await _permitContacts();
      if (permit) {
        await FlutterContacts.create(Contact(
            name: Name(
                first: widget.nectarCard.personalInfo['firstName'],
                last: widget.nectarCard.personalInfo['lastName']),
            emails: [Email(address: widget.nectarCard.personalInfo['email']!)],
            phones: [Phone(number: widget.nectarCard.personalInfo['phone']!)]));
        if (mounted) nectarSnackBar(context, 'Added to your contacts.');
      }
    } catch (error) {
      if (mounted) nectarSnackBar(context, error.toString());
    }
  }

  // Get permission to add to contacts
  Future<bool> _permitContacts() async {
    try {
      final permit = await FlutterContacts.permissions.request(
        PermissionType.write,
      );
      if (permit != PermissionStatus.granted &&
          permit != PermissionStatus.limited) {
        if (mounted) nectarSnackBar(context, 'Contacts access not permitted.');
        return false;
      }

      return true;
    } catch (error) {
      if (mounted) nectarSnackBar(context, error.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool hasName = (widget.nectarCard.personalInfo['firstName'] != '' ||
        widget.nectarCard.personalInfo['lastName'] != '');
    bool hasPersonalInfo = widget.nectarCard.personalInfo.values
        .any((property) => property.isNotEmpty);
    bool hasSocialInfo = widget.nectarCard.socialMedia.values
        .any((property) => property.isNotEmpty);
    bool hasAddressInfo = widget.nectarCard.addressInfo.values
        .any((property) => property.isNotEmpty);
    // bool hasCompanyInfo = widget.nectarCard.companyInfo.values
    //     .any((property) => property.isNotEmpty);

    return NectarScaffoldContainer(
        title: 'Card Details',
        appBarLead: IconButton(
          icon: const Icon(Icons.arrow_back_sharp),
          onPressed: () => Navigator.pop(context),
        ),
        appBarActions: [
          IconButton(
              onPressed: () => {
                    myNavigate(
                        context,
                        EditSingleCardScreen(
                          nectarCard: widget.nectarCard,
                          isOwnCard: widget.isOwnCard,
                        ))
                  },
              icon: Icon(Icons.edit_sharp))
        ],
        child: NectarContainer(
            child: ListView(children: <Widget>[
          Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NectarLargeText(
                  widget.nectarCard.mainName,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                if (widget.nectarCard.shortDescription != '')
                  NectarRegularText(widget.nectarCard.shortDescription),
                if (hasPersonalInfo)
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (hasPersonalInfo)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NectarLargeText(
                        'Personal',
                      ),
                      if (hasName)
                        GestureDetector(
                          onTap: _addToContacts,
                          child: Icon(
                            Icons.bookmark_add_sharp,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 24,
                          ),
                        ),
                    ],
                  ),
                if (hasName)
                  Row(spacing: 5, children: [
                    Icon(
                      Icons.person_sharp,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 24,
                    ),
                    (widget.nectarCard.personalInfo['lastName'] == '')
                        ? NectarRegularText(
                            '${widget.nectarCard.personalInfo['firstName']}')
                        : NectarRegularText(
                            '${widget.nectarCard.personalInfo['firstName']} ${widget.nectarCard.personalInfo['lastName']}'),
                  ]),
                if (widget.nectarCard.personalInfo['email'] != '')
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.email_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 24,
                      ),
                      GestureDetector(
                        onTap: _launchEmailApp,
                        child: NectarRegularText(
                            widget.nectarCard.personalInfo['email']!),
                      ),
                    ],
                  ),
                if (widget.nectarCard.personalInfo['phone'] != '')
                  GestureDetector(
                    onTap: _launchPhoneApp,
                    child: Row(spacing: 5, children: [
                      Icon(
                        Icons.phone_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 24,
                      ),
                      NectarRegularText(
                          widget.nectarCard.personalInfo['phone']!),
                    ]),
                  ),
                if (hasSocialInfo)
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (hasSocialInfo)
                  NectarLargeText(
                    'Social Media',
                  ),
                if (widget.nectarCard.socialMedia['website'] != '')
                  GestureDetector(
                    onTap: () {
                      _launchSocialLink(
                          widget.nectarCard.socialMedia['website']!);
                    },
                    child: Row(
                      spacing: 5,
                      children: [
                        Icon(
                          Icons.link_sharp,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        ),
                        NectarRegularText(
                            '${widget.nectarCard.socialMedia['website']}'),
                      ],
                    ),
                  ),
                if (widget.nectarCard.socialMedia['linkedin'] != '')
                  GestureDetector(
                    onTap: () {
                      _launchSocialLink(
                          'https://linkedin.com/${widget.nectarCard.socialMedia['linkedin']}');
                    },
                    child: NectarRegularText(
                        'linkedin.com/${widget.nectarCard.socialMedia['linkedin']}'),
                  ),
                if (widget.nectarCard.socialMedia['twitter'] != '')
                  GestureDetector(
                    onTap: () {
                      _launchSocialLink(
                          'https://x.com/${widget.nectarCard.socialMedia['twitter']}');
                    },
                    child: NectarRegularText(
                        'x.com/${widget.nectarCard.socialMedia['twitter']}'),
                  ),
                if (widget.nectarCard.socialMedia['instagram'] != '')
                  GestureDetector(
                    onTap: () {
                      _launchSocialLink(
                          'https://instagram.com/${widget.nectarCard.socialMedia['instagram']}');
                    },
                    child: NectarRegularText(
                        'instagram.com/${widget.nectarCard.socialMedia['instagram']}'),
                  ),
                if (widget.nectarCard.socialMedia['facebook'] != '')
                  GestureDetector(
                    onTap: () {
                      _launchSocialLink(
                          'https://facebook.com/${widget.nectarCard.socialMedia['facebook']}');
                    },
                    child: NectarRegularText(
                        'facebook.com/${widget.nectarCard.socialMedia['facebook']}'),
                  ),
                if (hasAddressInfo)
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (hasAddressInfo)
                  NectarLargeText(
                    'Location',
                  ),
                if (widget.nectarCard.addressInfo['street'] != '')
                  NectarRegularText(
                      'Street: ${widget.nectarCard.addressInfo['street']}'),
                if (widget.nectarCard.addressInfo['city'] != '')
                  NectarRegularText(
                      'City: ${widget.nectarCard.addressInfo['city']}'),
                if (widget.nectarCard.addressInfo['state'] != '')
                  NectarRegularText(
                      'State/Province: ${widget.nectarCard.addressInfo['state']}'),
                if (widget.nectarCard.addressInfo['country'] != '')
                  NectarRegularText(
                      'Country: ${widget.nectarCard.addressInfo['country']}'),
                if (widget.nectarCard.addressInfo['postalCode'] != '')
                  NectarRegularText(
                      'Postal: ${widget.nectarCard.addressInfo['postalCode']}'),
                // if (hasCompanyInfo)
                //   Divider(
                //     height: 5,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                // if (hasCompanyInfo)
                //   NectarLargeText(
                //     'Details',
                //   ),
                // if (widget.nectarCard.companyInfo['companyName'] != '')
                //   NectarRegularText(
                //       '${widget.nectarCard.companyInfo['companyName']}'),
                // if (widget.nectarCard.companyInfo['businessType'] != '')
                //   NectarRegularText(
                //       '${widget.nectarCard.companyInfo['businessType']}'),
                // if (widget.nectarCard.companyInfo['role'] != '')
                //   Text.rich(TextSpan(children: [
                //     TextSpan(
                //         text: 'Role: ',
                //         style: TextStyle(fontWeight: FontWeight.bold)),
                //     TextSpan(text: widget.nectarCard.companyInfo['role']!),
                //   ])),
                // if (widget.nectarCard.companyInfo['department'] != '')
                //   NectarRegularText(
                //       'Department: ${widget.nectarCard.companyInfo['department']}'),
              ])
        ])));
  }
}
