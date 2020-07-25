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
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.all(20),
        color: Colors.white,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  obscureText: true, //hide the inputText -as password
                ),
                SizedBox(height: 12),
                RaisedButton(
                  child: const Text('Login'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    'Create new account',
                    style: TextStyle(color: Theme.of(context).accentColor),
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
