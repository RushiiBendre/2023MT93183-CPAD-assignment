// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_element, prefer_const_constructors, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:bits_quicktask/main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController(); // Add email controller
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _registerUser() async {
    try {
      final user = ParseUser(_usernameController.text, _passwordController.text, _emailController.text); // Provide email
      await user.signUp();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
      // Navigate to home screen or show success message
    } catch (e) {
      // Handle registration errors
      print('Registration Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text('Quick Task - Register', style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(33, 150, 243, 1))),
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: const Text('Enter your details',
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 42, 42, 42))),
              ),
              SizedBox(
                height: 26,
              ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController, // Add email field
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(
                height: 26,
              ),
            ElevatedButton(
              onPressed: doUserRegistration,
              child: Text('Register',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 42, 42, 42))),
            ),
          ],
        ),
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())); // Navigate to login page
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void doUserRegistration() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      showSuccess("User was successfully created!"); // Pass the success message
    } else {
      showError(response.error!.message);
    }
  }
}