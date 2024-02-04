import 'package:app/api/arduino_server_api.dart';
import 'package:flutter/material.dart';

class AutomationFragment extends StatefulWidget {
  const AutomationFragment({super.key});

  @override
  State<AutomationFragment> createState() => AutomationFragmentState();
}

class AutomationFragmentState extends State<AutomationFragment> {
  bool _led1 = false;

  @override
  void initState() {
    super.initState();

    _led1 = Status.home.led1 == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Card(
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.home),
                ),
                ListTile(
                  title: const Text('LED 1'),
                  subtitle: const Text('Control the LED 1 of your home.'),
                  trailing: Switch(
                    value: _led1,
                    onChanged: (value) async {
                      if (!await ArduinoServerAPI(context: context).changeHomeComponentState('led1', value)) return;

                      Status.home.led1 = value ? 1 : 0;
                      setState(() {
                        _led1 = value;
                      });
                    },
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('FAN'),
                  subtitle: const Text('Control the FAN of your home.'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) async {},
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('LED 2'),
                  subtitle: const Text('Control the LED 2 of your home.'),
                  trailing: Switch(
                    value: false,
                    onChanged: (value) async {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
