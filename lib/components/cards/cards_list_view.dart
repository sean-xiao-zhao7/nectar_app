import 'package:flutter/material.dart';

import 'package:nectar_app/components/cards/single_card_list_preview.dart';
import 'package:nectar_app/components/text/nectar_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';

/// Display a scrollable list of Nectar Card previews.
/// Tapping on each preview will navigate to the card's details view.
class CardsListView extends StatelessWidget {
  final List<NectarCard> cardsList;
  final bool isOwnCard;
  final String? topText;

  const CardsListView(
      {super.key,
      this.isOwnCard = false,
      this.topText,
      required this.cardsList});

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewChildren = [
      for (NectarCard card in cardsList)
        SingleCardListPreview(nectarCard: card, isOwnCard: isOwnCard)
    ];

    if (topText != null) {
      listViewChildren.insert(
        0,
        Container(
            margin: EdgeInsets.all(20), child: NectarRegularText(topText!)),
      );
    }

    return Expanded(
      child: ListView(
        children: listViewChildren,
      ),
    );
  }
}
