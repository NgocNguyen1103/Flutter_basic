import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }
}
