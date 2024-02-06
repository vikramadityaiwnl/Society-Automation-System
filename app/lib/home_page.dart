import 'package:app/api/arduino_server_api.dart';
import 'package:app/fragments/automation_fragment.dart';
import 'package:app/fragments/environment_fragment.dart';
import 'package:app/fragments/water_fragment.dart';
import 'package:app/settings_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isAdmin;
  const HomePage({Key? key, required this.isAdmin}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isAdmin = false;

  int _fragmentIndex = 0;
  final List<Widget> _fragments = <Widget>[
    const AutomationFragment(),
    const WaterFragment(),
    const EnvironmentFragment(),
  ];

  @override
  void initState() {
    super.initState();

    isAdmin = widget.isAdmin;

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
      appBar: AppBar(
        title: const Text('Society Automation App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Setting',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _fragments[_fragmentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.memory),
            label: 'Automation',
            tooltip: 'Automation',
          ),
          if (isAdmin)
            const BottomNavigationBarItem(
              icon: Icon(Icons.water_drop),
              label: 'Water',
              tooltip: 'Water',
            ),
          const BottomNavigationBarItem(
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
