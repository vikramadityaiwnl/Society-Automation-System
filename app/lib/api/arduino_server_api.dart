import 'dart:convert' as convert;
import 'dart:developer';

import 'package:app/helper/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArduinoServerAPI {
  static const String _baseUrl = 'http://192.168.0.108';
  static const timeout = Duration(seconds: 10);

  BuildContext context;

  ArduinoServerAPI({required this.context});

  Future<bool> getStatus() async {
    String msg = "";

    try {
      final response = await http.get(Uri.parse('$_baseUrl/status')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      log(json.toString());

      if (json == null || json['success'] != "true") return false;

      await getWeather();

      msg = json['message'];

      int led1 = int.parse(json['home']['led1']);
      Home home = Home(led1: led1);
      Status.setHome(home);

      int value = int.parse(json['env']['value']);
      String category = json['env']['category'];
      Color color = Color(int.parse(json['env']['color'].substring(1, 7), radix: 16) + 0xFF000000);
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
      final response = await http.get(Uri.parse('$_baseUrl/home/$componenetName/${value ? 'on' : 'off'}')).timeout(timeout);
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
      final response = await http.get(Uri.parse('$_baseUrl/env/aq')).timeout(timeout);
      final json = convert.jsonDecode(response.body);

      if (json == null || json['success'] != "true") return false;

      // msg = json['message'];

      int value = int.parse(json['value']);
      String category = json['category'];
      Color color = Color(int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000);

      Environment environment = Environment(value: value, category: category, color: color);
      Status.setEnvironment(environment);

      return true;
    } catch (e) {
      log(e.toString());
      // msg = "Something went wrong! Please try again later.";
      return false;
    }
  }
}

class Status {
  static Home home = Home(led1: 0);
  static Environment environment = Environment(value: 0, category: '', color: Colors.white);
  static Weather weather = Weather(weatherName: '', temperature: '', humidity: '', visibility: '', icon: Icons.cloud);

  static void setHome(Home home) {
    Status.home = home;
  }

  static void setEnvironment(Environment environment) {
    Status.environment = environment;
  }

  static void setWeather(Weather weather) {
    Status.weather = weather;
  }
}

class Home {
  int led1;

  Home({required this.led1});
}

class Environment {
  int value;
  String category;
  Color color;

  Environment({required this.value, required this.category, required this.color});
}

class Weather {
  String weatherName;
  String temperature;
  String humidity;
  String visibility;
  IconData icon;

  Weather({required this.weatherName, required this.temperature, required this.humidity, required this.visibility, required this.icon});
}
