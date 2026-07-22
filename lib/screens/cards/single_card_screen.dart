import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/my_container.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';
import 'package:nectar_app/models/nectar_card.dart';
import 'package:nectar_app/components/layout/my_app_bar.dart';
import 'package:nectar_app/components/layout/my_drawer.dart';

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
    return Scaffold(
        drawer: MyDrawer(),
        appBar: MyAppBar(
          title: 'View Card',
        ),
        body: MyContainer(
          alignment: Alignment.center,
          child: MyRegularText(widget.nectarCard.firstName),
        ));
  }
}
