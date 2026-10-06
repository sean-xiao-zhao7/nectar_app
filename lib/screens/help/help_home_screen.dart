import 'package:flutter/material.dart';
import 'package:nectar_app/components/layout/nectar_container.dart';
import 'package:nectar_app/components/layout/nectar_divider.dart';
import 'package:nectar_app/components/layout/nectar_scaffold_container.dart';

class HelpHomeScreen extends StatelessWidget {
  const HelpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return NectarScaffoldContainer(
      title: 'About Nectar',
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('What is Nectar?'),
              NectarContainer(
                  child: Column(
                spacing: 18,
                children: [
                  Text('Nectar is a virtual cards collection app.'),
                  NectarDivider(),
                  Text(
                      'You can add new cards by uploading an image or taking a photo, and the app will automatically transform it into an Nectar Virtual Card (NVC).'),
                  NectarDivider(),
                  Text(
                      'You can find all your cards in the "Cards Collection" screen.'),
                ],
              )),
              Text('What is a Nectar card?'),
              NectarContainer(
                  child: Column(
                spacing: 18,
                children: [
                  Text(
                      'Nectar can extract information from an image of a business card containing personal or business information.'),
                  NectarDivider(),
                  Text(
                      'The generated card can then be found in your "Cards Collection".')
                ],
              )),
              Text('Parts of Nectar'),
              NectarContainer(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 30,
                      children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Cards Collection',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' contains all cards you have saved.'),
                    ])),
                    NectarDivider(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'My Cards',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' contains cards representing yourself that you want to share with others.'),
                    ])),
                    NectarDivider(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Add A New Card',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ' allows you to scan and save a new card.'),
                    ])),
                  ])),
              Text('Card Creation'),
              NectarContainer(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 30,
                      children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'AI Card Scanner',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' automatically extracts contact details, company information, and social media handles from card photos using Gemini AI.'),
                    ])),
                    NectarDivider(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Manual Creation',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' allows you to create and customize virtual cards field-by-field without scanning an image.'),
                    ])),
                  ])),
              Text('Card Actions & Sharing'),
              NectarContainer(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 30,
                      children: [
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Quick Actions',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' lets you tap phone numbers, email addresses, and social links to launch apps directly.'),
                    ])),
                    NectarDivider(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'Save to Contacts',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' allows you to export card information directly to your phone\'s address book with a single tap.'),
                    ])),
                    NectarDivider(),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: 'QR Code Sharing',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(
                          text:
                              ' displays a QR code for each virtual card for fast in-person networking and exchange.'),
                    ])),
                  ]))
            ],
          ),
        ],
      ),
    );
  }
}
