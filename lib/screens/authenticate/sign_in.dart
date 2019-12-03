import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text fields state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            label: Text("Register"),
            icon: Icon(Icons.person),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) {
                    if (val.length < 6) {
                      return 'Enter password with more than 6+ characters';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "Something went wrong!!";
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          )),
    );
  }
}
