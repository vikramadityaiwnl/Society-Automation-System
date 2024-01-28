import 'package:flutter/material.dart';

class WaterFragment extends StatefulWidget {
  const WaterFragment({Key? key}) : super(key: key);

  @override
  State<WaterFragment> createState() => WaterFragmentState();
}

class WaterFragmentState extends State<WaterFragment> {
  double _waterLevelLimit = 50;
  final double _minWaterLevelLimit = 20;

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
                    value: 0.5,
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  trailing: const Text(
                    '50%',
                    style: TextStyle(
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
          const SizedBox(height: 16),
          waterPump(),
        ],
      ),
    );
  }

  Card waterPump() {
    return Card(
      child: Column(
        children: [
          const ListTile(
            title: Text(
              'Water Automation Settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(Icons.water_damage_outlined),
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Limit Water Level'),
            subtitle: Slider(
              value: _waterLevelLimit,
              onChanged: (value) {
                if (value < _minWaterLevelLimit) return;

                setState(() {
                  _waterLevelLimit = value;
                });
              },
              max: 100,
              divisions: 10,
              label: '$_waterLevelLimit%',
            ),
            trailing: Text(
              '$_waterLevelLimit%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
