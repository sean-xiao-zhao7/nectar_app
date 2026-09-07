import 'package:flutter/material.dart';
import 'package:nectar_app/components/text/my_regular_text.dart';

class MyScreenBottom extends StatelessWidget {
  const MyScreenBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: MyRegularText(
          '\u00a9 2026 Nectar Inc.',
        ));
  }
}
