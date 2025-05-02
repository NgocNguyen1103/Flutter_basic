import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//stateless: screen not change
//material app
//scaffold: skeleton of the app

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme opf application
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter App"), centerTitle: true),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
          ],
          onDestinationSelected: (int value) {
            print(value);
          },
          selectedIndex: 0,
        ),
      ),

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}
