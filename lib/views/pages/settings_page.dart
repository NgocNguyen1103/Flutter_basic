import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.title});

  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("AlertDialog"),
                      content: Text("Alert Content"),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("close"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Open dialog"),
            ),
            Divider(
              color: Colors.teal,
              thickness: 4.0,
              endIndent: 200.0,
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(border: UnderlineInputBorder()),
              onEditingComplete: () => setState(() {}),
            ),
            //
            Checkbox(
              tristate: true,
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                  print(value);
                });
              },
            ),
            CheckboxListTile(
              tristate: true,
              title: Text("CheckboxListTile"),
              subtitle: Text("subtitle"),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool value) {
                setState(() {
                  isSwitch = value;
                });
              },
            ),
            SwitchListTile(
              title: Text("SwitchListTile"),
              subtitle: Text("subtitle"),
              value: isSwitch,
              onChanged: (bool value) {
                setState(() {
                  isSwitch = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
