import 'package:flutter/material.dart';
import 'package:nectar_app/components/cards/single_card_list_preview.dart';
import 'package:nectar_app/models/nectar_card.dart';

/// Display a scrollable list of Nectar Card previews.
/// Tapping on each preview will navigate to the card's details view.
class CardsListView extends StatelessWidget {
  final List<NectarCard> cardsList;
  final bool isOwnCard;

  const CardsListView(
      {super.key, this.isOwnCard = false, required this.cardsList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          for (NectarCard card in cardsList)
            SingleCardListPreview(nectarCard: card, isOwnCard: isOwnCard)
        ],
      ),
    );
  }
}
