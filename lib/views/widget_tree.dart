import 'package:flutter/material.dart';
import 'package:flutter_one/widgets/navbar_widget.dart';
import 'package:flutter_one/views/pages/home_page.dart';
import 'package:flutter_one/views/pages/profile_page.dart';
List<Widget> pages = [
  HomePage(),
  ProfilePage()
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Chatbot"), centerTitle: true),
        body: pages.elementAt(1),
        bottomNavigationBar: NavbarWidget()
    );
  }
}
