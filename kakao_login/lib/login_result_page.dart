import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final String username;
  final String useremail;
  const Login(this.username, this.useremail);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Text(widget.useremail),
              Text(widget.username),
            ],
          ),
        ),
      ),
    );
  }
}
