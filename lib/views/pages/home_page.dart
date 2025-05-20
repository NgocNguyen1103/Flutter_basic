import 'package:flutter/material.dart';
import 'package:flutter_one/data/Constants.dart';
import 'package:flutter_one/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          HeroWidget(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Card", style: KTextStyle.titleTealText),
                    Text("Description of this card", style: KTextStyle.descriptionText),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
