import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/text/my_large_text.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/screens/cards/single_card_screen.dart';

class SingleCardListPreview extends StatelessWidget {
  final NectarCard nectarCard;
  const SingleCardListPreview({super.key, required this.nectarCard});

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                MyLargeText('${nectarCard.firstName} ${nectarCard.lastName}'),
                MyLargeText(nectarCard.company),
                MyLargeText(nectarCard.phone),
                MyLargeText(nectarCard.email),
              ],
            )),
      ),
    );
  }
}
