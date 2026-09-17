import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/edit_single_card_screen.dart';

/// Shows a single Nectar card
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
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  NectarLargeText(
                    'Personal',
                  ),
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  NectarRegularText(
                      'Full name: ${widget.nectarCard.personalInfo['firstName']} ${widget.nectarCard.personalInfo['lastName']}'),
                if (widget.nectarCard.personalInfo['email'] != '')
                  NectarRegularText(
                      'Email: ${widget.nectarCard.personalInfo['email']}'),
                if (widget.nectarCard.personalInfo['phone'] != '')
                  NectarRegularText(
                      'Phone: ${widget.nectarCard.personalInfo['phone']}'),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
