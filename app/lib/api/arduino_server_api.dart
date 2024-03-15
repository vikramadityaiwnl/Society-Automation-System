import 'dart:convert' as convert;
import 'dart:developer';

import 'package:app/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArduinoServerAPI {
  static String _baseUrlOne = 'http://192.168.14.221'; // Home - Gate
  static String _baseUrlTwo = 'http://192.168.14.202'; // Water - AQ
  static const timeout = Duration(seconds: 10);

  BuildContext context;

  ArduinoServerAPI({required this.context});

  Future<bool> getStatus() async {
    await getWeather();
    String msg = "";

    try {
      // Home
      final response = await http.get(Uri.parse('$_baseUrlOne/status')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      msg = json['message'];

      int led1 = int.parse(json['home']['led1']);
      int fan = int.parse(json['home']['fan']);
      Home home = Home(led1: led1, fan: fan);
      Status.setHome(home);

      // Environment
      final response2 = await http.get(Uri.parse('$_baseUrlTwo/aq')).timeout(timeout);
      final json2 = convert.jsonDecode(response2.body);

      int value = int.parse(json2['value']);
      String category = json2['category'];
      Color color = Color(int.parse(json2['color'].substring(1, 7), radix: 16) + 0xFF000000);

      Environment environment = Environment(value: value, category: category, color: color);
      Status.setEnvironment(environment);

      return true;
    } catch (e) {
      log(e.toString());
      msg = "Something went wrong! Please try again later.";
      return false;
    } finally {
      if (context.mounted) Toast.show(context, msg);
    }
  }

  Future<bool> changeHomeComponentState(String componenetName, bool value) async {
    String msg = "";
    try {
      final response = await http.get(Uri.parse('$_baseUrlOne/home/$componenetName/${value ? 'on' : 'off'}')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      msg = json['message'];

      return true;
    } catch (e) {
      log(e.toString());
      msg = "Something went wrong! Please try again later.";
      return false;
    } finally {
      if (context.mounted) Toast.show(context, msg);
    }
  }

  Future<bool> getWeather() async {
    const String url = 'https://api.openweathermap.org/data/2.5/weather?lat=18.454&lon=73.856&appid=e87b90bde14d5a74c1c6a16004c705f7';

    try {
      final response = await http.get(Uri.parse(url));
      final json = convert.jsonDecode(response.body);

      IconData icon;
      if (json['weather'][0]['main'] == "Clear") {
        icon = Icons.wb_sunny;
      } else if (json['weather'][0]['main'] == "Clouds") {
        icon = Icons.cloud;
      } else if (json['weather'][0]['main'] == "Rain") {
        icon = Icons.thunderstorm;
      } else if (json['weather'][0]['main'] == "Snow") {
        icon = Icons.ac_unit;
      } else {
        icon = Icons.cloud;
      }

      Status.setWeather(
        Weather(
          weatherName: json['weather'][0]['main'],
          temperature: "${(json['main']['temp'] - 273).toStringAsFixed(2)} °C",
          humidity: "${json['main']['humidity']} %",
          visibility: "${json['visibility'] / 1000} km",
          icon: icon,
        ),
      );
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<bool> getAirQuality() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrlTwo/aq')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      int value = int.parse(json['value']);
      String category = json['category'];
      Color color = Color(int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000);

      Environment environment = Environment(value: value, category: category, color: color);
      Status.setEnvironment(environment);

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> getWaterLevel() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrlTwo/water')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      double level = double.parse(json['water_level']);

      Water water = Water(level: level);
      Status.setWater(water);

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> openSecurityGate() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrlOne/gate')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  setBaseUrlOne(String baseUrl) {
    _baseUrlOne = 'http://$baseUrl';
  }

  setBaseUrlTwo(String baseUrl) {
    _baseUrlTwo = 'http://$baseUrl';
  }

  String getBaseUrlOne() {
    return _baseUrlOne;
  }

  String getBaseUrlTwo() {
    return _baseUrlTwo;
  }
}

class Status {
  static Home home = Home(led1: 0, fan: 0);
  static Environment environment = Environment(value: 0, category: '', color: Colors.white);
  static Weather weather = Weather(weatherName: '', temperature: '', humidity: '', visibility: '', icon: Icons.cloud);
  static Water water = Water(level: 0);

  static void setHome(Home home) {
    Status.home = home;
  }

  static void setEnvironment(Environment environment) {
    Status.environment = environment;
  }

  static void setWeather(Weather weather) {
    Status.weather = weather;
  }

  static void setWater(Water water) {
    Status.water = water;
  }
}

class Home {
  int led1;
  int fan;

  Home({required this.led1, required this.fan});
}

class Environment {
  int value;
  String category;
  Color color;

  Environment({required this.value, required this.category, required this.color});
}

class Water {
  double level;

  Water({required this.level});
}

class Weather {
  String weatherName;
  String temperature;
  String humidity;
  String visibility;
  IconData icon;

  Weather({required this.weatherName, required this.temperature, required this.humidity, required this.visibility, required this.icon});
}
