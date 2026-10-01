import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';

class HelpHomeScreen extends StatelessWidget {
  const HelpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NectarScaffoldContainer(
      title: 'Nectar Help',
      appBarLead: IconButton(
        icon: const Icon(
          Icons.arrow_back_sharp,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView(
        children: [
          Column(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('What is Nectar?'),
              NectarContainer(
                  child: Column(
                spacing: 18,
                children: [
                  Text('Nectar is a virtual cards collection app.'),
                  Text(
                      'You can add new cards by uploading an image or taking a photo, and the app will automatically transform into an Nectar Virtual Card (NVC).'),
                  Text(
                      'You can find all your cards in "Cards Collection" screen.')
                ],
              )),
              Text('What can become a card?'),
              NectarContainer(
                  child: Column(
                spacing: 18,
                children: [
                  Text(
                      'Nectar can extract information from an image of a business card containing personal or business information.'),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
