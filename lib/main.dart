import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
//String? tille = "Flutter A"; //String? :this value can be null

// stateless: screen cannot refresh
// stateful: screen can refresh
// setstate: to refresh the screen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme opf application
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter App"), centerTitle: true),
      body:
          curentIndex == 0
              ? Center(child: Text("1"))
              : Center(child: Text("2")),
      //tille!: ennsure the variable is not null
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
        ],
        onDestinationSelected: (int value) {
          setState(() {
            curentIndex = value;
          });
        },
        selectedIndex: curentIndex,
      ),
    );
  }
}
