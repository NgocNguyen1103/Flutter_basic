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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.white38),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget con;
    switch (currentIndex) {
      case 0:
        con = Text("Home");
        break;
      case 1:
        con = Text("Profile");
        break;
      case 2:
        con = Text("Settings");
        break;
      default:
        con = Text("unknown");

        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Chatbot", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade800),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // ... more items
          ],
        ),
      ),

      body: Center(child: con),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },

        selectedIndex: currentIndex,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("Pressed");
        },
      ),
    );
  }
}
