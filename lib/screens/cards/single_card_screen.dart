import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/layout/my_scaffold_container.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';

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
        title: 'View Card',
        child: ListView(children: <Widget>[
          MyRegularText('Card details:'),
          MyContainer(
            child: MyRegularText(widget.nectarCard.firstName),
          ),
        ]));
  }
}
