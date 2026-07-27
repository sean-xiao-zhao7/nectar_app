import 'package:flutter/material.dart';

import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/layout/my_scaffold_container.dart';
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
        title: 'View Card',
        appBarActions: [
          IconButton(
              onPressed: () => {
                    myNavigate(
                        context,
                        EditSingleCardScreen(
                          nectarCard: widget.nectarCard,
                        ))
                  },
              icon: Icon(Icons.edit))
        ],
        child: ListView(children: <Widget>[
          MyRegularText('Card details:'),
          SizedBox(
            height: 20,
          ),
          MyContainer(
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyRegularText('First name: ${widget.nectarCard.firstName}'),
                MyRegularText('Last name: ${widget.nectarCard.lastName}'),
                MyRegularText('Email: ${widget.nectarCard.email}'),
                MyRegularText('Role: ${widget.nectarCard.job}'),
                MyRegularText('Company: ${widget.nectarCard.company}'),
              ],
            ),
          ),
        ]));
  }
}
