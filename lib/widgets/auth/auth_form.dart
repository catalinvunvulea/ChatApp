import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        color: Colors.yellow[50],
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email address'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    'Create new account',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
