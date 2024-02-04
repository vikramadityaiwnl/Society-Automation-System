import 'package:app/api/arduino_server_api.dart';
import 'package:app/helper/custom_dialog.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      'Server Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Icon(Icons.dns),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 10),
                  ListTile(
                    title: const Text('Server One'),
                    subtitle: TextButton(
                      onPressed: () {
                        CustomDialog.showCustomDialogWithInput(context, 'Configure Server One', 'Enter the server IP', (String input) {
                          if (input.isEmpty) return;

                          ArduinoServerAPI(context: context).setBaseUrlOne(input);
                          setState(() {});
                        });
                      },
                      child: Text(ArduinoServerAPI(context: context).getBaseUrlOne()),
                    ),
                  ),
                  ListTile(
                    title: const Text('Server Two'),
                    subtitle: TextButton(
                      onPressed: () {
                        CustomDialog.showCustomDialogWithInput(context, 'Configure Server Two', 'Enter the server IP', (String input) {
                          if (input.isEmpty) return;

                          ArduinoServerAPI(context: context).setBaseUrlTwo(input);
                          setState(() {});
                        });
                      },
                      child: Text(ArduinoServerAPI(context: context).getBaseUrlTwo()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
