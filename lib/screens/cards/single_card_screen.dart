import 'package:flutter/material.dart';
import 'package:nectar_app/helpers/ui_helper.dart';
import 'package:open_mail/open_mail.dart';

import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/edit_single_card_screen.dart';

/// Shows a single Nectar card
///
/// Separates info by personal, company, social, and address.
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
  @override
  Widget build(BuildContext context) {
    bool hasName = (widget.nectarCard.personalInfo['firstName'] != '' &&
        widget.nectarCard.personalInfo['lastName'] != '');
    bool hasCompanyInfo = widget.nectarCard.companyInfo.values
        .any((property) => property.isNotEmpty);
    bool hasSocialInfo = widget.nectarCard.socialMedia.values
        .any((property) => property.isNotEmpty);
    bool hasAddressInfo = widget.nectarCard.addressInfo.values
        .any((property) => property.isNotEmpty);

    // Use open_mail to launch mail app
    // Set "to" as email from the DB, don't set other fields
    Future<void> launchEmailApp() async {
      try {
        OpenMailAppResult result = await OpenMail.composeNewEmailInMailApp(
            nativePickerTitle:
                'Send mail to ${widget.nectarCard.personalInfo['email']!}',
            emailContent: EmailContent(
              to: [widget.nectarCard.personalInfo['email']!],
            ));
        if (context.mounted && !result.didOpen && !result.canOpen) {
          nectarSnackBar(context, 'Unable to launch mail app.');
        }
      } catch (e) {
        if (context.mounted) nectarSnackBar(context, e.toString());
      }
    }

    return NectarScaffoldContainer(
        title: 'Card Details',
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
        child: ListView(children: <Widget>[
          NectarContainer(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NectarLargeText(
                  widget.nectarCard.mainName,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                if (widget.nectarCard.shortDescription != '')
                  NectarRegularText(widget.nectarCard.shortDescription),
                if (hasName)
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (hasName)
                  NectarLargeText(
                    'Personal',
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
                        onTap: launchEmailApp,
                        child: NectarRegularText(
                            widget.nectarCard.personalInfo['email']!),
                      ),
                    ],
                  ),
                if (widget.nectarCard.personalInfo['phone'] != '')
                  Row(spacing: 5, children: [
                    Icon(
                      Icons.phone_sharp,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 24,
                    ),
                    NectarRegularText(widget.nectarCard.personalInfo['phone']!),
                  ]),
                if (hasCompanyInfo)
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (hasCompanyInfo)
                  NectarLargeText(
                    'Company',
                  ),
                if (widget.nectarCard.companyInfo['companyName'] != '')
                  NectarRegularText(
                      '${widget.nectarCard.companyInfo['companyName']}'),
                if (widget.nectarCard.companyInfo['businessType'] != '')
                  NectarRegularText(
                      '${widget.nectarCard.companyInfo['businessType']}'),
                if (widget.nectarCard.companyInfo['role'] != '')
                  NectarRegularText(
                      'Role: ${widget.nectarCard.companyInfo['role']}'),
                if (widget.nectarCard.companyInfo['department'] != '')
                  NectarRegularText(
                      'Department: ${widget.nectarCard.companyInfo['department']}'),
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
                  NectarRegularText(
                      '${widget.nectarCard.socialMedia['website']}'),
                if (widget.nectarCard.socialMedia['linkedin'] != '')
                  NectarRegularText(
                      'linkedin.com/${widget.nectarCard.socialMedia['linkedin']}'),
                if (widget.nectarCard.socialMedia['twitter'] != '')
                  NectarRegularText(
                      'x.com/${widget.nectarCard.socialMedia['twitter']}'),
                if (widget.nectarCard.socialMedia['instagram'] != '')
                  NectarRegularText(
                      'instagram.com/${widget.nectarCard.socialMedia['instagram']}'),
                if (widget.nectarCard.socialMedia['facebook'] != '')
                  NectarRegularText(
                      'facebook.com/${widget.nectarCard.socialMedia['facebook']}'),
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
              ],
            ),
          ),
        ]));
  }
}
