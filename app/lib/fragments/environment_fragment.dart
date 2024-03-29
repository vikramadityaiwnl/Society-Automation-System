import 'dart:async';

import 'package:app/api/arduino_server_api.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class EnvironmentFragment extends StatefulWidget {
  const EnvironmentFragment({super.key});

  @override
  State<EnvironmentFragment> createState() => _EnvironmentFragmentState();
}

class _EnvironmentFragmentState extends State<EnvironmentFragment> {
  Weather weather = Weather(
    weatherName: 'Unknown',
    temperature: '',
    humidity: '',
    visibility: '',
    icon: Icons.cloud,
  );
  Environment environment = Environment(
    value: -1,
    category: 'Unknown',
    color: Colors.white,
  );

  Timer? timer;

  @override
  void initState() {
    super.initState();

    setState(() {
      if (Status.weather.weatherName.isEmpty && Status.environment.category.isEmpty) return;

      weather = Status.weather;
      environment = Status.environment;
    });

    timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await ArduinoServerAPI(context: context).getAirQuality();

      setState(() {
        environment = Status.environment;
      });

      if (environment.value == 0) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Air Quality Alert',
            body: 'Air quality in your environment is bad.',
          ),
        );
      }
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
                ListTile(
                  title: Text(
                    weather.weatherName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(weather.icon),
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  title: const Text('Temperature'),
                  subtitle: const Text('Temperature in your environment.'),
                  trailing: Text(
                    weather.temperature,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Humidity'),
                  subtitle: const Text('Humidity in your environment.'),
                  trailing: Text(
                    weather.humidity,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Visibility'),
                  subtitle: const Text('Visibility in your environment.'),
                  trailing: Text(
                    weather.visibility,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    environment.category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Air Quality'),
                  subtitle: const Text('Air quality in your environment is moderate.'),
                  trailing: Text(
                    '${environment.value == 1 ? "LOW" : "HIGH"} PPM',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  title: const Text('Status'),
                  subtitle: LinearProgressIndicator(
                    value: 1,
                    color: environment.color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
