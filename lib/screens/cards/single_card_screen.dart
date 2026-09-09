import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/layout/my_scaffold_container.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/helpers/nav_helper.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/edit_single_card_screen.dart';

/// Shows a single Nectar card
class SingleCardScreen extends StatefulWidget {
  final NectarCard nectarCard;
  const SingleCardScreen({super.key, required this.nectarCard});

  @override
  State<StatefulWidget> createState() => _SingleCardScreenState();
}

class _SingleCardScreenState extends State<SingleCardScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffoldContainer(
        title: 'Card Details',
        appBarActions: [
          IconButton(
              onPressed: () => {
                    myNavigate(
                        context,
                        EditSingleCardScreen(
                          nectarCard: widget.nectarCard,
                        ))
                  },
              icon: Icon(Icons.edit_sharp))
        ],
        child: ListView(children: <Widget>[
          MyContainer(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyLargeText(
                  widget.nectarCard.mainName,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                if (widget.nectarCard.shortDescription != '')
                  MyRegularText(widget.nectarCard.shortDescription),
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  Divider(
                    height: 5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  MyLargeText(
                    'Personal',
                  ),
                if (widget.nectarCard.personalInfo['firstName'] != '' &&
                    widget.nectarCard.personalInfo['lastName'] != '')
                  MyRegularText(
                      'Full name: ${widget.nectarCard.personalInfo['firstName']} ${widget.nectarCard.personalInfo['lastName']}'),
                if (widget.nectarCard.personalInfo['email'] != '')
                  MyRegularText(
                      'Email: ${widget.nectarCard.personalInfo['email']}'),
                if (widget.nectarCard.personalInfo['phone'] != '')
                  MyRegularText(
                      'Phone: ${widget.nectarCard.personalInfo['phone']}'),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                MyLargeText(
                  'Company',
                ),
                MyRegularText(
                    '${widget.nectarCard.companyInfo['companyName']}'),
                MyRegularText(
                    '${widget.nectarCard.companyInfo['businessType']}'),
                if (widget.nectarCard.companyInfo['role'] != '')
                  MyRegularText(
                      'Role: ${widget.nectarCard.companyInfo['role']}'),
                if (widget.nectarCard.companyInfo['department'] != '')
                  MyRegularText(
                      'Department: ${widget.nectarCard.companyInfo['department']}'),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                MyLargeText(
                  'Social Media',
                ),
                if (widget.nectarCard.socialMedia['website'] != '')
                  MyRegularText('${widget.nectarCard.socialMedia['website']}'),
                if (widget.nectarCard.socialMedia['linkedin'] != '')
                  MyRegularText(
                      'linkedin.com/${widget.nectarCard.socialMedia['linkedin']}'),
                if (widget.nectarCard.socialMedia['twitter'] != '')
                  MyRegularText(
                      'x.com/${widget.nectarCard.socialMedia['twitter']}'),
                if (widget.nectarCard.socialMedia['instagram'] != '')
                  MyRegularText(
                      'instagram.com/${widget.nectarCard.socialMedia['instagram']}'),
                if (widget.nectarCard.socialMedia['facebook'] != '')
                  MyRegularText(
                      'facebook.com/${widget.nectarCard.socialMedia['facebook']}'),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                MyLargeText(
                  'Location',
                ),
                if (widget.nectarCard.addressInfo['street'] != '')
                  MyRegularText(
                      'Street: ${widget.nectarCard.addressInfo['street']}'),
                if (widget.nectarCard.addressInfo['city'] != '')
                  MyRegularText(
                      'City: ${widget.nectarCard.addressInfo['city']}'),
                if (widget.nectarCard.addressInfo['state'] != '')
                  MyRegularText(
                      'State/Province: ${widget.nectarCard.addressInfo['state']}'),
                if (widget.nectarCard.addressInfo['country'] != '')
                  MyRegularText(
                      'Country: ${widget.nectarCard.addressInfo['country']}'),
                if (widget.nectarCard.addressInfo['postalCode'] != '')
                  MyRegularText(
                      'Postal: ${widget.nectarCard.addressInfo['postalCode']}'),
              ],
            ),
          ),
        ]));
  }
}
