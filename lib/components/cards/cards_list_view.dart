import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_container.dart';

import 'package:nectar_app/components/text/my_regular_text.dart';
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
            return MyContainer(
              child: MyRegularText('Card: ${cardsList[index].firstName}'),
            );
          }),
    );
  }
}
