import 'dart:async';

import 'package:app/api/arduino_server_api.dart';
import 'package:flutter/material.dart';

class WaterFragment extends StatefulWidget {
  const WaterFragment({Key? key}) : super(key: key);

  @override
  State<WaterFragment> createState() => WaterFragmentState();
}

class WaterFragmentState extends State<WaterFragment> {
  Water water = Water(
    level: 0,
  );
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await ArduinoServerAPI(context: context).getWaterLevel();

      setState(() {
        water = Status.water;
      });
    });
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
                    'Water Automation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.water),
                ),
                ListTile(
                  title: const Text('Water Level'),
                  subtitle: LinearProgressIndicator(
                    value: water.level,
                    color: Colors.blue,
                    backgroundColor: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  trailing: Text(
                    '${water.level}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                const ListTile(
                  title: Text('Water Flow'),
                  subtitle: Text('Water Flow in your tank.'),
                  trailing: Text(
                    '10.0 LPM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
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
