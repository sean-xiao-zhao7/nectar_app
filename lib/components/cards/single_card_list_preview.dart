import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/single_card_screen.dart';

// A gesture detector representing a single Nectar Card.
//
// Showing limited info, meant to be a part of a list of previews in scrollable view.
// The preview always starts with the [mainName] property,
// other properties could be empty.
class SingleCardListPreview extends StatelessWidget {
  final NectarCard nectarCard;
  const SingleCardListPreview({super.key, required this.nectarCard});

  @override
  Widget build(BuildContext context) {
    // Decide which important info to show on preview
    // Some info might be empty - if a person or a company
    Widget infoBlock = Column(
      children: [
        if (nectarCard.companyInfo['companyName'] != '')
          MyRegularText(nectarCard.companyInfo['companyName']!),
        if (nectarCard.companyInfo['businessType'] != '')
          MyRegularText(nectarCard.companyInfo['businessType']!),
        if (nectarCard.personalInfo['firstName'] != '')
          MyRegularText(
              "${nectarCard.personalInfo['firstName']!} ${nectarCard.personalInfo['lastName']!}"),
      ],
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (context) => SingleCardScreen(nectarCard: nectarCard),
          ),
        );
      },
      child: MyContainer(
        margin: EdgeInsets.only(bottom: 20),
        child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                MyLargeText(
                  nectarCard.mainName,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Divider(
                  height: 5,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(child: infoBlock)
              ],
            )),
      ),
    );
  }
}
