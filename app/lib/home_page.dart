import 'package:app/api/arduino_server_api.dart';
import 'package:app/api/users.dart';
import 'package:app/fragments/automation_fragment.dart';
import 'package:app/fragments/environment_fragment.dart';
import 'package:app/fragments/water_fragment.dart';
import 'package:app/profile_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final bool isAdmin;
  final User user;
  const HomePage({Key? key, required this.user, required this.isAdmin}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  bool isAdmin = false;
  User user = Users.emptyUser();

  int _fragmentIndex = 0;
  final List<Widget> _adminFragments = <Widget>[
    const AutomationFragment(),
    const WaterFragment(),
    const EnvironmentFragment(),
  ];
  final List<Widget> _residentFragments = <Widget>[
    const AutomationFragment(),
    const EnvironmentFragment(),
  ];

  @override
  void initState() {
    super.initState();

    isAdmin = widget.isAdmin;
    user = widget.user;

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
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(user: user)));
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : isAdmin
              ? _adminFragments[_fragmentIndex]
              : _residentFragments[_fragmentIndex],
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
