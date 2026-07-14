import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';

class SingleCardListPreview extends StatelessWidget {
  final NectarCard nectarCard;
  const SingleCardListPreview({super.key, required this.nectarCard});

  @override
  Widget build(BuildContext context) {
    return MyContainer(
      child: SizedBox(
          height: 160,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              MyRegularText('First name: ${nectarCard.firstName}'),
              MyRegularText('Last name: ${nectarCard.lastName}'),
            ],
          )),
    );
  }
}
