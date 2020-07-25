import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<
      FormState>(); //we create this key and will connect it to the form, to then trigger the validators + etc when we press the login btn

  var _isLoginMode = true;
  var userEmail = '';
  var userName = '';
  var userPassword = '';

  void _tryValidate() {
    final isValid = _formKey.currentState
        .validate(); //when called, will try to validate all the validators from the form (where this _formKey was addet)
    FocusScope.of(context)
        .unfocus(); //to remove the focus from any selected field and close the keyboard

    if (isValid) {
      //will be valid only if all the validators from the form (textFIleds) will return null
      _formKey.currentState
          .save(); //it will go through all the textFileds fomr the form and it will trigger onSaved
      //after the input values are saved, we can use the values to send our auth to firebase
      print(userEmail);
      print(userName);
      print(userPassword);
    }
  }

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
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: ValueKey(
                      'email'), //this key is given for when the screen is rebuilt, as we have the same widget (textField) multiple times, and flutter might wrongly alocate the data when rebuilt (explained at the beginning of the classes)
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null; //if everithing is ok
                  },
                  onSaved: (value) {
                    //value = user Input text
                    userEmail =
                        value; //we don't use set state here because when we change the value of this var, the screen will stay the same
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                if (!_isLoginMode)
                  TextFormField(
                    key: ValueKey('user'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Please enter at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userName = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'User Name',
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
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Password has to contain at least 7 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    userPassword = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Add at least 7 characters',
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                  obscureText: true, //hide the inputText -as password
                ),
                if (!_isLoginMode) SizedBox(height: 12),
                if (!_isLoginMode)
                  TextFormField(
                    key: ValueKey('retypepassword'),
                    decoration: InputDecoration(
                      labelText: 'Re-type password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty || value != userPassword) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                    obscureText: true,
                  ),
                SizedBox(height: 12),
                RaisedButton(
                  child: Text(_isLoginMode ? 'Login' : 'Signup'),
                  onPressed: _tryValidate,
                ),
                FlatButton(
                  textColor: Colors.purple,
                  child: Text(_isLoginMode
                      ? 'Create new account'
                      : 'Already have an account'),
                  onPressed: () {
                    setState(() {
                      _isLoginMode = !_isLoginMode;
                    });
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
