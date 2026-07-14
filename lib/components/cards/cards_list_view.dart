import 'package:flutter/material.dart';
import 'package:nectar_app/components/cards/single_card_list_preview.dart';
import 'package:nectar_app/models/nectar_card.dart';

/// Display a scrollable list of Nectar Card previews.
/// Tapping on each preview will navigate to the card's details view.
class CardsListView extends StatelessWidget {
  final List<NectarCard> cardsList;

  const CardsListView({super.key, required this.cardsList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
          itemCount: cardsList.length,
          itemBuilder: (BuildContext context, int index) {
            return SingleCardListPreview(nectarCard: cardsList[index]);
          }),
    );
  }
}
