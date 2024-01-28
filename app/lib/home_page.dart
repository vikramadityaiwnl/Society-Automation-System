import 'package:app/api/arduino_server_api.dart';
import 'package:app/fragments/automation_fragment.dart';
import 'package:app/fragments/environment_fragment.dart';
import 'package:app/fragments/water_fragment.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _fragmentIndex = 0;
  final List<Widget> _fragments = <Widget>[
    const AutomationFragment(),
    const WaterFragment(),
    const EnvironmentFragment(),
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await ArduinoServerAPI(context: context).getStatus();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Society Automation App'), actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          tooltip: 'Notifications',
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.admin_panel_settings),
          tooltip: 'Admin Login',
          onPressed: () {},
        ),
      ]),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _fragments[_fragmentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.memory),
            label: 'Automation',
            tooltip: 'Automation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Water',
            tooltip: 'Water',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Environment',
            tooltip: 'Environment',
          ),
        ],
        currentIndex: _fragmentIndex,
        onTap: (int index) {
          setState(() {
            _fragmentIndex = index;
          });
        },
      ),
    );
  }
}
