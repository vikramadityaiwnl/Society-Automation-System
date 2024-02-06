import 'package:app/helper/custom_dialog.dart';
import 'package:app/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isAdmin = false;

  CustomDialog? customDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Welcome to Smart Society Automation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Please enter your username and password to login as ${_isAdmin ? 'Admin' : 'User'}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Username',
                        prefixIcon: Icon(_isAdmin ? Icons.admin_panel_settings : Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () async {
                        customDialog!.showLoadingDialog();
                        await Future.delayed(const Duration(seconds: 2));
                        customDialog!.dismiss();

                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(isAdmin: _isAdmin)),
                        );
                      },
                      icon: const Icon(Icons.login),
                      label: Text('${_isAdmin ? 'Admin' : 'User'} Login'),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () {
                        setState(() {
                          _isAdmin = !_isAdmin;
                        });
                      },
                      icon: Icon(_isAdmin ? Icons.person : Icons.admin_panel_settings),
                      label: Text('Login as ${_isAdmin ? 'User' : 'Admin'}'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    customDialog = CustomDialog(context: context);
  }
}
