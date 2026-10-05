import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/text/nectar_large_text.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/single_card_screen.dart';

// A gesture detector representing a single Nectar Card.
//
// Showing limited info, meant to be a part of a list of previews in scrollable view.
// The preview always starts with the [mainName] property,
// other properties could be empty.
class SingleCardListPreview extends StatelessWidget {
  final NectarCard nectarCard;
  final bool isOwnCard;
  const SingleCardListPreview(
      {super.key, this.isOwnCard = false, required this.nectarCard});

  @override
  Widget build(BuildContext context) {
    // Decide which important info to show on preview
    // Some info might be empty - if a person or a company
    Widget infoBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if (nectarCard.companyInfo['businessType'] != '')
          Row(spacing: 10, children: [
            Icon(
              Icons.hive,
              color: Theme.of(context).colorScheme.primary,
              size: 34,
            ),
            Expanded(
                child:
                    NectarRegularText(nectarCard.companyInfo['businessType']!))
          ]),
        if (nectarCard.companyInfo['companyName'] != '')
          Row(spacing: 10, children: [
            Icon(
              Icons.storefront_sharp,
              color: Theme.of(context).colorScheme.primary,
              size: 34,
            ),
            Expanded(
                child:
                    NectarRegularText(nectarCard.companyInfo['companyName']!))
          ]),
        if (nectarCard.personalInfo['firstName'] != '')
          Row(spacing: 10, children: [
            Icon(
              Icons.contact_page,
              color: Theme.of(context).colorScheme.primary,
              size: 34,
            ),
            Expanded(
              child: NectarRegularText(
                  "${nectarCard.personalInfo['firstName']!} ${nectarCard.personalInfo['lastName']!}"),
            )
          ]),
        if (nectarCard.addressInfo['city'] != '')
          Row(spacing: 10, children: [
            Icon(
              Icons.location_pin,
              color: Theme.of(context).colorScheme.primary,
              size: 34,
            ),
            Expanded(
              child: NectarRegularText(nectarCard.addressInfo['city']!),
            )
          ]),
      ],
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => SingleCardScreen(
              nectarCard: nectarCard,
              isOwnCard: isOwnCard,
            ),
          ),
        );
      },
      child: NectarContainer(
        margin: EdgeInsets.only(bottom: 20),
        child: SizedBox(
            height: 210,
            child: Column(
              spacing: 10,
              children: [
                NectarLargeText(
                  nectarCard.mainName,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                infoBlock
              ],
            )),
      ),
    );
  }
}
